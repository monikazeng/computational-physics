classdef BesselFunctionODE < NumericalRecipes.FunctorODE
    properties
        counter
    end
    methods
        function obj = BesselFunctionODE()
            obj = obj@NumericalRecipes.FunctorODE();
            obj.counter = 0;
        end
        function derivs = dydx(obj,x,y)
            derivs(1) = y(2);
            derivs(2) = -1/x * y(2) - (1 - 1/(x^2))*y(1);
            obj.counter = obj.counter+1;
        end
    end
end