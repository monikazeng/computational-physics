classdef lattice < handle
    % Class to store a 2-D lattice of "spins" and methods to perform
    % lattice update "sweeps", plot the lattice, and accumulate statistics.
    % 
    properties
        T    % Lattice temperature
        data % The 2-D lattice data (stores +1 or -1 in each location)
        ran  % The random number generator to use
        m    % The size of the lattice (m rows and m columns)   5
        count   % number of times stat is called
        Eacc    % accumulated E
        Eacc2   % accumulated E^2
        Macc    % accumulated M
        Macc2   % accumulated M^2

    end
    methods
        function obj = lattice(T,m,seed)
            % Constructor
            obj.T = T;
            obj.m = m;
            obj.data = zeros(m,m);
            obj.ran = NumericalRecipes.Ran(seed);
            obj.count = 0;
            obj.Eacc = 0;
            obj.Eacc2 = 0; 
            obj.Macc = 0;  
            obj.Macc2 = 0;
            % for loop for populating lattice data
            for i = 1:m
                for j = 1:m
                    % obj.ran.doub is a random double between 0 and 1
                    val = 2*round(obj.ran.doub)-1;
                    obj.data(i,j) = val;
                end
            end
        end
        %
        function M = Magnetization(obj)
            % Compute and return the magnetization/spin of the current
            % lattice 
            M = 0;
            for i = 1:obj.m
                for j = 1:obj.m
                    M = M + obj.data(i,j);
                end
            end
            M = abs(M / (obj.m * obj.m));
         end
        %
        function E = Energy(obj)
            % Compute and return the energy/spin of the current
            % lattice 
            E = obj.energy();
            E = E / (obj.m * obj.m);
        end
        %
%         function e = energy(obj)
%             % Compute and return the total energy of the current lattice
%             e = 0;
%             J = 1;
%             for i = 1:obj.m
%                 for j = 1:obj.m
%                     if i == obj.m && j == obj.m
%                         e = e + obj.data(i,j)*(obj.data(1,j)+obj.data(i,1));        
%                     elseif i == obj.m
%                         e = e + obj.data(i,j)*(obj.data(1,j)+obj.data(i,j+1));
%                     elseif j == obj.m
%                         e = e + obj.data(i,j)*(obj.data(i+1,j)+obj.data(i,1));
%                     else
%                         e = e + obj.data(i,j)*(obj.data(i+1,j)+obj.data(i,j+1));
%                     end
%                 end
%             end
%             e = -J * e;
%         end
        function e = energy(obj)
            e=0;
            for i=1:obj.m
                di=i+1;
                if i==obj.m
                    di=1;
                end
                for j=1:obj.m
                    dj=j+1;
                    if j==obj.m
                        dj=1;
                        di=1;
                    end
                    e=e-(obj.data(i,j)*(obj.data(di,j)+obj.data(i,dj)));
                end
            end
        end
        %
        function sweep(obj)
            % Apply the Metropolis algorithm to m*m randomly chosen spins.
            % 
            for i = 1:(obj.m)^2
                rand1 = 0;
                rand2 = 0;
                while rand1 == 0
                    rand1 = ceil(obj.ran.doub * obj.m);
                end
                while rand2 == 0
                    rand2 = ceil(obj.ran.doub * obj.m);
                end
                delE = obj.DeltaEnergy(rand1,rand2);
                if delE < 0
                    old_val = obj.data(rand1, rand2);
                    obj.data(rand1, rand2) = -1 * old_val;
                elseif exp(-delE/obj.T) > obj.ran.doub
                    old_val = obj.data(rand1, rand2);
                    obj.data(rand1, rand2) = -1 * old_val;
                end  
            end
        end
        %
