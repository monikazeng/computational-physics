% Newton's Method
% We are required to use a "FunctorD" class in order to define both a
% function and its first derivative.
%
% TestFunctionD.m defines a cubic polynomial with coefficients
% a x^3 + b x^2 + c^x +d
myfuncd = TestFunctionD(1.3,-3.5,2.87,1);
x=-10:0.01:10;
figure(1);
plot(x,myfuncd.func(x));
xlabel('x');
ylabel('f(x)');
figure(2);
plot(x,myfuncd.df(x));
xlabel('x');
ylabel('f''(x)');
% Find some brackets between -10 and 10
[x1b, x2b] = NumericalRecipes.zbrak(myfuncd,-10,10,150);

% return

% Simple Newton's Method
fprintf('\n--- Finding roots using Newton''s Method ---\n');
for k=1:length(x1b)
    newtroot = NumericalRecipes.rtnewt(myfuncd,x1b(k),x2b(k),1.e-12);
    fprintf('Bracket %2d: [%f,%f]; Root at x = %.16f\n',k,x1b(k),x2b(k),newtroot);
end

% return

% Polynomial Root Finding
%
fprintf('\n--- Finding roots of polynomials using Laguer''s Method ---\n');
coefs = [1,2.87,-3.5,1.3]; % Use the same cubic polynomial from before.
polyroots = NumericalRecipes.zroots(coefs,true);
for k=1:length(polyroots)
    fprintf('Root %2d:  x = %.9f + %.9fi\n',k,real(polyroots(k)),imag(polyroots(k)));
end

% return

% Polynomial Root Finding with complex coefficients
%
fprintf('\n--- Finding roots of polynomials with complex ---\n       coefficients using Laguer''s Method\n');
coefs = [1,2.87-2.3i,-3.5,1.3+5.2i]; % Use the same cubic polynomial from before.
polyroots = NumericalRecipes.zroots(coefs,true);
for k=1:length(polyroots)
    fprintf('Root %2d:  x = %.9f + %.9fi\n',k,real(polyroots(k)),imag(polyroots(k)));
end

