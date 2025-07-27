clear all

n = [0 1 2 10 15];
%%% q = 5
fprintf('        ---- Eigenvalues for q = 5 ----\n');
RelaxMathieu_even(5,n(1),1);
RelaxMathieu_even(5,n(2),3);
RelaxMathieu_even(5,n(3),5);
RelaxMathieu_even(5,n(4),7);
RelaxMathieu_even(5,n(5),9);
RelaxMathieu_odd(5,n(2),4);
RelaxMathieu_odd(5,n(3),6);
RelaxMathieu_odd(5,n(4),8);
RelaxMathieu_odd(5,n(5),10);

%%% q = 25
fprintf('        ---- Eigenvalues for q = 25 ----\n');
RelaxMathieu_even(25,n(1),1);
RelaxMathieu_even(25,n(2),3);
RelaxMathieu_even(25,n(3),5);
RelaxMathieu_even(25,n(4),7);
RelaxMathieu_even(25,n(5),9);
RelaxMathieu_odd(25,n(2),4);
RelaxMathieu_odd(25,n(3),6);
RelaxMathieu_odd(25,n(4),8);
RelaxMathieu_odd(25,n(5),10);
