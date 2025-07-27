myran = SimpleRandom(234,99023,134234,9387398);
% myran = SimpleRandom(1837,2823,7376,87398);
% myran = NumericalRecipes.Ran(32343);
Nbins = 100;
Nrans = 10000;
rans = zeros(Nrans,1);
for i=1:Nrans
    rans(i) = myran.doub;
end
%rans = rand(Nrans,1);
figure(1)
histogram(rans,Nbins);
set(gca,'fontsize', 36)
pause(0.001)

% return

figure(2)
tworan = zeros(Nrans,2);
for i=1:Nrans
    tworan(i,1) = myran.doub;
    tworan(i,2) = myran.doub;
end
%tworan = rand(Nrans,2);
plot(tworan(:,1),tworan(:,2),'.');
set(gca,'fontsize', 36)
pause(0.001)

% return

figure(3)
threeran = zeros(Nrans,3);
for i=1:Nrans
    threeran(i,1) = myran.doub;
    threeran(i,2) = myran.doub;
    threeran(i,3) = myran.doub;
end
%threeran = rand(Nrans,3);
plot3(threeran(:,1),threeran(:,2),threeran(:,3),'.');
set(gca,'fontsize', 36)
view(36,45);
pause(0.001)