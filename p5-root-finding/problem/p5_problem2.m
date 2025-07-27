% Newton's Method
% We are required to use a "FunctorD" class in order to define both a
% function and its first derivative.
%
% Hw5FunctionD.m defines a 6th order polynomial with coefficients
% a x^6 + b x^5 + c x^4 + d x^3 + e x^2 + f x + g

myfuncd = Hw5FunctionD(1,-12.1,59.5,-151.85,212.6625,-156.6,48.5625);
x=-10:0.01:10;
figure(1);
plot(x,myfuncd.func(x));
xlabel('x');
ylabel('f(x)');
figure(2);
plot(x,myfuncd.df(x));
xlabel('x');
ylabel('f''(x)');
% Find some brackets between -5 and 5
[x1b, x2b] = NumericalRecipes.zbrak(myfuncd,-5,5,100);

% Polynomial Root Finding
%
fprintf('--- Finding roots of polynomials using Laguer''s Method ---\n');
% coefs = [1,2.87,-3.5,1.3]; % Use the same cubic polynomial from before.
coefs = [48.5625,-156.6,212.6625,-151.85,59.5,-12.1,1];
polyroots = NumericalRecipes.zroots(coefs,true);
for k=1:length(polyroots)
    fprintf('Root %2d:  x = %.9f + %.9fi\n',k,real(polyroots(k)),imag(polyroots(k)));
end

