
POLY = [110 -25 -200 36 107];
A = -1;
B = 1;
N = 10;     % datapoints

[x,y] = FuncGen(A,B,N,POLY,0);
[xp,yp] = FuncGen(A,B,20*N,POLY,0);

ERR = 0.04;
[xe,ye] = FuncGen(A,B,N,POLY,ERR);

return



%%
M = 2;
p = NumericalRecipes.Poly_interp(x,y,M);

h = (B-A)/99;
xi = A:h:B;

%interpolate
for i = 1:length(xi)
    % 
    [ypi(i), p] = p.interp(xi(i));
    % p.interp returns [a value of x, class p]
    % call p in the return value to update the class
    errsp(i) = p.dy;
end





function [x,y] = FuncGen(a,b,n,p,err)
    x = a:(b-a)/(n-1):b;
    
    % function to be returned
%     y = polyval(p,x);
%     y = sin(x);
%     y = exp(-4^)

    del = (2*rand(1,length(y))-1)*err;

end


