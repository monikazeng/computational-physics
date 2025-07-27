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


## Project 4
Monte Carlo Integration and Ising Model Simulation
consists of three parts focused on numerical simulation and statistical mechanics:
- **Monte Carlo Integration:** Computed a two-dimensional integral over an elliptical region using Monte Carlo methods. Achieved accuracy better than 0.5%, tracked the number of integrand evaluations, and applied optimization techniques to reduce computational cost.
- **Ising Model Simulation:** Implemented a two-dimensional Ising model in MATLAB to simulate magnetic behavior in ferromagnetic materials. Used the stochastic \(Metropolis\) algorithm to update spins on an \(N * N\) grid and measured system properties at equilibrium for various temperatures.
- **Thermodynamic Quantities:** Calculated magnetization, energy, specific heat, and magnetic susceptibility as functions of temperature. These were derived using ensemble averages based on Metropolis-sampled configurations. 


## Project 5
Root Finding and Ising Model Simulation
- **Problem 1:** Used methods from the *Numerical Recipes* library to find the roots of a nonlinear equation involving a parameter. Investigated the conditions under which the equation has a double root.
- **Problem 2:** Applied a polynomial root-finding algorithm to solve a high-degree equation and identify all complex and real roots.
- **Ising Model Simulation:** Extended the implementation of a two-dimensional Ising model to study magnetic properties of a material. Verified the consistency of simulation results and analyzed the impact of lattice size and sampling duration on observed quantities.


## Project 6
Numerical Integration of Special Functions and Stability of Euler Methods
This project focuses on solving ordinary differential equations using various numerical integration techniques and analyzing their accuracy and stability.
- **Problem 1:** Integrated the differential equation for the Bessel function of the first kind using two high-accuracy solvers: Runge-Kutta (Dopr5) and Bulirsch-Stoer (BS). Starting from known values, the solution was extended to a distant point and compared against MATLAB's built-in Bessel function. Also counted derivative evaluations to compare solver efficiency.
- **Problem 2:** Re-solved the Bessel function equation starting from the origin, using a series expansion to approximate initial conditions instead of using built-in functions or recurrence relations. Explored the challenges of integrating near a singular point, tested changes in variable substitution to improve numerical behavior, and compared the stability of different formulations.
- **Problem 3:** Implemented both explicit and implicit Euler methods to solve a stiff first-order differential equation. Analyzed numerical stability by varying the number of steps, visualized the impact of step size on accuracy, and identified the minimum step count needed for stability in the explicit scheme.


## Project 7
Eigenvalue Computation and Periodic Solutions of Mathieu’s Equation

This project investigates numerical solutions to Mathieu’s equation, a second-order differential equation that arises in physical systems such as wave propagation in elliptical coordinates and celestial mechanics. The goal is to compute eigenvalues and corresponding eigenfunctions that satisfy specific periodic or antiperiodic boundary conditions.
- **Eigenvalue Computation:** Compute the eigenvalues associated with both even and odd periodic solutions of Mathieu’s equation for selected parameter values. Calculations were performed for multiple mode numbers using two different values of the equation’s parameter.
- **Boundary Conditions & Symmetry:** Carefully implemented boundary conditions to isolate periodic and antiperiodic solutions. Used symmetry properties of the equation to reduce the domain of integration and simplify the computation (e.g., integrating only to half the domain based on parity).
- **Classification of Solutions:** Distinguished between periodic even, periodic odd, antiperiodic even, and antiperiodic odd solutions. Verified the symmetry relationships and periodicity behavior as derived from theory.
- **Plotting Eigenfunctions:** Plotted the computed eigenfunctions for each eigenvalue, visually confirming periodicity and number of zeros within the interval. Observed changes in shape and behavior with increasing mode number and parameter value.
- **Strategy Explanation:** Described the numerical strategy used for identifying eigenvalues, including how boundary conditions guide the choice of integration limits and how to verify solution periodicity.


## Project 8
Relaxation Method for Solving Mathieu’s Equation Using Algebraic Formulation

