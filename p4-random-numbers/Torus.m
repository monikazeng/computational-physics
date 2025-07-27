ud=NumericalRecipes.Ran(454533);
j=0;
Ntot=50000;
for i=1:Ntot
    xt=1+3*ud.doub;
    yt=-3+(3+sqrt(15))*ud.doub;
    zt=-1+2*ud.doub;
    if(zt^2 + (sqrt(xt^2+yt^2)-3)^2 <= 1)
        j=j+1;
        x(j)=xt;
        y(j)=yt;
        z(j)=zt;
    end
    if mod(i,100)==0
        figure(1)
        scatter3(x,y,z,1)
        axis equal
        pause(0.001)
    end
end
figure(1)
scatter3(x,y,z,1)
set(gca,'fontsize', 36)
axis equal