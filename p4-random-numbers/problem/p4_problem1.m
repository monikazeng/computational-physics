%%% problem 1

% surface area: dx * dy
dx = 2 * sqrt(5/8);
dy = 2 * sqrt(5/8);
sa = dx * dy;

ud=NumericalRecipes.Ran(454533);
j=0;
val = 0;
err = 0;
Ntot=52000;
for i=1:Ntot
    xt = -sqrt(5/8) + 2*sqrt(5/8)*ud.doub;
    yt = -sqrt(5/8) + 2*sqrt(5/8)*ud.doub;
    if(5*xt^2-6*xt*yt+5*yt^2 <= 2)
        j=j+1;
        x(i) = xt;
        y(i) = yt;
        f = exp(-xt*sin(yt));
        val = val + f;
        err = err + f^2;
    end
%     if mod(i,100)==0
%         figure(1)
%         scatter(x,y,1)
%         axis equal
%         pause(0.001)
%     end
end
integrand = sa * val / Ntot;
error = sa * sqrt((err/Ntot - (val/Ntot)^2)/Ntot);

% figure(1)
% scatter(x,y,1)
% set(gca,'fontsize', 36)
% axis equal


format long
integrand
error


% Comment
% With N = 52000, the integrand is evaluated to be 1.45
% (1.454256862098324) with a 1-σ error of 0.00498 (0.004981970642072) 
% -- an accuracy better than 0.5%
% variable j is the counter for counting how many times the integrand is
% evaluated, which is 32790 times