%         function de = DeltaEnergy(obj,i,j)
%             % Compute the change in the energy if the spin at lattice site
%             % (i,j) flips
%             de = 0;
%             J = 1;
%             if i == 1 && j == 1
%                 de = 2*J*obj.data(i,j)*(obj.data(i+1,j)+obj.data(obj.m,j)+obj.data(i,j+1)+obj.data(i,obj.m));
%             elseif i == obj.m && j == obj.m
%                 de = 2*J*obj.data(i,j)*(obj.data(1,j)+obj.data(i-1,j)+obj.data(i,1)+obj.data(i,j-1));
%             elseif i == 1 && j == obj.m
%                 de = 2*J*obj.data(i,j)*(obj.data(i+1,j)+obj.data(obj.m,j)+obj.data(i,1)+obj.data(i,j-1));
%             elseif i == obj.m && j == 1
%                 de = 2*J*obj.data(i,j)*(obj.data(1,j)+obj.data(i-1,j)+obj.data(i,j+1)+obj.data(i,obj.m));
%             elseif i == 1
%                 de = 2*J*obj.data(i,j)*(obj.data(i+1,j)+obj.data(obj.m,j)+obj.data(i,j+1)+obj.data(i,j-1));
%             elseif j == 1
%                 de = 2*J*obj.data(i,j)*(obj.data(i+1,j)+obj.data(i-1,j)+obj.data(i,j+1)+obj.data(i,obj.m));
%             elseif i == obj.m
%                 de = 2*J*obj.data(i,j)*(obj.data(1,j)+obj.data(i-1,j)+obj.data(i,j+1)+obj.data(i,j-1));
%             elseif j == obj.m
%                 de = 2*J*obj.data(i,j)*(obj.data(i+1,j)+obj.data(i-1,j)+obj.data(i,1)+obj.data(i,j-1));
%             else 
%                 de = 2*J*obj.data(i,j)*(obj.data(i+1,j)+obj.data(i-1,j)+obj.data(i,j+1)+obj.data(i,j-1));
%             end
%         end
        %
        function de = DeltaEnergy(obj,i,j)
            diplus=i+1;
            diminus=i-1;
            if i==1
                diminus=obj.m;
            elseif i==obj.m
                diplus=1;
            end

            djplus=j+1;
            djminus=j-1;
            if j==1
                djminus=obj.m;
            elseif j==obj.m
                djplus=1;
            end
            de=2*(obj.data(i,j)*(obj.data(diplus,j)+obj.data(diminus,j)+obj.data(i,djplus)+obj.data(i,djminus)));
        end

        function stat(obj)
%             Collect statistics for the current state of the lattice
%             obj.count = obj.count + 1;
%             obj.Eacc = obj.Eacc + obj.Energy();
%             obj.Eacc2 = obj.Eacc2 + (obj.Energy())^2;
%             obj.Macc = obj.Macc + obj.Magnetization();
%             obj.Macc2 = obj.Macc2 + (obj.Magnetization())^2;
            obj.count = obj.count + 1;
            obj.Eacc = obj.Eacc + obj.Energy();
            obj.Eacc2 = obj.Eacc2 + ((obj.Energy())^2) * (obj.m)^2;
            obj.Macc = obj.Macc + obj.Magnetization();
            obj.Macc2 = obj.Macc2 + ((obj.Magnetization())^2) * (obj.m)^2;
        end
        %
        function resetstats(obj)
            % Reset the accumulated statistics to zero.
            obj.count = 0;
            obj.Eacc = 0;
            obj.Eacc2 = 0;
            obj.Macc = 0;
            obj.Macc2 = 0;
        end         
        %
        function [M,MM,E,EE] = CollectData(obj)
            % return the expectation values <M>, <M^2>, <E>, and <E^2>
            M = obj.Macc/obj.count;
            MM = obj.Macc2/obj.count;
            E = obj.Eacc/obj.count;
            EE = obj.Eacc2/obj.count;
        end
        %
        function image(obj)
            % Produce a visualization of the lattice
            img = uint8(floor(0.5*(obj.data+1.0)));
            colormap([0 0 1;1 0 0]);
            image(img);
            pause(0.05);
        end
    end
end