%
% Improper Integrals and Extended 'Open' formulae
%

mid1 = NumericalRecipes.Midpnt(@sin,0,pi);
for i=0:12
    [i8,mid1]=mid1.next;
    fprintf('Midpnt: level %d : %.10g\n',i,i8);
end

%return

% Romberg integration with error : qromo
mid2 = NumericalRecipes.Midpnt(@sin,0,pi); % Note: integration
i9 = NumericalRecipes.qromo(mid2,1.e-8);   % info in Midpnt class
fprintf('\nqromo : %.10g\n',i9);

%return

% Infinite range:
% Midinf
% Integrate[exp(-x^2),-inf,inf]
%
gaus = @(x) exp(-x.^2);
low = NumericalRecipes.Midinf(gaus,-1.e99,-2);
mid = NumericalRecipes.Midpnt(gaus,-2,2);
high = NumericalRecipes.Midinf(gaus,2,1.e99);
i10 = NumericalRecipes.qromo(low,1.e-8);
i10 = i10 + NumericalRecipes.qromo(mid,1.e-8);
i10 = i10 + NumericalRecipes.qromo(high,1.e-8);
fprintf('\ngaussian integral : %.10g (%.10g)\n',i10,sqrt(pi));

%return

% 
%
% Functor example
% Integrate[x^n Exp[-x/a],0,inf] = n! a^(n+1)
%
n=5; a=1;
expint = integrand1(n,a);
low = NumericalRecipes.Midpnt(expint,0,4);
high = NumericalRecipes.Midinf(expint,4,1.e99);
i11 = NumericalRecipes.qromo(low,1.e-8);
i11 = i11 + NumericalRecipes.qromo(high,1.e-8);
fprintf('\nexponential integral : %.10g (%.10g)\n',i11,factorial(n)*a^(n+1));