This project solves Mathieu’s equation numerically via **relaxation** using its algebraic form, which arises after a variable transformation. The goal is to compute eigenvalues and eigenfunctions corresponding to periodic and antiperiodic solutions, as an extension of previous work done using shooting methods.
- **Algebraic Reformulation:** Transformed the original differential equation into algebraic form by substituting a trigonometric variable, leading to a singular Sturm–Liouville problem with known symmetry and singularities at the interval boundaries.
- **Relaxation and Discretization:** The differential equation was discretized over a uniform grid on the interval \([0, 1]\), and solved using a **block-tridiagonal matrix solver**, following techniques discussed in class.
- **Boundary Conditions:** Applied appropriate boundary conditions depending on the symmetry class of the solution (periodic even, antiperiodic even, periodic odd, antiperiodic odd). These were derived using Frobenius series expansions near the singular points and expressed in terms of the transformed function or its derivatives.
- **Eigenvalue Search:** Eigenvalues corresponding to specified modes (\(n = 0, 1, 2, 10, 15\)) were computed for multiple parameter values. Both even and odd solutions were explored, using different forms of the equation as needed.
- **Visualization:** Eigenfunctions were plotted over the interval to verify symmetry properties and compare solution structure for varying parameters.


## Project 9
Spectral Method Solution of Mathieu’s Equation

This project solves Mathieu’s equation using a **spectral method** based on Fourier series expansion. By leveraging the periodic nature of the solutions, the differential equation is transformed into an eigenvalue problem for a matrix whose entries are determined by the Fourier coefficients of the solution.
- **Fourier Expansion:** Expanded the solution as a truncated complex Fourier series. Substituted this expansion into the differential equation and expressed the result as a symmetric (or nearly symmetric) tridiagonal matrix equation.
- **Symmetry and Structure:** Used parity and periodicity properties to simplify the matrix form. Depending on the desired solution type (even/odd, period π/2π), only certain Fourier modes are included. Noted that some cases (e.g. even π-periodic) required a similarity transformation to produce a symmetric matrix form.
- **Matrix Formulation:** Constructed four different matrices corresponding to the four symmetry classes of Mathieu’s equation:
  - Periodic even
  - Antiperiodic even
  - Periodic odd
  - Antiperiodic odd
- **Eigenvalue Computation:** Solved the matrix eigenvalue problems numerically to find the eigenvalues and associated eigenvectors. Investigated accuracy and convergence as a function of matrix size (parameter \(K\)) and compared eigenvalues for \(q = 5\) and \(q = 25\), validating results against those from shooting and relaxation methods in previous assignments.
- **Eigenfunction Construction:** Used the eigenvectors of the matrices to reconstruct the corresponding eigenfunctions. Plotted results for selected modes \(n = 0, 1, 2, 10, 15\) for both parameter values and all four boundary condition types.


## Project 10
This project simulates the stationary flow of an incompressible, viscous fluid in two dimensions using the stream function–vorticity formulation. The governing equations consist of two coupled quasi-linear elliptic partial differential equations, which are solved numerically via the **Successive Overrelaxation (SOR)** method.
- **Solve Coupled PDEs:** Numerically solve the Poisson equation for the stream function ψ and the transport equation for the vorticity ξ on a structured Cartesian grid. These equations are solved iteratively and coupled via fluid dynamics identities.
- **Discretization:** Used vertex-centered finite differencing with boundary conditions placed on cell faces. Domain geometry is flexible and based on boundary segments (A–F), scaled with a base length, allowing experimentation with domain size and resolution.
- **Overrelaxation Scheme:** Implemented an iterative solver using alternating SOR updates on ψ and ξ. Each sweep updates both variables over the entire domain using the current best estimate of the other.
- **Convergence Diagnostics:** Computed the residuals of both ψ and ξ after each sweep and tracked their L2 norms. Plotted the streamwise residual ∥Rψ∥ versus iteration count for various values of the relaxation parameter ω to study convergence behavior and identify optimal values.
- **Visualization:**
  - Generated contour plots of ψ to represent fluid streamlines.
  - Calculated velocity components (vx, vy) from the stream function using centered differences and visualized the vector field using quiver plots.
  - Used residual contour plots (Rψ, Rξ) to diagnose boundary condition or numerical implementation issues.
- **Boundary Condition Handling:** Incorporated first-order boundary conditions directly for vorticity at solid surfaces to improve stability and delay onset of unphysical artifacts.
- **Parameter Exploration:**
  - Investigated how viscosity (ν), inflow velocity (v₀), and resolution affect the accuracy and stability of the solution.
  - Explored flow features at different Reynolds numbers by adjusting ν and v₀.
  - Studied the effects of moving the downstream boundary farther to suppress spurious eddies.
  

## Tools
- MATLAB for coding, plotting, and generating HTML reports.