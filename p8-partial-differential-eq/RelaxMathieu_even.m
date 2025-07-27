function RelaxMathieu_even(qm,n,plt)
    % Solve the linearized Block-Tridiagonal system.
    % Uses conservative cell-centered discretization.
    N = 1000;

    h=1.0/double(N);  % step size
    xh = 0.5*h:h:1.0; % array of x values at zone centers
    % Set up storage for:
    u = zeros(2,N); % solution u(1) = y, u(2)=lambda
    r = zeros(2,N); % right hand side
    a = zeros(2,2,N); % lower block diagonal
    b = zeros(2,2,N); % block diagonal
    c = zeros(2,2,N); % upper block diagonal

    % set value for upper and lower diagonals since the values in these
    % never change.
    c(1,1,1) = (1.0 - xh(1)*xh(1) - h/2*xh(1));
    c(2,2,1) = 1;
    for i=2:N-1
        a(1,1,i) = 1.0 - xh(i)*xh(i) + h/2* xh(i);
        c(1,1,i) = 1.0 - xh(i)*xh(i) - h/2*xh(i);
        a(2,2,i) = 1.0;
        c(2,2,i) = 1.0;
    end
    a(1,1,N) = (1.0 - xh(N)*xh(N) + h/2*xh(N));
    a(2,2,N) = 1.0;
    
    % initialize guess solution
    u(1,:) = cos(n*acos(xh));
    u(2,:) = n^2;
    
    for q = 0:qm
        if q<qm
            EPS = 1.0e-3;
        else
            EPS = 1.0e-8;
        end
        for k=1:100
            % Compute RHS and b
            % u(2,1) is a1  u(2,i) is an    u(1,i) is yn
            if mod(n,2) == 0
                b(1,1,1) = -1.0 + xh(1)*xh(1) + h/2*xh(1) + h*h*(u(2,1)+2*q-4*q*xh(1)*xh(1));
                b(2,2,1) = -1.0;
                r(1,1) = (1-xh(1)*xh(1)-0.5*h*xh(1))*u(1,2)-(1-xh(1)*xh(1)-0.5*h*xh(1)-h*h*(u(2,1)+2*q-4*q*xh(1)*xh(1)))*u(1,1);
                r(2,1) = -u(2,1) + u(2,2);
            else
                b(1,1,1) = -(3-3*xh(1)*xh(1)+0.5*h*xh(1)-h*h*(u(2,1)+2*q-4*q*xh(1)*xh(1)));
                b(1,2,1) = h*h*u(1,1);
                b(2,2,1) = -1.0;
                r(1,1) = (1-xh(1)*xh(1)-0.5*h*xh(1))*u(1,2)-(3-3*xh(1)*xh(1)+0.5*h*xh(1)-h*h*(u(2,1)+2*q-4*q*xh(1)*xh(1)))*u(1,1);
                r(2,1) = -u(2,1) + u(2,2);
            end
            for i=2:N-1
                b(1,1,i) = -2.0 + 2.0*xh(i)^2 + h^2*(u(2,i)+2*q-4*q*xh(i)*xh(i));
                b(1,2,i) = h*h*u(1,i);
                b(2,2,i) = -2.0;
                r(1,i) = a(1,1,i)*u(1,i-1) + b(1,1,i)*u(1,i) + c(1,1,i)*u(1,i+1);
                r(2,i) = u(2,i-1) - 2.0*u(2,i) + u(2,i+1);
            end
            b(1,1,N) = -3 + 3*xh(N)*xh(N) + h/2*xh(N) + h*h*(u(2,N)+2*q-4*q*xh(N)*xh(N));
            b(1,2,N) = h*h*u(1,N);
            b(2,1,N) = -4.0/h;
            b(2,2,N) = -3.0;
            r(1,N) = a(1,1,N)*u(1,N-1) + b(1,1,N)*u(1,N)+2*(1-xh(N)*xh(N)-0.5*h*xh(N));
            r(2,N) = u(2,N-1) - 3.0*u(2,N) + (u(1,N)-1)*b(2,1,N)+4*q;
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

            u = u - du;
            lambda = u(2,N);  % take the solution at x=1 to define lambda
            pause(0.1);
            if max(du_norm) < EPS
                break
            end
        end
    end
    
    fprintf('a%d = %.6f\n',n,lambda);
    if q == 5
        figure(1)
        sgtitle('q = 5')
    else 
        figure(2)
        sgtitle('q = 25')
    end
    subplot(5,2,plt);
    plot(xh,u(1,:))
    title("n = "+n+", a = "+lambda)
    xlabel('x');
    ylabel('y(x)');


end


