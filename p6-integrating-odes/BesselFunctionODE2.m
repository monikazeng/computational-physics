classdef BesselFunctionODE2 < NumericalRecipes.FunctorODE
    properties
        counter
    end
    methods
        function obj = BesselFunctionODE2()
            obj = obj@NumericalRecipes.FunctorODE();
            obj.counter = 0;
        end
        function derivs = dydx(obj,x,y)
            derivs(1) = y(2)/x;
            derivs(2) = (1/x - x) * y(1);
            obj.counter = obj.counter+1;
        end
    end
end