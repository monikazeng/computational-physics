% Uniform deviates
% P(x) = 1 for 0<=x<=1
%        0 otherwise

unif = NumericalRecipes.Ran(234090);

Nbins = 100;
Nrans = 100000;
rans = zeros(Nrans,1);
for i=1:Nrans
    rans(i) = unif.doub;
end

figure(1)
histogram(rans,Nbins);
set(gca,'fontsize', 36)
pause(0.001)

% return

% Exponential deviates
% P(x) =  beta * exp(-beta * x) for x>=0.

exp = NumericalRecipes.Expodev(5,328298);

Nbins = 100;
Nrans = 100000;
rans = zeros(Nrans,1);
for i=1:Nrans
    rans(i) = exp.dev;
end

figure(2)
histogram(rans,Nbins);
set(gca,'fontsize', 36)
pause(0.001)

% return

% Normal deviates
% P(x) = 1/(sig*sqrt(2*pi))*exp(-(x-mu)^2/(2*sig^2))

nor = NumericalRecipes.Normaldev(3,5,763840);

Nbins = 100;
Nrans = 1000000;
rans = zeros(Nrans,1);
for i=1:Nrans
    rans(i) = nor.dev;
end

figure(3)
histogram(rans,Nbins);
set(gca,'fontsize', 36)
pause(0.001)

% return

% Box-Muller Normal deviates
% P(x) = 1/(sig*sqrt(2*pi))*exp(-(x-mu)^2/(2*sig^2))

nor = NumericalRecipes.Normaldev_BM(3,5,74849328);

Nbins = 100;
Nrans = 1000000;
rans = zeros(Nrans,1);
for i=1:Nrans
    rans(i) = nor.dev;
end

figure(4)
histogram(rans,Nbins);
set(gca,'fontsize', 36)
pause(0.001)