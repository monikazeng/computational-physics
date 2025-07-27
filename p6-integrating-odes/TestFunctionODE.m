classdef TestFunctionODE < NumericalRecipes.FunctorODE
    properties
        eps
    end
    methods
        function obj = TestFunctionODE(eps)
            obj = obj@NumericalRecipes.FunctorODE();
            obj.eps = eps;
        end
        function derivs = dydx(obj,x,y)
            derivs(1) = y(2);
            derivs(2) = ((1.0-y(1)*y(1))*y(2) - y(1))/obj.eps;
        end
    end
end