% Problem 1

x = linspace(0,3*pi,100);
y = sin(x);

% approximations of sin(x) with different values of N
app1 = approxSin(x, 1);
app2 = approxSin(x, 2);
app3 = approxSin(x, 3);
app4 = approxSin(x, 4);
app5 = approxSin(x, 5);
app6 = approxSin(x, 10);
app7 = approxSin(x, 15);

% larger values of N
app8 = approxSin(x, 50);
app9 = approxSin(x, 100);
app10 = approxSin(x, 180);

figure(1)
plot(x,y,x,app1,x,app2,x,app3,x,app4,x,app5,x,app6,x,app7,x,app8,x,app9,x,app10)
title('actual function vs. approximation for sin(x) with different N values')
xlabel('x')
ylabel('sin(x)')
legend('y=sin(x)','N=1','N=2','N=3','N=4','N=5','N=10','N=15','N=50','N=100','N=180')

figure(2)
plot(x,y,x,app5)
title('actual function vs. approximation for sin(x) with N=5')
xlabel('x')
ylabel('sin(x)')
legend('y=sin(x)','N=5')

figure(3)
plot(x,y,x,app1,x,app2,x,app3,x,app4,x,app5)
title('actual function vs. approximation for sin(x) with small N values')
xlabel('x')
ylabel('sin(x)')
legend('y=sin(x)','N=1','N=2','N=3','N=4','N=5')

figure(4)
plot(x,y,x,app8,x,app9,x,app10)
title('actual function vs. approximation for sin(x) with large N values')
xlabel('x')
ylabel('sin(x)')
legend('y=sin(x)','N=8','N=9','N=10')

figure(5)
plot(x,y,x,app10)
title('actual function vs. approximation for sin(x) with N=180')
xlabel('x')
ylabel('sin(x)')
legend('y=sin(x)','N=180')


% Comment:
% Comparing figure 3 and 4, we can see that larger N values produce much
% accurate values. However, when the N value gets too large, for example
% N=180 in figure 5, the k in approximation gets too large so that the 
% values the computer gives are infinity so it stops producing values.
%
% In figure 2, we can see that the approximated value starts vary largely
% after around x = 5. This is the plot for N = 5. I also notice that if
% N=4, approximated value starts vary largely around x = 4, and so forth
% for the other values of N.


% error functions with different values of N
err1 = app1 - sin(x);
err2 = app2 - sin(x);
err3 = app3 - sin(x);
err4 = app4 - sin(x);
err5 = app5 - sin(x);
err6 = app6 - sin(x);
err7 = app7 - sin(x);
err8 = app8 - sin(x);
err9 = app9 - sin(x);
err10 = app10 - sin(x);

figure(6)
plot(x,err1,x,err2,x,err3,x,err4,x,err5,x,err6,x,err7,x,err8,x,err9,x,err10)
title('error functions with different N values')
xlabel('x')
ylabel('truncation error')
legend('N=1','N=2','N=3','N=4','N=5','N=10','N=15','N=50','N=100','N=180')

figure(7)
plot(x,err1,x,err2,x,err3,x,err4,x,err5)
title('error functions with small N values')
legend('N=1','N=2','N=3','N=4','N=5')
xlabel('x')
ylabel('error')

figure(8)
plot(x,err8,x,err9,x,err10)
title('error functions with large N values')
legend('N=50','N=100','N=180')
xlabel('x')
ylabel('error')


% Comment:
% Comparing figure 7 and 8, we can see that larger N values produce much
% smaller errors. The range of errors for figure 7 is from -800 to 800,
% while for figure 8 is from -1.5e-13 to 1.05e-1, which is signicantly much
% much smaller.



% L2 norm of error
errnorm(1) = l2norm(err1);
errnorm(2) = l2norm(err2);
errnorm(3) = l2norm(err3);
errnorm(4) = l2norm(err4);
errnorm(5) = l2norm(err5);
errnorm(6) = l2norm(err6);
errnorm(7) = l2norm(err7);
errnorm(8) = l2norm(err8);
errnorm(9) = l2norm(err9);
errnorm(10) = l2norm(err10);

figure(9)
plot(1:10,errnorm)
title('l2 norm for different N values')
xlabel('N')
ylabel('l2 norm')


% Comment:
% As expected, larger N values produce much smaller L2 norm for errors.


% function to compute the approximation of sin(x)
% takes input: value x and N
function y = approxSin(x, N)
    y = 0;
    for k = 1:N
        curr = ((-1)^(k-1)) * x.^(2*(k-1)+1) / factorial(2*(k-1)+1);
        y = curr + y;
    end
end


% function to compute the l2 norm
% takes input: error function 
function errnorm = l2norm(err)
    n = 50;
    errnorm = single(0);
    for i=1:n
        errnorm = errnorm + err(i)*err(i);
    end
end


