% Solve the linear Tridiagonal system using iterative improvement.
% This approach does not allow us to easily know when our choice of
% the eigenvalue lambda yields a valid solution.
function [lambda,x,P] = LegendreFDEII(even,lambda,N,EPS)
    h=1.0/double(N-1);  % step size
    x = 0:h:1.0; % array of x values
    % Set up storage for:
    u = zeros(1,N); % solution u(1) = P
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
        case 2
            b(N) = -(1.0 - h*lambda/2.0);
            a(N) =  1.0;
        case 3
            b(N) = 0.0;
            a(N) =  1.0;
    end
    %
    % Initialize our guess solutions
    if even
        u(1,:) = 1.0; % Choose an even guess if solution is even
    else
        u = x;  % Choose an odd guess if solution is odd
    end
    %
    % Newton Iterations
    for k=1:100
        % Compute RHS and b
        % Note, RHS is actually a residual
        r(1) = b(1)*u(1) + c(1)*u(2);
        for i=2:N-1
            r(i) = a(i)*u(i-1) + b(i)*u(i) + c(i)*u(i+1);
        end
        switch bccase
            case 1
                r(N) = b(N)*u(N) + 1.0;
            case 2
                r(N) = a(N)*u(N-1) + b(N)*u(N);        %
            case 3
                r(N) = a(N)*u(N-1) - (1.0 - h*lambda/2.0);        %
        end
        % Solve the Tridiagonal system
        du = NumericalRecipes.tridag(a,b,c,r);
        %
        % Compute Norm or RHS and du vectors for diagnostice and 
        % termination criteria
        r_norm = sqrt(sum(r.^2)/N);
        du_norm = sqrt(sum(du.^2)/N);
        %
        % Correct solution
        if k==1
            figure(1)
            cla
            plot(x,u)
            hold on
            if even 
                plot(-x,u)
            else
                plot(-x,-u)
            end
            hold off
            title('P(x)');
           % pause
        end
        u = u - du;
        fprintf('Iteration %3d: lambda = %.4f; |delta| = %.9g\n',k,lambda,du_norm);
        fprintf('                                |RHS| = %.9g\n',r_norm);
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
        figure(2)
        plot(x,r)
        title('Residual');
%         pause
        if du_norm < EPS
            break
        end
    end
    P = u;
end