% Trivial example of loss of precision due to subtraction
%
format short % causes only a few digits to be printed
                      % short is the default
a=single(1);
b=single(1);
c=single(pi/10^6);
d=10^6*((a+c)-b)
d=10^6*((a-b)+c)
format long % causes more digits to be printed
d
%
ad=1;
bd=1;
cd=pi/10^6;
dd=10^6*((ad-cd)-bd)
dd=10^6*((ad-bd)+cd)
