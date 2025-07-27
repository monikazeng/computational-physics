% Solve the linear Tridiagonal system directly.
% This approach does not allow us to easily know when our choice of
% the eigenvalue lambda yields a valid solution.
function [lambda,x,P] = LegendreFDED(even,lambda,N)
    h=1.0/double(N-1);  % step size
    x = 0:h:1.0; % array of x values
    % Set up storage for:
    %u = zeros(1,N); % solution u(1) = P (initialization unneeded)
    r = zeros(1,N); % right hand side
    a = zeros(1,N); % lower block diagonal
    b = zeros(1,N); % block diagonal
    c = zeros(1,N); % upper block diagonal
    %
    bccase=1; % P(N)=1;
%     bccase=2; % P(N-1)-(1-h*lambda/2)*P(N)=0
%     bccase=3; % P(N-1)-(1-h*lambda/2)=0
    %
    % set value for upper and lower diagonals since the values in these
    % never change.
    if even
        b(1) = -1.0;
        c(1) =  1.0;
    else
        b(1) = -1.0;
    end
    for i=2:N-1
        a(i) = 1.0 + h*x(i)/(1.0-x(i)*x(i));
        b(i) = -(2.0-h*h*lambda/(1.0-x(i)*x(i)));
        c(i) = 1.0 - h*x(i)/(1.0-x(i)*x(i));
    end
    switch bccase
        case 1
            b(N) = -1.0;
            r(N) = -1.0;
        case 2
            b(N) = -(1.0 - h*lambda/2.0);
            a(N) =  1.0;
            r(N) = 0.0;
        case 3
            b(N) = 0.0;
            a(N) =  1.0;
            r(N) = 1 - h*lambda/2.0;
    end
    % Solve the Tridiagonal system
    u = NumericalRecipes.tridag(a,b,c,r);
    figure(1)
    plot(x,u)
    hold on
    if even 
        plot(-x,u)
    else
        plot(-x,-u)
    end
    hold off
    title('P(x)');
    P = u;
end