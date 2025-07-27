% Solve the linearized Block-Tridiagonal system.
% Uses conservative cell-centered discretization.
clear all;
qm = 25;
n = 2;
N = 1000;
lambda = -3.5;
% EPS = 1e-8;
periodic = true;

h=1.0/double(N);  % step size
x = 0.0:h:1.0; % array of x values at zone faces
xh = 0.5*h:h:1.0; % array of x values at zone centers
t1 = acos(xh);
t2 = acos(-xh);
% Set up storage for:
u = zeros(2,N); % solution u(1) = y, u(2)=lambda
r = zeros(2,N); % right hand side
a = zeros(2,2,N); % lower block diagonal
b = zeros(2,2,N); % block diagonal
c = zeros(2,2,N); % upper block diagonal
%
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
%     if periodic
%     %     u(2,:) = n^2-6;
%         u(2,:) = lambda;
%     else
%         u(2,:) = lambda;
%     end
    for k=1:100
        % Compute RHS and b
        % u(2,1) is a1  u(2,i) is an    u(1,i) is yn
        if periodic
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

    %
%     if k==1
%         figure(1)
%         cla
%         subplot(2,1,1)
%         plot(xh,u(1,:))
%         hold on
%         plot(-xh,u(1,:))
%         hold off
%         subplot(2,1,2)
%         plot(xh,u(2,:))
%         pause(0.1);
%     end
    % Correct solution
        u = u - du;
        lambda = u(2,N);  % take the solution at x=1 to define lambda
%     fprintf('Iter %3d: lambda = %.6f; |delta| = (%.6g, %.6g)\n',k,lambda,du_norm(1),du_norm(2));
%     fprintf('                               |RHS| = (%.9g, %.9g)\n',r_norm(1),du_norm(2));
%     figure(1)
%     subplot(2,1,1)
%     plot(xh,u(1,:))
%     hold on
%     plot(-xh,u(1,:))
%     hold off
%     subplot(2,1,2)
%     plot(xh,u(2,:))
        pause(0.1);
        if max(du_norm) < EPS
            break
        end
    end
end

fprintf('a%d = %.6f\n',n,lambda);
figure(1)
% subplot(2,1,1)
plot(xh,u(1,:))

% plot(t1,u(1,:))

hold on
% plot(-xh,u(1,:))
% plot(t2,-u(1,:))
hold off
% subplot(2,1,2)
% plot(xh,u(2,:))


% figure(1)
% P = u(1,:);
% fprintf('a%d = %.6f\n',n,lambda);
% figure(1)
% plot(t1,u(1,:))
% hold on
% plot(t2,-u(1,:))
% hold off



