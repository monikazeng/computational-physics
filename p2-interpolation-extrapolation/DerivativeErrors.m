% Explore the errors encountered with taking numerical derivatives
%
% Compare the errors for both "forward derivatives" and
% "centered derivatives", each using a sequence of step sizes
% stored in the array 'h'.
% 
% Start with a large step size 'h'.  In the loop, the new 
% step size is the previous step size divided by 2.
h(1)=single(0.4); % Set to "single" or "double"
for i=1:30
    if(i>1)
        h(i)=h(i-1)/2;
    end
    % derivative1_error computes "forward derivatives"
    % derivative2_error computes "centered derivatives"
    % Each function take the step size to use for the
    % numerical derivative, and returns two things:
    % 1) The values of the error between the analytic
    %    derivative and the numerical derivative at each
    %    value of x.
    % 2) The L2 norm of the error.
    [ferror1(:,i),err(i,1)]=derivative1_error(h(i));
    [ferror2(:,i),err(i,2)]=derivative2_error(h(i));
end
% Create a figure window designated by "1" to show the errors
% associated with "forward derivatives"
figure(1)
% Create an array of plots within the current figure
% The array has 2 rows and 1 column.
% Select the first plot for drawing the error as a function
subplot(2,1,1)
% Draw into the selected plot
% Data comes from
plot(myx,ferror1)
% semilogy(myx,abs(ferror1))
legend
xlabel('x')
ylabel('error')
% Select the second plot for drawing the norm of the error 
% vs h
subplot(2,1,2)
plot(log10(h),log10(err(:,1)))
xlabel('Log_{10}(h_n)')
ylabel('Log_{10}(L_2(error))')
set(gca,'fontsize', 36)
% Create a figure window designated by "2" to show the errors
% associated with "centered derivatives"
figure(2)
subplot(2,1,1)
semilogy(myx,abs(ferror2))
legend
xlabel('x')
ylabel('error')
subplot(2,1,2)
plot(log10(h),log10(err(:,2)))
xlabel('Log_{10}(h_n)')
ylabel('Log_{10}(L_2(error))')
set(gca,'fontsize', 36)
% Create a figure window designated by "3" to compare the 
% norms of the errors associated with two types of derivatives
figure(3)
plot(log10(h),log10(err))
xlabel('Log_{10}(h_n)')
ylabel('Log_{10}(L_2(error))')
legend('forward','center')
set(gca,'fontsize', 36)


function x = myx
% values of x at which to evaluate the derivative
    dx=pi/40;
    for i=0:80
        x(i+1)=i*dx;
    end
%     x=0:pi/40:2*pi;
end

% This function specifies the analytic function that will 
% have its derivative taken.
function y = myfunction(x)
% myfunction provides a common definition of a function
    y=sin(x);
end

% This function specifies the analytic derivative of the
% function defined in 'myfunction'
function dy = myderivative(x)
% myderivative provides a common definition of myfunction's first derivative
    dy=cos(x);
end

% Compute the "forward derivative" of the function defined in
% 'myfunction' using a step size of 'h', and evaluating the 
% derivative at the set of locations specified by 'myx'.
% Return an array of results.  The first element of the
% returned array contains the error between the numerical 
% derivative and the analytic derivative as a function of x.
% The second element of the returned array contains the L2
% norm of the errors.
% Use traditional loop programming.
function [ferror,err] = derivative1_error(h)
    % compute a simple numerical derivative of myfunction
    x = myx();
    n=length(x);
    for i=1:n
        ferror(i)=(myfunction(x(i)+h)-myfunction(x(i)))/h - myderivative(x(i));
    end
    err=0;
    for i=1:n
        err = err+ferror(i)*ferror(i);
    end
    err = sqrt(err/n);
end

% Compute the "centered derivative" of the function defined in
% 'myfunction' using a step size of 'h', and evaluating the 
% derivative at the set of locations specified by 'myx'.
% Return an array of results.  The first element of the
% returned array contains the error between the numerical 
% derivative and the analytic derivative as a function of x.
% The second element of the returned array contains the L2
% norm of the errors.
% Use Matlab array programming.
function [ferror,err] = derivative2_error(h)
% compute a simple numerical derivative of myfunction
    x = myx();
    ferror = (myfunction(x+h)-myfunction(x-h))/(2*h) - myderivative(x);
    err = norm(ferror)/sqrt(length(x));
end
