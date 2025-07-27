% Create 2 arrays 
% 1) values of 'x' where we will evaluate a function.
% 2) the value of the function 'y' at each value of 'x'
%
n=61; % number of value of x where we will evaluate the function
xmax = 3*pi; % range of x goes from 0 to 'xmax'

% First approach: Standard loop programming
% We force 'dx' to be single precision so that everything
% based on it will also be single precision
dx=single(xmax/(n-1));
for i=1:n
    x(i)=(i-1)*dx;
    y(i)=sin(x(i));
end
% Second approach: MATLAB array evaluation
% x = single(0:xmax/(n-1):xmax);
% y = sin(x);

% Plot the array 'y' vs 'x' in figure window 1
figure(1)
plot(x,y)
xlabel('x')
ylabel('sin(x)')
set(gca,'fontsize', 36) 

%return; % This is just here to stop the script
% Let's compute the numerical derivative of a function.
% We need a finite value of 'h' for the separation between the
% two function evaluations.
%
% Set a finite value of h (start with 0.1 then
%                          try 0.01, 0.001, etc.)
h=0.00001;
% Compute the derivative: standard loop programming
for i=1:n
    dydx(i)=(sin(x(i)+h)-sin(x(i)))/h;
end
% Compute the derivative:  Matlab array evaluation
% dydx = (sin(x+h)-sin(x))/h;

% Plot the function 'y' vs 'x' and its numerical derivative 
% 'dydx' vs 'x' in figure window 2
% Note that with multiple arguements, plot groups arrays by pairs.
figure(2)
plot(x,y,x,dydx)
xlabel('x')
legend('sin(x)','d/dx(sin(x))')
set(gca,'fontsize', 36)
%return; % This is just here to stop the script

% Evaluate the error in the numerical derivative
err = cos(x)-dydx;

% Plot the error 'err' vs 'x' in figure window 3
figure(3)
plot(x,err)
xlabel('x')
ylabel('error')
set(gca,'fontsize', 36)
%return; % This is just here to stop the script

% This computes an "L2-norm" of the error.
%
% First approach: Standard loop programming
errnorm=single(0);
for i=1:n
    errnorm = errnorm + err(i)*err(i);
end
errnorm = sqrt(errnorm/n);
% Second approach use MaLab 'norm' function that acts on 
% arrays.  'norm' computes an L2-norm without dividing by 
% the # of points.
% errnorm = norm(err)/sqrt(n);

% Write the results out to the Command Window.
disp(['L2 norm of error: ' num2str(errnorm)])