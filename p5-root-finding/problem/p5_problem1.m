clear;
%%% Part a
% Finding Brackets
% to find the range for the brakets, I first plotted the function with the
% p value and see the approximate range for the roots. Then I plug in the
% range in zbrac for getting the brakets.
p1 = 0.1;
func1 = @(x) cos(x)-0.8+p1*(x)^2;
% Expand a range until a bracket is found:
[foundbrac, x1, x2] = NumericalRecipes.zbrac(func1,0.5,1);
N=20;
[x1a, x2a] = NumericalRecipes.zbrak(func1,-5,5,N);
fprintf('\nFOR p = 0.1    Found %d brackets\n',length(x1a));
% Bisection
fprintf('--- p = 0.1    finding roots using Bisection ---\n');
for k=1:length(x1a)
    [foundbrac,x1,x2] = NumericalRecipes.zbrac(func1,x1a(k),x2a(k));
    % need to expand bracket since we may end up with roots at bracket
    % limits.
    if foundbrac
        bisroot1 = NumericalRecipes.rtbis(func1,x1,x2,1.e-12);
        fprintf('Bracket %2d: [%f,%f]; Root at x = %.16f\n',k,x1a(k),x2a(k),bisroot1);
    end
end


p2 = 0.2;
func2 = @(x) cos(x)-0.8+p2*(x)^2;
% Expand a range until a bracket is found:
[foundbrac, x3, x4] = NumericalRecipes.zbrac(func2,0.5,1);
% Divid a range into N pieces and return all brackets
[x3a, x4a] = NumericalRecipes.zbrak(func2,-5,5,N);
fprintf('\nFOR p = 0.2    Found %d brackets\n',length(x3a));
% Bisection
fprintf('--- p = 0.2    finding roots using Bisection ---\n');
for k=1:length(x1a)
    [foundbrac,x3,x4] = NumericalRecipes.zbrac(func2,x3a(k),x4a(k));
    % need to expand bracket since we may end up with roots at bracket
    % limits.
    if foundbrac
        bisroot2 = NumericalRecipes.rtbis(func2,x3,x4,1.e-12);
        fprintf('Bracket %2d: [%f,%f]; Root at x = %.16f\n',k,x3a(k),x4a(k),bisroot2);
    end
end


p3 = 0.3;
func3 = @(x) cos(x)-0.8+p3*(x)^2;
% Expand a range until a bracket is found:
[foundbrac, x5, x6] = NumericalRecipes.zbrac(func3,1,1.2);
% Divid a range into N pieces and return all brackets
[x5a, x6a] = NumericalRecipes.zbrak(func3,-3,3,N);
fprintf('\nFOR p = 0.3    Found %d brackets\n',length(x5a));
% Bisection
fprintf('--- p = 0.3    finding roots using Bisection ---\n');
for k=1:length(x1a)
    [foundbrac,x5,x6] = NumericalRecipes.zbrac(func3,x5a(k),x6a(k));
    % need to expand bracket since we may end up with roots at bracket
    % limits.
    if foundbrac
        bisroot3 = NumericalRecipes.rtbis(func3,x5,x6,1.e-12);
        fprintf('Bracket %2d: [%f,%f]; Root at x = %.16f\n',k,x5a(k),x6a(k),bisroot3);
    end
end


p4 = 0.4;
x=-10:0.05:10;
func4 = @(x) cos(x)-0.8+p4*(x)^2;
[foundbrac, x9, x10] = NumericalRecipes.zbrac(func4,-10,10);
% Divid a range into N pieces and return all brackets
[x9a, x10a] = NumericalRecipes.zbrak(func4,-3,3,N);
fprintf('\nFOR p = 0.4    Found %d brackets\n',length(x9a));
fprintf('--- p = 0.4    function has no roots ---\n');



% when p = 0.4, the function does not have any roots. I plotted the
% function and it confirmed that there are no roots. 
figure(1);
plot(x,cos(x)-0.8+p4*(x).^2);
title('when p = 0.4 function has no roots')
grid on;
line([0,0], ylim, 'Color', 'k', 'LineWidth', 2); % Draw line for Y axis.
line(xlim, [0,0], 'Color', 'k', 'LineWidth', 2); % Draw line for X axis.
xlabel('x');
ylabel('f(x)');



%%% Part b
fprintf('\n\nPart b     find p that has double roots\n');
% function has no roots
% to find double roots, we need to make the orginal function f(x) = 0
% and the 1st deriative function f'(x) = 0
% f(x) = cosx - 0.8 + px^2 = 0
% f'(x) = -sinx + 2px = 0
% p = sinx / 2x
% the function: cosx - 0.8 + sinx/2 * x gives the possible double roots
func = @(x) cos(x)-0.8+sin(x)/2*x;

figure(2);
x=-20:0.05:20;
plot(x,cos(x)-0.8+sin(x)/2.*x);
grid on;
line([0,0], ylim, 'Color', 'k', 'LineWidth', 2); % Draw line for Y axis.
line(xlim, [0,0], 'Color', 'k', 'LineWidth', 2); % Draw line for X axis.
title('find p for double roots')
xlabel('x');
ylabel('cos(x)-0.8+sin(x)/2*x');

% plotting the above function, I found a pair of double roots near |1.443|
% Expand a range until a bracket is found:
[foundbrac, x7, x8] = NumericalRecipes.zbrac(func,1.3,1.6);
if foundbrac
    fprintf('\nBracket [%f,%f] found\n',x7,x8);
end

% Divid a range into N pieces and return all brackets
N=20;
[x7a, x8a] = NumericalRecipes.zbrak(func,-2,2,N);
fprintf('\nFound %d brackets\n',length(x7a));
for k=1:length(x7a)
    fprintf('Bracket %2d: [%f,%f]\n',k,x7a(k),x8a(k));
end

% Bisection
fprintf('\n--- Finding roots using Bisection ---\n');
for k=1:length(x7a)
    [foundbrac,x7,x8] = NumericalRecipes.zbrac(func,x7a(k),x8a(k));
    % need to expand bracket since we may end up with roots at bracket
    % limits.
    if foundbrac
        bisroot = NumericalRecipes.rtbis(func,x7,x8,1.e-12);
        fprintf('Bracket %2d: [%f,%f]; Root at x = %.16f\n',k,x7a(k),x8a(k),bisroot);
    end
end
% with the roots found, we can calculate the p corresponding to that pair
% of double roots
p = sin(bisroot)/(2*bisroot);
fprintf('p corresponding to the double roots: p = %.4f\n', p);

% since the function cosx - 0.8 + sinx/2 * x is periodic, it will give an
% infinite amount of double roots. We can plot the function and get the
% approximate range for one of the pair of the double roots and use 
% Bisection method to find the exact values for the roots. 
% Then we can use the roots to find the p that corresponds to that double 
% roots.
% for example, from plotting, I see a pair of double roots at around |1.5|
% so I set the range to 1.3 to 1.6 for the brakets and hence found the
% exact roots. Then I used the roots to find the p value through the
% formula p = sinx / 2x

