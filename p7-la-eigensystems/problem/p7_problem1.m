%%% MathieuShoot

% Comment
% To get the eigenvalues for each n, my strategy is to first guess the
% approximate values and input them and check the plots to see if my inital
% guesses were close to the actual values.
% Since we have an exmaple (Mathiue Example.png) which is for q = 10, and I
% figured q = 5 and q = 10's range of values might be pretty similar, I 
% just used the values for q = 10 as my initial guesses. Luckily, all the 
% actual eigenvalues are relatively close to my inital guesses and I was
% able to get the right results by checking the # of zero crossings.
%
% For q = 25, the range of values of eigenvalues varied a little more from
% q = 10 (for lower n) so I just used a "brute force" type of approach. I
% tried a few values for n = 0, n = 1, and n = 2 since the plots generated
% at first were incorrect. After trying a few inital guesses, I was able to
% get the right results for q = 25 as well.

clear;

n = [0 1 2 10 15];
%%% q = 5
q = 5;
a = [-6 2 7 100 225];
b = [-6 2 100 225];
fprintf('        ---- Eigenvalues for q = 5 ----\n');
% even, n = 0, a = -5.800045778
[Mde1, a(1)] = shoot(a(1),q,true,n(1));
plotting(1,a(1),true, Mde1, n(1),q)

% antiperiodic even, n = 1, a = 1.858187849
[Mde2, a(2)] = shoot(a(2),q,true,n(2));
plotting(3,a(2),true, Mde2, n(2),q)

% even, n = 2, a = 7.449109685
[Mde3, a(3)] = shoot(a(3),q,true,n(3));
plotting(5,a(3),true, Mde3, n(3),q)

% even, n = 10, a = 100.126375063
[Mde4, a(4)] = shoot(a(4),q,true,n(4));
plotting(7,a(4),true, Mde4, n(4),q)

% antiperiodic even, n = 15, a = 225.055824151
[Mde5, a(5)] = shoot(a(5),q,true,n(5));
plotting(9,a(5),true, Mde5, n(5),q)

% antiperiodic odd, n = 1, b = -5.790080307
[Mde6, b(1)] = shoot(b(1),q,false,n(2));
plotting(4,b(1),false, Mde6, n(2),q)

% odd, n = 2, b = 2.099461344
[Mde7, b(2)] = shoot(b(2),q,false,n(3));
plotting(6,b(2),false, Mde7, n(3),q)

% odd, n = 10, b = 100.126455382
[Mde8, b(3)] = shoot(b(3),q,false,n(4));
plotting(8,b(3),false, Mde8, n(4),q)

% antiperiodic odd, n = 15, b = 225.056013077
[Mde9, b(4)] = shoot(b(4),q,false,n(5));
plotting(10,b(4),false, Mde9, n(5),q)


%%% q = 25
q2 = 25;
a2 = [-40 -21 -4 103 226];
b2 = [-40 -21 103 226];
fprintf('\n        ---- Eigenvalues for q = 25 ----\n');
% even, n = 0, a = -40.256778987
[Mde1, a2(1)] = shoot(a2(1),q2,true,n(1));
plotting(1,a2(1),true, Mde1, n(1),q2)

% antiperiodic even, n = 1, a = -21.314898907
[Mde2, a2(2)] = shoot(a2(2),q2,true,n(2));
plotting(3,a2(2),true, Mde2, n(2),q2)

% even, n = 2, a = -3.522163721
[Mde3, a2(3)] = shoot(a2(3),q2,true,n(3));
plotting(5,a2(3),true, Mde3, n(3),q2)

% even, n = 10, a = 103.230210948
[Mde4, a2(4)] = shoot(a2(4),q2,true,n(4));
plotting(7,a2(4),true, Mde4, n(4),q2)

% antiperiodic even, n = 15, a = 226.400731835
[Mde5, a2(5)] = shoot(a2(5),q2,true,n(5));
plotting(9,a2(5),true, Mde5, n(5),q2)

% antiperiodic odd, n = 1, b = -40.256778421
[Mde6, b2(1)] = shoot(b2(1),q2,false,n(2));
plotting(4,b2(1),false, Mde6, n(2),q2)

% odd, n = 2, b = -21.314859833
[Mde7, b2(2)] = shoot(b2(2),q2,false,n(3));
plotting(6,b2(2),false, Mde7, n(3),q2)

% odd, n = 10, b = 103.225745633
[Mde8, b2(3)] = shoot(b2(3),q2,false,n(4));
plotting(8,b2(3),false, Mde8, n(4),q2)

% antiperiodic odd, n = 15, b = 226.400902944
[Mde9, b2(4)] = shoot(b2(4),q2,false,n(5));
plotting(10,b2(4),false, Mde9, n(5),q2)



function [Mderivs, a] = shoot(ai, q, even, n)
    Mload = MathieuLoad(even);
    Mscore = MathieuScore(even);
    Mderivs = MathieuDerivs(q);
    MathieuShoot = NumericalRecipes.Shoot(0.0,pi,Mload,Mderivs,Mscore); 
    [a,check] = NumericalRecipes.newt(ai,MathieuShoot);

    if ~check
        if even
            fprintf('   n = %2d (even)  Newt found a = %.9f\n',n,a(1));
        else
            fprintf('   n = %2d (odd)   Newt found b = %.9f\n',n,a(1));
        end     
    else
        fprintf('   ??????  Newt found a = %.9f\n',a(1));
    end
end


function plotting(i, eigen, even, Mderivs, n, q)
    if q == 5
        figure(1)
        sgtitle('q = 5')
    else 
        figure(2)
        sgtitle('q = 25')
    end
    out=NumericalRecipes.Output(100);
    if even
        int=NumericalRecipes.Odeint(NumericalRecipes.StepperBS(),[1,0,eigen],0.0,pi,1.e-8,1.e-8,0.001,0,out,Mderivs);
    else
        int=NumericalRecipes.Odeint(NumericalRecipes.StepperBS(),[0,1,eigen],0.0,pi,1.e-8,1.e-8,0.001,0,out,Mderivs);
    end
    int.integrate();
    subplot(5,2,i);
    plot(out.xsave(1:out.count),out.ysave(1:out.count,1))
    if even
        title("n = "+n+", a = "+eigen)
    else
        title("n = "+n+", b = "+eigen)
    end
    grid on;
    xlabel('t');
    ylabel('y(t)');
end