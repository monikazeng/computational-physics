%%% Problem 2

func = funct(10^-10);
boundx1 = -sqrt(5/8);
boundx2 = sqrt(5/8);
u = NumericalRecipes.Midpnt(func,boundx1,boundx2);
val = (NumericalRecipes.qromo(u,10^-9));

format long
val


% 10^-7:    1.449233721617517
% 10^-8:    1.449034149600394
% 10^-9:    1.449027919148310
% 10^-10:   1.449026488626522


% The computed value of the integral (to an accuracy in 10^5) is 1.44902
% with an error accuracy of 10^-9. 
% I have listed the different error accuracy to calculate val with qromo
% and we can see that 10^-9 and 10^-10 produce the same value to an
% accuracy in 10^5. 

% the integrand is evaluated 177147 times in total. 