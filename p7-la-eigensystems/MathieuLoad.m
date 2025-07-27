% classdef MathieuLoad < NumericalRecipes.FunctorShoot
%     methods(Static)
%         function y = vector(t,v)
%             % v(1) =  a
%             % y(1) = Y, y(2)=Z, y(3)=a
%             y(1) = 1.0;         % Y
%             y(2) = 0.0;         % Z
%             y(3) = v(1);        % a
%         end
%     end
% end


classdef MathieuLoad < NumericalRecipes.FunctorShoot
    properties
        even
    end
    methods
        function obj = MathieuLoad(even)
            obj.even = even;
        end
        function y = vector(obj,t,v)
            % v(1) =  a
            % y(1) = Y, y(2)=Z, y(3)=a
            if obj.even
                y(1) = 1.0;         % Y
                y(2) = 0.0;         % Z
                y(3) = v(1);        % a
            else
                y(1) = 0.0;         % Y
                y(2) = 1.0;         % Z
                y(3) = v(1);        % a
            end
        end
    end
end