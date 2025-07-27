clear % clear the workspace before starting
% Generate the data for a polynomial or other function at N points between
% A and B. 
%POLY = [110 -25 -200 36 107 -12.25 -16.5 0.6 0.5];
POLY = [110 -25 -200 36 107];
A = -1;
B = 1;
N = 10;
[x,y] = FuncGen(A,B,N,POLY,0);
[xp,yp] = FuncGen(A,B,20*N,POLY,0);

% Generate data for the same polynomaial or other function at the same
% points, but with random errors of magnitude ERR added to y
ERR = 4;
[xe,ye] = FuncGen(A,B,N,POLY,ERR);
figure(1);
plot(xp,yp,'k',x,y,'g*',x,ye,'r*')
xlabel('x')
ylabel('y')
legend('y(x)','exact','noisy')
set(gca,'fontsize', 36)

%return

% Set up interpolation using (M-1)-th order polynomial
% interpolation using data with no error
M = 2;
p = NumericalRecipes.Poly_interp(x,y,M);

% Generate fine set of x values at which we will 
% interpolate values
h = (B - A)/99;
xi = A:h:B;
% Interpolate
for i=1:length(xi)
%     ypi(i) = p.interp(xi(i));
    [ypi(i),p] = p.interp(xi(i)); % save error info
    errsp(i)=p.dy;
end
figure(2);
plot(xp,yp,'k',x,y,'g*',xi,ypi,'r')
xlabel('x')
ylabel('y')
legend('y(x)','exact','fit')
set(gca,'fontsize', 36)

% Set up interpolation using M-th order polynomial
% interpolation using data with error
pe = NumericalRecipes.Poly_interp(xe,ye,M);
for i=1:length(xi)
%     ype(i) = pe.interp(xi(i));
    [ype(i),pe] = pe.interp(xi(i)); % Save error info
    errspe(i)=pe.dy;
end
figure(3);
plot(xp,yp,'k',xe,ye,'r*',xi,ype,'r')
xlabel('x')
ylabel('y')
legend('y(x)','noisy','fit')
set(gca,'fontsize', 36)
% 

%return

figure(4);
errorbar(xi,ypi,errsp)
xlabel('x')
ylabel('y')
set(gca,'fontsize', 36)
% 
figure(5);
errorbar(xi,ype,errspe)
xlabel('x')
ylabel('y')
set(gca,'fontsize', 36)
% 
% Get the Coefficients of the interpolating polynomial
format long
NumericalRecipes.polcof(x,y)
%
NumericalRecipes.polcof(xe,ye)
