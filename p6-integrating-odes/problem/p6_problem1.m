clear
%%% Problem 1
atol = 1.0e-9;
rtol = atol;
h1 = 0.01;
hmin = 0.0;
% initial condition
x1 = 1.0;
x2 = 30.0;
y1start = besselj(1,x1);
y2start = besselj(0,x1) - besselj(1,x1)/x1;
ystart = [y1start, y2start];

outsdp = NumericalRecipes.Output(-1);
outsbs = NumericalRecipes.Output(-1);
d_dp = BesselFunctionODE();
d_bs = BesselFunctionODE();
odedp = NumericalRecipes.Odeint(NumericalRecipes.StepperDopr5(),ystart,x1,x2,atol,rtol,h1,hmin,outsdp,d_dp);
odebs = NumericalRecipes.Odeint(NumericalRecipes.StepperBS(),ystart,x1,x2,atol,rtol,h1,hmin,outsbs,d_bs);
odedp.integrate;
odebs.integrate;

% ouput the counter value for Runge-Kutta (Dormand-Prince) and Bulirsch-Stoer
d_dp.counter
d_bs.counter

% plotting x and y1(x) (y(x))
figure(1)
plot(outsdp.xsave(1:outsdp.count),outsdp.ysave(1:outsdp.count,1))
hold on
plot(outsbs.xsave(1:outsbs.count),outsbs.ysave(1:outsbs.count,1))
xlabel('x');
ylabel('y_1');
legend('Dormand-Prince5','Bulirsch-Stoer')
title('Integration of Bessel J1 -- y(x)')
hold off

% plotting x and y2(x) (z(x))
figure(2)
plot(outsdp.xsave(1:outsdp.count),outsdp.ysave(1:outsdp.count,2))
hold on
plot(outsbs.xsave(1:outsbs.count),outsbs.ysave(1:outsbs.count,2))
xlabel('x');
ylabel('y_2');
legend('Dormand-Prince5','Bulirsch-Stoer')
title('Integration of Bessel J1 -- z(x)')
hold off
if outsdp.count == outsbs.count
    figure(3)
    plot(outsdp.xsave(1:outsdp.count),outsdp.ysave(1:outsdp.count,1)-outsbs.ysave(1:outsbs.count,1))
    xlabel('x');
    ylabel('\delta y_1');
end


% plotting J1 and Dormand-Prince5
figure(3)
plot(outsdp.xsave(1:outsdp.count),outsdp.ysave(1:outsdp.count,1))
hold on
% x = linspace(1,30,outsdp.count);
bejdp = besselj(1,outsdp.xsave(1:outsdp.count));
plot(outsdp.xsave(1:outsdp.count),bejdp)
xlabel('x');
ylabel('y_1');
legend('J1','Dormand-Prince5')
title('Bessel J1 y(x)')
hold off

% plotting J1 and Bulirsch-Stoer
figure(4)
plot(outsbs.xsave(1:outsbs.count),outsbs.ysave(1:outsbs.count,1))
hold on
% x = linspace(1,30,outsbs.count);
bejbs = besselj(1,outsbs.xsave(1:outsbs.count));
plot(outsbs.xsave(1:outsbs.count),bejbs)
xlabel('x');
ylabel('y_1');
legend('J1','Bulirsch-Stoer')
title('Bessel J1 y(x)')
hold off


% plotting difference between Dormand-Prince5 and Bulirsch-Stoer
% using 100 evenly spaced points
outsdp = NumericalRecipes.Output(100);
outsbs = NumericalRecipes.Output(100);
d = BesselFunctionODE();
odedp = NumericalRecipes.Odeint(NumericalRecipes.StepperDopr5(),ystart,x1,x2,atol,rtol,h1,hmin,outsdp,d);
odebs = NumericalRecipes.Odeint(NumericalRecipes.StepperBS(),ystart,x1,x2,atol,rtol,h1,hmin,outsbs,d);
odedp.integrate;
odebs.integrate;

figure(5)
dpbs = outsdp.ysave(1:outsdp.count,1)-outsbs.ysave(1:outsbs.count,1);
plot(outsdp.xsave(1:outsdp.count),dpbs)
xlabel('x');
ylabel('\delta y_1 between DP5 and BS');
title('Error Function of Bessel J1 Between DP5 and BS');

bej1 = besselj(1,outsdp.xsave(1:outsdp.count));

figure(6)
j1dp = bej1 - outsdp.ysave(1:outsdp.count,1);
plot(outsdp.xsave(1:outsdp.count),j1dp)
xlabel('x');
ylabel('\delta y_1 between besselj() and DP5');
title('Brror Function of Bessel J1 Between besselj() and DP5');

figure(7)
j1bs = bej1 - outsbs.ysave(1:outsbs.count,1);
plot(outsbs.xsave(1:outsbs.count),j1bs)
xlabel('x');
ylabel('\delta y_1 between besselj() and BS');
title('Error Function of Bessel J1 Between besselj() and BS');

