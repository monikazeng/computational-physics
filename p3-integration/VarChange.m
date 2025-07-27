% Infinite limit
il1=NumericalRecipes.Midpnt(@(x) 1/x^2,1,1.e+99);
il2=NumericalRecipes.Midinf(@(x) 1/x^2,1,1.e+99);
%
iil1 = NumericalRecipes.qromo(il1,1.1e-4);
iil2 = NumericalRecipes.qromo(il2,1.e-10);
fprintf('\ninfinite lim (Midpnt) : %.10g (%.10g)\n',iil1,1);
fprintf('infinite lim (Midinf) : %.10g (%.10g)\n',iil2,1);

% The inverse square-root singularity
sr1=NumericalRecipes.Midpnt(@(x) 1/sqrt(x),0,1);
sr2=NumericalRecipes.Midsql(@(x) 1/sqrt(x),0,1);
%
isr1 = NumericalRecipes.qromo(sr1,3.e-8);
isr2 = NumericalRecipes.qromo(sr2,1.e-10);
fprintf('\ninverse sqrt (Midpnt) : %.10g (%.10g)\n',isr1,2);
fprintf('inverse sqrt (Midsql) : %.10g (%.10g)\n',isr2,2);

% Exponential decrease
ex1=NumericalRecipes.Midpnt(@(x) exp(-x),0,1.e+99);
ex2=NumericalRecipes.Midexp(@(x) exp(-x),0,1.e+99);

iex1 = NumericalRecipes.qromo(ex1,1.e-10);
iex2 = NumericalRecipes.qromo(ex2,1.e-10);
fprintf('\nexponential integral (Midpnt) : %.10g (%.10g)\n',iex1,1);
fprintf('exponential integral (Midexp) : %.10g (%.10g)\n',iex2,1);