% The Odd, Periodic solutions to Mathieu's equation
% using the Spectral Technique
% MSep returns only n=2,10 solutions.

function MathieuOP(qm,plt)
t=0:pi/200:2*pi;
[evals, evecs] = MSep(qm,20,t);

fprintf('b_2 = %.10g\n',evals(1));
fprintf('b_10 = %.10g\n',evals(2));

figure(plt)
sgtitle('ODD PERIODIC')
cla
subplot(2,1,1)
plot(t,evecs(:,1))
xlabel('t')
ylabel('y_2')
title("q = "+qm+", n = 2, b = "+evals(1))
subplot(2,1,2)
plot(t,evecs(:,2))
xlabel('t')
ylabel('y_{10}')
title("q = "+qm+", n = 10, b = "+evals(2))
end

function [ev,y] = MSep(q,K,t)
    % store the matrix elements for the Even/Periodic solutions
    a = zeros(K,K);
    a(1,1) = 2*2;
    a(1,2) = q;
    for k=2:K-1
        a(k,k-1) = q;
        a(k,k) = (2.0*(k-1)+2)^2;
        a(k,k+1) = q;
    end
    a(K,K-1) = q;
    a(K,K) = (2.0*(K-1)+2)^2;
    
    % solve the eigenvalue problem
    [V,D] = eig(a);
  
    % Return the solutions for n=2,10
    ev = [D(1,1),D(5,5)];
    y = zeros(length(t),2);
    for k=1:K
        y(:,1) = y(:,1) + V(k,1)*cos(2*k*t(:));
        y(:,2) = y(:,2) + V(k,5)*cos(2*k*t(:));
    end
end