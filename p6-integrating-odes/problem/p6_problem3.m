clear
%%% Problem 3
% (1)
lambda = 100;
n = 1000; % steps
h=1/n; % stepsize
% h = 0.02; % minimum stability 
xfin=1; % end-point of integration

% explicit Euler
x=zeros(1); % reset the x and y arrays so we don't
y=zeros(1); % have to clear Workspace when we change h
i=1;
x(i)=0; % start at x=0
y(i)=1; % start with y(0)=1
while x(i)<xfin
    y(i+1)=y(i)-h*lambda*y(i); % Euler's method (explicit)
    x(i+1)=i*h;
    i=i+1;
end
ya=y(1)*exp(-lambda*x); % compute analytic solution
yrelerr=abs(ya-y)./ya; % compute relative error
figure(1)
plot(x,ya,'k',x,y,'r') % plot numeric & analytic sol.
title('Analyic and Numerical solutions (explicit Euler)');
xlabel('x');
ylabel('y(x)');
legend('analytic','numerical')
figure(2)
semilogy(x,ya,'k',x,abs(y),'r') % plot numeric & analytic sol.
title('Analyic and |Numerical| solutions (explicit Euler)');
xlabel('x');
ylabel('y(x)');
legend('analytic','numerical')
figure(3)
loglog(x,yrelerr,'r') % plot error
title('|Analyic - Numerical|/Analytic (explicit Euler)');
xlabel('x');
ylabel('relativ error');


% implicit Euler
x2=zeros(1); % reset the x and y arrays so we don't
y2=zeros(1); % have to clear Workspace when we change h
j=1;
x2(j)=0; % start at x=0
y2(j)=1; % start with y(0)=1
while x(j)<xfin
    y2(j+1)=y2(j)/(1/1+h*lambda); % Euler's method (implicit)
    x2(j+1)=j*h;
    j=j+1;
end
ya2=y2(1)*exp(-lambda*x2); % compute analytic solution
yrelerr2=abs(ya2-y2)./ya2; % compute relative error
figure(4)
plot(x2,ya2,'k',x2,y2,'r') % plot numeric & analytic sol.
title('Analyic and Numerical solutions (implicit Euler)');
xlabel('x');
ylabel('y(x)');
legend('analytic','numerical')
figure(5)
semilogy(x2,ya2,'k',x2,abs(y2),'r') % plot numeric & analytic sol.
title('Analyic and |Numerical| solutions (implicit Euler)');
xlabel('x');
ylabel('y(x)');
legend('analytic','numerical')
figure(6)
loglog(x2,yrelerr2,'r') % plot error
title('|Analyic - Numerical|/Analytic (implicit Euler)');
xlabel('x');
ylabel('relativ error');



% (2)
% find the minimum number of steps n for explicit Euler method to be stable
% it's unstable if |y_n+1 / y_n| > 1  (amplification factor)
% or h > 2/lambda
% for a step size of 100, if h > 2/100 = 0.02, then it's unstable
% so h cannot needs be less than 0.02 to to stable, so the minimum steps n
% is n = 1/h = 50


% (3)
% n = 49
n1 = 49; % steps
h1 = 1/n1; % stepsize
x3=zeros(1); % reset the x and y arrays so we don't
y3=zeros(1); % have to clear Workspace when we change h
i=1;
x3(i)=0; % start at x=0
y3(i)=1; % start with y(0)=1
while x3(i)<xfin
    y3(i+1)=y3(i)-h1*lambda*y3(i); % Euler's method (explicit)
    x3(i+1)=i*h1;
    i=i+1;
end
ya3=y3(1)*exp(-lambda*x3); % compute analytic solution
yrelerr3=abs(ya3-y3)./ya3; % compute relative error

x4=zeros(1); % reset the x and y arrays so we don't
y4=zeros(1); % have to clear Workspace when we change h
j=1;
x4(j)=0; % start at x=0
y4(j)=1; % start with y(0)=1
while x4(j)<xfin
    y4(j+1)=y4(j)/(1/1+h1*lambda); % Euler's method (implicit)
    x4(j+1)=j*h1;
    j=j+1;
end
ya4=y4(1)*exp(-lambda*x4); % compute analytic solution
yrelerr4=abs(ya4-y4)./ya4; % compute relative error

figure(7)
hold on;
plot(x3,ya3,'k') % analytic sol.
plot(x3,y3,'b')
plot(x4,y4,'m') 
title('Analyic and Numerical solutions (n = 49)');
xlabel('x');
ylabel('y(x)');
legend('analytic','explicit','implicit')
hold off;

% n = 50
n2 = 50; % steps
h2 = 1/n2; % stepsize
x5=zeros(1); % reset the x and y arrays so we don't
y5=zeros(1); % have to clear Workspace when we change h
i=1;
x5(i)=0; % start at x=0
y5(i)=1; % start with y(0)=1
while x5(i)<xfin
    y5(i+1)=y5(i)-h2*lambda*y5(i); % Euler's method (explicit)
    x5(i+1)=i*h2;
    i=i+1;
end
ya5=y5(1)*exp(-lambda*x5); % compute analytic solution
yrelerr5=abs(ya5-y5)./ya5; % compute relative error

x6=zeros(1); % reset the x and y arrays so we don't
y6=zeros(1); % have to clear Workspace when we change h
j=1;
x6(j)=0; % start at x=0
y6(j)=1; % start with y(0)=1
while x6(j)<xfin
    y6(j+1)=y6(j)/(1/1+h2*lambda); % Euler's method (implicit)
    x6(j+1)=j*h2;
    j=j+1;
end
ya6=y6(1)*exp(-lambda*x6); % compute analytic solution
yrelerr6=abs(ya6-y6)./ya6; % compute relative error

figure(8)
hold on;
plot(x5,ya5,'k') % analytic sol.
plot(x5,y5,'b')
plot(x6,y6,'m') 
title('Analyic and Numerical solutions (n = 50)');
xlabel('x');
ylabel('y(x)');
legend('analytic','explicit','implicit')
hold off;


% n = 51
n3 = 51; % steps
h3 = 1/n3; % stepsize
x7=zeros(1); % reset the x and y arrays so we don't
y7=zeros(1); % have to clear Workspace when we change h
i=1;
x7(i)=0; % start at x=0
y7(i)=1; % start with y(0)=1
while x7(i)<xfin
    y7(i+1)=y7(i)-h3*lambda*y7(i); % Euler's method (explicit)
    x7(i+1)=i*h3;
    i=i+1;
end
ya7=y7(1)*exp(-lambda*x7); % compute analytic solution
yrelerr7=abs(ya7-y7)./ya7; % compute relative error

x8=zeros(1); % reset the x and y arrays so we don't
y8=zeros(1); % have to clear Workspace when we change h
j=1;
x8(j)=0; % start at x=0
y8(j)=1; % start with y(0)=1
while x8(j)<xfin
    y8(j+1)=y8(j)/(1/1+h3*lambda); % Euler's method (implicit)
    x8(j+1)=j*h3;
    j=j+1;
end
ya8=y8(1)*exp(-lambda*x8); % compute analytic solution
yrelerr8=abs(ya8-y8)./ya8; % compute relative error

figure(9)
hold on;
plot(x7,ya7,'k') % analytic sol.
plot(x7,y7,'b')
plot(x8,y8,'m') 
title('Analyic and Numerical solutions (n = 51)');
xlabel('x');
ylabel('y(x)');
legend('analytic','explicit','implicit')
hold off;
