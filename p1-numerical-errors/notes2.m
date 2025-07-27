n = 61;
xmax = 3 * pi;

dx = single(xmax/(n-1));
for i = 1:n
    x(i) = (i-1)*dx;
    y(i) = sin(x(i));
end

figure(1)
plot(x,y)
xlabel('x')
ylabel()

% h = 0.1;
% for i = 1:n
%     dydx(i) = (sin(x(i)+h) - sin(x(i)))/h;
% end
% 
% figure(2)
% plot(x,y,x,dydx)
% xlabel('x')
% legend('sin(x)','d/dx(sin(x))')
% set(gca,'fontsize',36)
% 
% err = cos(x)=dydx;
% 
% figure(3)
% plot(x,err);





% series approximations


% heaviside Calculus





