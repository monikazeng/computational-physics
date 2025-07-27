clear all

%%% q = 5
fprintf('        ---- Eigenvalues for q = 5 ----\n');
fprintf('            ---- EVEN PERIODIC ----\n');
MathieuEP(5,1);
fprintf('          ---- EVEN ANTIPERIODIC ----\n');
MathieuEA(5,2);
fprintf('            ---- ODD PERIODIC ----\n');
MathieuOP(5,3);
fprintf('          ---- ODD ANTIPERIODIC ----\n');
MathieuOA(5,4);

%%% q = 25
fprintf('\n\n')
fprintf('        ---- Eigenvalues for q = 25 ----\n');
fprintf('            ---- EVEN PERIODIC ----\n');
MathieuEP(25,5);
fprintf('          ---- EVEN ANTIPERIODIC ----\n');
MathieuEA(25,6);
fprintf('            ---- ODD PERIODIC ----\n');
MathieuOP(25,7);
fprintf('          ---- ODD ANTIPERIODIC ----\n');
MathieuOA(25,8);