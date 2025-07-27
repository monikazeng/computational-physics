clear
%%% Problem 2

% (1)
% we cannot start the integrations exactly at x = 0 so we need to pick a
% small epsilon values that's close to 0 and use the series approximation
% to get the initial conditions
% 
% series expansion approximation for J1(x) for small x
% J1(x) ~ x/2 * (1 - x^2/8 + x^4/192)
% J1'(X) ~ 1/2 - 3*x^2/16 + 5*x^4/384

% pick epsilon = 0.0001
% x1 = 0.0001;
% J1(epsilon) = x1/2*(1 - x1^2/8 + x1^4/192) = 5e-5
% J1'(epsilon) = 1/2 - 3*x1^2/16 + 5*x1^4/384 = 0.5000
% 
% testing the correctness of initial values
% besselj(1,0.0001)       % 5.0000e-05
% besselj(0,x1) - besselj(1,x1)/x1    % 0.5000


% besselj(1,0.0001)       % 5.0000e-05
% besselj(0,0.0001)       % 1
% 

% (2)
% using z(x) = dy/dx
atol = 1.0e-9;
rtol = atol;
h1 = 0.01;
hmin = 0.0;
% initial conditions
x1 = 0.0001;
x2 = 1;
ystart = [x1/2*(1-x1^2/8+x1^4/192), 1/2-3*x1^2/16+5*x1^4/384];
outsdp = NumericalRecipes.Output(-1);
outsbs = NumericalRecipes.Output(-1);
d_dp = BesselFunctionODE();
d_bs = BesselFunctionODE();
odedp = NumericalRecipes.Odeint(NumericalRecipes.StepperDopr5(),ystart,x1,x2,atol,rtol,h1,hmin,outsdp,d_dp);
odebs = NumericalRecipes.Odeint(NumericalRecipes.StepperBS(),ystart,x1,x2,atol,rtol,h1,hmin,outsbs,d_bs);
odedp.integrate;
odebs.integrate;

% plotting x and y1(x) (y(x)) (with z(x)=dy/dx)
figure(1)
plot(outsdp.xsave(1:outsdp.count),outsdp.ysave(1:outsdp.count,1))
hold on
plot(outsbs.xsave(1:outsbs.count),outsbs.ysave(1:outsbs.count,1))
% plot besselj() function to see correctness
bejbs = besselj(1,outsbs.xsave(1:outsbs.count));    
plot(outsbs.xsave(1:outsbs.count),bejbs)    
xlabel('x');
ylabel('y_1');
legend('Dormand-Prince5','Bulirsch-Stoer','besselj()')
title('Integration of Bessel J1 using z(x)=dy/dx')
hold off


% (3)
% using w(x) = x * dy/dx
atol = 1.0e-9;
rtol = atol;
h1 = 0.01;
hmin = 0.0;
ystart2 = [x1/2-x1^3/16+x1^5/2/192, x1*(1/2-3*x1^2/16+5*x1^4/2/192)];
d_dp2 = BesselFunctionODE2();
d_bs2 = BesselFunctionODE2();
outsdp2 = NumericalRecipes.Output(-1);
outsbs2 = NumericalRecipes.Output(-1);
odedp2 = NumericalRecipes.Odeint(NumericalRecipes.StepperDopr5(),ystart2,x1,x2,atol,rtol,h1,hmin,outsdp2,d_dp2);
odebs2 = NumericalRecipes.Odeint(NumericalRecipes.StepperBS(),ystart2,x1,x2,atol,rtol,h1,hmin,outsbs2,d_bs2);
odedp2.integrate;
odebs2.integrate;

% plotting x and y1(x) (y(x))  (with w(x)=x*dy/dx)
figure(2)
plot(outsdp2.xsave(1:outsdp2.count),outsdp2.ysave(1:outsdp2.count,1))
hold on
plot(outsbs2.xsave(1:outsbs2.count),outsbs2.ysave(1:outsbs2.count,1))
bejbs2 = besselj(1,outsbs2.xsave(1:outsbs2.count));
plot(outsbs2.xsave(1:outsbs2.count),bejbs2)
xlabel('x');
ylabel('y_1');
legend('Dormand-Prince5','Bulirsch-Stoer','besselj()')
title('Integration of Bessel J1 using w(x)=x*dy/dx')
hold off

% analysis of which method is better:
% z(x) = dy/dx      w(x) = x * dy/dx
% comparing the number of times derivative is evaluated, we can look at the
% counter value stored in each d variable:
dz_bs = d_bs.counter;
dz_dp = d_dp.counter;
dw_bs = d_bs2.counter;
dw_dp = d_dp2.counter;
% for method that uses z(x), d_bs.counter = 1046; d_dp.counter = 9493
% for method that uses w(x), d_bs2.counter = 992; d_dp2.counter = 2575
% By looking at the number of times derivative is evaluated/ time-comlexity
% the method that uses w(x) is much more efficient, especially when it
% comes to using the StepperDopr5 stepping algorithms: we can see
% significant reduce in steps for w(x)

% we can also check the accuracy of both methods (using StepperBS)
figure(3)
j1bs = bejbs - outsbs.ysave(1:outsbs.count,1);
plot(outsbs.xsave(1:outsbs.count),j1bs)
xlabel('x');
ylabel('\delta y_1 between besselj() and BS');
title('Error Function Between besselj() and integration using z(x)=dy/dx');

figure(4)
j1bs2 = bejbs2 - outsbs2.ysave(1:outsbs2.count,1);
plot(outsbs2.xsave(1:outsbs2.count),j1bs2)
xlabel('x');
ylabel('\delta y_1 between besselj() and BS');
title('Error Function Between besselj() and integration using w(x)=dy/dx');

% from plot3 and plot4, we can see that the integrated value using z(x) is
% more accurate than the integrated value using w(x) since the error range
% for z(x) is 10^-5 and for w(x) is 10^-3. 
% so if we are pursuing straight accuracy over time-complexity, the method 
% using z(x) is better but w(x) is much more efficient.