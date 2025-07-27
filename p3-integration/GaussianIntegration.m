% Example of Gaussian Integration
% Integrate[x*sin(x)/sqrt(1-x^2),{-1,1}] = 1.3824596873841685258
%

funct = @(x) x.*sin(x)/sqrt(1-x.^2);

mid1 = NumericalRecipes.Midpnt(funct,-1,1);
i1 = NumericalRecipes.qromo(mid1,1.e-7);
err = abs(i1 - 1.3824596873841685258)/1.3824596873841685258;  
fprintf('\nmidpoint 1 integral  : %.10g (%1.2e)\n',i1,err);
%
% Midpnt requires 14 levels -> 3^13 =1,594,323 function calls

midlo = NumericalRecipes.Midsql(funct,-1,0);
midhi = NumericalRecipes.Midsqu(funct,0,1);
i2 = NumericalRecipes.qromo(midlo,1.e-8)+ ...
     NumericalRecipes.qromo(midhi,1.e-8);
err = abs(i2 - 1.3824596873841685258)/1.3824596873841685258;
fprintf('midpoint 2 integral  : %.16g (%1.2e)\n',i2,err);
%
% Midsql/u requires 5 levels -> 2*3^4 = 162 function calls

for n=2:10
    j=1:n;
    x = cos(pi*(j-0.5)/n);
    w = pi/n;
    i3 = w*sum(x.*sin(x));
    err = abs(i3 - 1.3824596873841685258)/1.3824596873841685258;
    fprintf('Gauss-Chebyshev (%2d) : %.16g (%1.2e)\n',n,i3,err);
end
%
% Gaussian integration gets machine precision with 9 points!
%