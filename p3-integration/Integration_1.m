%
% Extended Trapezoidal rule & Trapzd
%

trap1 = NumericalRecipes.Trapzd(@sin,0,pi);
for i=0:19
    [i1,trap1]=trap1.next;
    fprintf('Trapzd: level %d : %.10g\n',i,i1);
end

%return

% Trapezoidal rule with error : qtrap
i2 = NumericalRecipes.qtrap(@sin,0,pi,1.e-8);
fprintf('\nqtrap : %.10g\n',i2);

%return

% Simpson's rule with error : qtrap
i3 = NumericalRecipes.qsimp(@sin,0,pi,1.e-8);
fprintf('\nqsimp : %.10g\n',i3);

%return

% Romberg integration with error : qtrap
i4 = NumericalRecipes.qromb(@sin,0,pi,1.e-8);
fprintf('\nqromb : %.10g\n',i4);

%return

% more complex functions
% 
i5 = NumericalRecipes.qromb(@(x) x.^4*log(x+sqrt(x.^2+1)),0,2,1.e-5);
fprintf('\nqromb 2 : %.10g\n',i5);
i6 = NumericalRecipes.qsimp(@(x) x.^4*log(x+sqrt(x.^2+1)),0,2,1.e-5);
fprintf('\nqsimp 2 : %.10g\n',i6);
i7 = NumericalRecipes.qtrap(@(x) x.^4*log(x+sqrt(x.^2+1)),0,2,1.e-5);
fprintf('\nqtrap 2 : %.10g\n',i7);
