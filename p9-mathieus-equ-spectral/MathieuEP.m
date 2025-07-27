% The Even, Periodic solutions to Mathieu's equation
% using the Spectral Technique
% MSep returns only n=0,2,10 solutions.

function MathieuEP(qm,plt)

t=0:pi/200:2*pi;
[evals, evecs] = MSep(qm,20,t);

fprintf('a_0 = %.10g\n',evals(1));
fprintf('a_2 = %.10g\n',evals(2));
fprintf('a_10 = %.10g\n',evals(3));

figure(plt)
sgtitle('EVEN PERIODIC')
cla
subplot(3,1,1)
plot(t,evecs(:,1))
xlabel('t')
ylabel('y_0')
title("q = "+qm+", n = 0, a = "+evals(1))
subplot(3,1,2)
plot(t,evecs(:,2))
xlabel('t')
ylabel('y_2')
title("q = "+qm+", n = 2, a = "+evals(2))
subplot(3,1,3)
plot(t,evecs(:,3))
xlabel('t')
ylabel('y_{10}')
title("q = "+qm+", n = 10, a = "+evals(3))
end

function [ev,y] = MSep(q,K,t)
% store the matrix elements for the Even/Periodic solutions
a = zeros(K,K);
a(1,2) = sqrt(2.0)*q;
for k=2:K-1
    a(k,k-1) = q;
    if k == 2
        a(k,k-1) = sqrt(2.0)*q;
    end
    a(k,k) = (2.0*(k-1))^2;
    a(k,k+1) = q;
end
a(K,K-1) = q;
a(K,K) = (2.0*(K-1))^2;
tr = zeros(K,K);
tr(1,1) = sqrt(2);
for i = 2:K
    tr(i,i) = 1;
end
% solve the eigenvalue problem
[V,D] = eig(a);
V = tr*V;
% Return the solutions for n=0,2,10
ev = [D(1,1),D(2,2),D(6,6)];
y = zeros(length(t),3);
y(:,1) = V(1,1)/2.0;
y(:,2) = V(1,2)/2.0;
y(:,3) = V(1,6)/2.0;
for k=2:K
    y(:,1) = y(:,1) + V(k,1)*cos(2*(k-1)*t(:));
    y(:,2) = y(:,2) + V(k,2)*cos(2*(k-1)*t(:));
    y(:,3) = y(:,3) + V(k,6)*cos(2*(k-1)*t(:));
end
end