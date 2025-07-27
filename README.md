# computational-physics
A collection of computational physics projects applying methods from Numerical Recipes, focusing on algorithmic implementation and interpretation of numerical results.

## Project 1
Taylor Series Truncation Error and Finite Difference Derivative Analysis
- **Problem 1:** Approximate \(sin(x)\) using a truncated Taylor series expansion. The function takes inputs \(x\) and truncation order \(N\), returning the series approximation. Truncation errors are analyzed by comparing approximations across different values of \(x\) and \(N\).
- **Problem 2:** Derive a symmetric finite difference formula for numerical differentiation using Heaviside calculus. The coefficients and leading error term are determined to understand the approximation’s accuracy.

## Project 2
Polynomial & Rational Interpolation with Numerical Integration and Quadrature Analysis
- **Problem 1:** Applied polynomial and rational interpolation methods to approximate a sharply varying function on the interval \([-1,1]\), comparing accuracy using 5 and 20 equally spaced points.  
- **Problem 2:** Derived a numerical quadrature formula with Heaviside calculus and compared it to Simpson’s rule for integration over \([0, 2h]\).

## Project 3
Numerical Integration of 1D and 2D Functions
- **Problem 1:** Numerically evaluated a set of one-dimensional integrals using adaptive quadrature (`qromo`) and Gaussian Quadrature. Explored convergence behavior and applied a transformation to improve performance for a slowly converging integral.
- **Problem 2:** Computed a two-dimensional integral over an elliptical region to high precision, using a numerical integration method of choice. Tracked the number of function evaluations and reported the computed result.

## Tools
- MATLAB for coding, plotting, and generating HTML reports.