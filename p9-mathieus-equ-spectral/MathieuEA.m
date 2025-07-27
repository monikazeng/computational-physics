% The Even, Antieriodic solutions to Mathieu's equation
% using the Spectral Technique
% MSep returns only n=1,15 solutions.

function MathieuEA(qm,plt)
t=0:pi/200:2*pi;
[evals, evecs] = MSep(qm,20,t);

fprintf('a_1 = %.10g\n',evals(1));
fprintf('a_15 = %.10g\n',evals(2));

figure(plt)
sgtitle('EVEN ANTIPERIODIC')
cla
subplot(2,1,1)
plot(t,evecs(:,1))
xlabel('t')
ylabel('y_1')
title("q = "+qm+", n = 1, a = "+evals(1))
subplot(2,1,2)
plot(t,evecs(:,2))
xlabel('t')
ylabel('y_{15}')
title("q = "+qm+", n = 15, a = "+evals(2))
end

function [ev,y] = MSep(q,K,t)
    % store the matrix elements for the Even/Periodic solutions
    a = zeros(K,K);
    a(1,1) = q+1;
    a(1,2) = q;
    for k=2:K-1
        a(k,k-1) = q;
        a(k,k) = (2.0*(k-1)+1)^2;
        a(k,k+1) = q;
    end
    a(K,K-1) = q;
    a(K,K) = (2.0*(K-1)+1)^2;
    %
    % solve the eigenvalue problem
    [V,D] = eig(a);
    % Return the solutions for n=1,15
    ev = [D(1,1),D(8,8)];
    y = zeros(length(t),2);
    for k=1:K
        y(:,1) = y(:,1) + V(k,1)*cos((2*(k-1)+1)*t(:));
        y(:,2) = y(:,2) + V(k,8)*cos((2*(k-1)+1)*t(:));
    end
end