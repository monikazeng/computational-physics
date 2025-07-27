nl=5;
lambdaa=nl*(nl+1);
base=64;
for j=1:6
    n=base*2^j;
    h(j)=1/(n-1);
%     [lambda(j),x(1:n,j),P(1:n,j)]=LegendreFDEII(mod(nl+1,2),lambdaa,n,1.e-10);
    [lambda(j),x(1:n,j),P(1:n,j)]=RelaxLegendre(mod(nl+1,2),1.1*lambdaa,n,1.e-10);
end
figure(2)
plot(h,lambda)
xlabel('h')
ylabel('\lambda');
figure(3)
plot(log10(h),log10(abs(lambda-lambdaa)))
xlabel('log_{10}h');
ylabel('log_{10}abs(\lambda-\lambda_a)')
title('\lambda Convergence')
figure(4)
xlabel('x')
ylabel('P_a-P_n')
title('Function convergence')
for j=1:6
    n=base*2^j;
    aleg=legendre(nl,x(1:n,j));
    leg=aleg(1,:);
    err(1:n)=4^(j-1)*(leg-transpose(P(1:n,j)));
    plot(x(1:n,j),err(1:n));
    hold on
end
hold off