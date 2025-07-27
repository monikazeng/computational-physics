function ising(m,seed)
    % Set the Temperature values to compute
    Tstart = 1;
    Tend = 5;
    Tstep = 0.2;
    Temps = Tstart:Tstep:Tend;
    % Storage for various expectation values at each temperature
    M = zeros(length(Temps),1);
    MM = zeros(length(Temps),1);
    E = zeros(length(Temps),1);
    EE = zeros(length(Temps),1);
    Cv = zeros(length(Temps),1);
    Ms = zeros(length(Temps),1);
    % Loop over all temperatures
    for k=1:length(Temps)
        % Create the Class for the Lattice
        lat = lattice(Temps(k),m,seed);
        % Call the routine to carry out the relaxation and 
        % measurement sweeps
        Tising(lat,Temps(k),m);
        % Gather the data and save into the arrays.
        [M(k),MM(k),E(k),EE(k)] = lat.CollectData();
      	 Ms(k) = (MM(k) -M(k)*M(k)*m^2)/Temps(k);
        Cv(k) = (EE(k)-E(k)*E(k)*m^2)/(Temps(k)*Temps(k));
        % Display the information
        fprintf(' T= %f: |M|= %f, E = %f: Ms = %f, C_v = %f \n',Temps(k),abs(M(k)),E(k),Ms(k),Cv(k) );
        lat.image();
        title(sprintf('T = %f\n',Temps(k)));
        pause(0.05);
    end
    % Plot the various physical quantities vs temperature
    % Energy
    figure(2);
    hold on;
    scatter(Temps,E,'filled');
    plot(Temps,E);
    xlabel('T');
    ylabel('\langle{E}\rangle');
    title('Energy per spin');
    grid on;
    line([0,0], ylim, 'Color', 'k', 'LineWidth', 1);
    line(xlim, [0,0], 'Color', 'k', 'LineWidth', 1);
    hold off;

    % Magnetization
    figure(3);
    hold on;
    scatter(Temps,abs(M),'filled');
    plot(Temps,abs(M));
    xlabel('T');
    ylabel('|\langle{M}\rangle{}|');
    title('Magnetization per spin');
    grid on;
    line([0,0], ylim, 'Color', 'k', 'LineWidth', 1);
    line(xlim, [0,0], 'Color', 'k', 'LineWidth', 1);
    hold off;
 
    % Specific heat
    figure(4);
    hold on;
    scatter(Temps,Cv,'filled');
    plot(Temps,Cv);
    xlabel('T');
    ylabel('C_v');
    title('Specific Heat');
    grid on;
    line([0,0], ylim, 'Color', 'k', 'LineWidth', 1);
    line(xlim, [0,0], 'Color', 'k', 'LineWidth', 1);
    hold off;
    
    % Magnetic Susceptibility
    figure(5);
    hold on;
    scatter(Temps,Ms,'filled');
    plot(Temps,Ms);
    xlabel('T');
    ylabel('\chi');
    title('Magnetic Susceptibility');
    grid on;
    line([0,0], ylim, 'Color', 'k', 'LineWidth', 1);
    line(xlim, [0,0], 'Color', 'k', 'LineWidth', 1);
    hold off;
    
%     writematrix(Temps, 'temperature.txt');
%     writematrix(E, 'energy.txt');
%     writematrix(M, 'magnetization.txt');
%     writematrix(Cv, 'specific_heat.txt');
%     writematrix(Ms, 'mag_susceptibility.txt');
end

function Tising(lat,T,m)
    figure(1);
    hold on
    lat.image;
    title(sprintf('T = %f\n',T));
    % Sweep to allow the system to come to equilibrium
    fprintf('Thermalize----\n');
    for k=1:1000
        lat.sweep;
        if mod(k,10)==0
            lat.image;
            fprintf('%5i: |M|= %f, E = %f\n',k,abs(lat.Magnetization),lat.Energy);
        end
    end
    figure(1);
    lat.image();
    % Sweep to collect the data
    fprintf('Collect Data\n');
    for k=1:5000
        lat.sweep;
        if mod(k,50)==0
            lat.stat();
        end
        if mod(k,50)==0
            figure(1);
            lat.image;
            fprintf('%5i: |M|= %f, E = %f\n',k,abs(lat.Magnetization),lat.Energy);
        end
    end
    hold off
end
