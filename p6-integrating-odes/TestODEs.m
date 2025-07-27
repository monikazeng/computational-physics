clear
nvar = 2;
atol = 1.0e-9;
rtol = atol;
h1 = 0.01;
hmin = 0.0;
x1 = 0.0;
x2 = 5.0;
ystart = [2.0, -0.665];
outsdp = NumericalRecipes.Output(-1);
outsbs = NumericalRecipes.Output(-1);
d = TestFunctionODE(5.e-1);
odedp = NumericalRecipes.Odeint(NumericalRecipes.StepperDopr5(),ystart,x1,x2,atol,rtol,h1,hmin,outsdp,d);
odebs = NumericalRecipes.Odeint(NumericalRecipes.StepperBS(),ystart,x1,x2,atol,rtol,h1,hmin,outsbs,d);
odedp.integrate;
odebs.integrate;
figure(1)
plot(outsdp.xsave(1:outsdp.count),outsdp.ysave(1:outsdp.count,1))
hold on
plot(outsbs.xsave(1:outsbs.count),outsbs.ysave(1:outsbs.count,1))
xlabel('x');
ylabel('y_1');
hold off
figure(2)
plot(outsdp.xsave(1:outsdp.count),outsdp.ysave(1:outsdp.count,2))
hold on
plot(outsbs.xsave(1:outsbs.count),outsbs.ysave(1:outsbs.count,2))
xlabel('x');
ylabel('y_2');
hold off
if outsdp.count == outsbs.count
    figure(3)
    plot(outsdp.xsave(1:outsdp.count),outsdp.ysave(1:outsdp.count,1)-outsbs.ysave(1:outsbs.count,1))
    xlabel('x');
    ylabel('\delta y_1');
end