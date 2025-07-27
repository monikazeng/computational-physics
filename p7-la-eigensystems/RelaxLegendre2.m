% Solve the linearized Block-Tridiagonal system.
% Uses conservative cell-centered discretization.
function [lambda,xh,P] = RelaxLegendre2(even,lambda,N,EPS)
    h=1.0/double(N);  % step size
    x = 0.0:h:1.0; % array of x values at zone faces
    xh = 0.5*h:h:1.0; % array of x values at zone centers
    % Set up storage for:
    u = zeros(2,N); % solution u(1) = P, u(2)=lambda
    r = zeros(2,N); % right hand side
    a = zeros(2,2,N); % lower block diagonal
    b = zeros(2,2,N); % block diagonal
    c = zeros(2,2,N); % upper block diagonal
    %
    % set value for upper and lower diagonals since the values in these
    % never change.
    c(1,1,1) = (1.0 - x(2)*x(2));
    c(2,2,1) = 1;
    for i=2:N-1
        a(1,1,i) = 1.0 - x(i)*x(i);
        c(1,1,i) = 1.0 - x(i+1)*x(i+1);
        a(2,2,i) = 1.0;
        c(2,2,i) = 1.0;
    end
    a(1,1,N) = (1.0 - x(N)*x(N));
    a(2,2,N) = 1.0;
    %
    % Initialize our guess solutions
    if even
        u(1,:) = xh; % Choose and odd guess if solution is even
    else
        u(1,:) = 1.0;  % Choose and even guess if solution is odd
    end
    u(2,:) = lambda;
    %
    % Newton Iterations
    for k=1:100
        % Compute RHS and b
        if even
            b(1,1,1) = -(1.0 - x(2)*x(2)) + h*h*u(2,1);
        else
            b(1,1,1) = -(1.0 - x(2)*x(2)) + h*h*u(2,1) -2.0;
        end
        b(2,2,1) = -1.0;
        r(1,1) = b(1,1,1)*u(1,1) + c(1,1,1)*u(1,2);
        r(2,1) = -u(2,1) + u(2,2);
        for i=2:N-1
            b(1,1,i) = h*h*u(2,i) - a(1,1,i) - c(1,1,i);
            b(1,2,i) = h*h*u(1,i);
            b(2,2,i) = -2.0;
            r(1,i) = a(1,1,i)*u(1,i-1) + b(1,1,i)*u(1,i) + c(1,1,i)*u(1,i+1);
            r(2,i) = u(2,i-1) - 2.0*u(2,i) + u(2,i+1);
        end
        b(1,1,N) = h*h*u(2,N) - a(1,1,N);
        b(1,2,N) = h*h*u(1,N);
        b(2,1,N) = -8.0/h;
        b(2,2,N) = -3.0;
        r(1,N) = a(1,1,N)*u(1,N-1) + b(1,1,N)*u(1,N);
        r(2,N) = u(2,N-1) - 3.0*u(2,N) + (u(1,N)-1)*b(2,1,N);
        %
        % Solve the Block Tridiagonal system
        du = NumericalRecipes.BlockTridag(a,b,c,r);
        %
        % Compute Norm or RHS and du vectors for diagnostice and 
        % termination criteria
        r_norm(1) = sqrt(sum(r(1,:).^2)/N);
        r_norm(2) = sqrt(sum(r(2,:).^2)/N);
        du_norm(1) = sqrt(sum(du(1,:).^2)/N);
        du_norm(2) = sqrt(sum(du(2,:).^2)/N);
        %
        if k==1
            figure(1)
            cla
            subplot(2,1,1)
            plot(xh,u(1,:))
            hold on
            if even 
                plot(-xh,u(1,:))
            else
                plot(-xh,-u(1,:))
            end
            hold off
            subplot(2,1,2)
            plot(xh,u(2,:))
            pause(0.1);
        end
        % Correct solution 
        u = u - du;
        lambda = u(2,N);  % take the solution at x=1 to define lambda
        fprintf('Iter %3d: lambda = %.6f; |delta| = (%.6g, %.6g)\n',k,lambda,du_norm(1),du_norm(2));
        fprintf('                               |RHS| = (%.9g, %.9g)\n',r_norm(1),du_norm(2));
        figure(1)
        subplot(2,1,1)
        plot(xh,u(1,:))
        hold on
        if even 
            plot(-xh,u(1,:))
        else
            plot(-xh,-u(1,:))
        end
        hold off
        subplot(2,1,2)
        plot(xh,u(2,:))
        pause(0.1);
        if max(du_norm) < EPS
            break
        end
    end
    P = u(1,:);
end