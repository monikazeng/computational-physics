classdef integrand1 < NumericalRecipes.Functor
    % These are class variables.  Their values are stored
    % in the instance of the class that is created when the
    % class 'constructor' is called.
    properties
        a = 1;
        n = 0;
    end
    methods
        % This is the class 'constructor'.  It is a function
        % that is the name of the class, but it can take
        % arguements that are used to set up the class.
        function obj = integrand1(n,a)
            % Because this class is derived from the
            % NumericalRecipes.Functor class, we must 
            % call this class's construction before we do
            % anything else.
            obj = obj@NumericalRecipes.Functor();
            obj.n = n;
            obj.a = a;
        end
        % The NumericalRecipes.Functor class defines
        % an 'abstract function' called fun.  The main job
        % of a class derived from Functor is to specify this
        % function.  In this case, it is intended that func
        % return some desired function evaluated at the
        % position x.
        % The function being specified is
        %   y(x) = x^n e^(-x/a)
        function val = func(obj,x)
            val = x.^obj.n .* exp(-x/obj.a);
            % This function is coded in MATLAB's array
            % notation so that it works whether or not x
            % is a single value or an array
            % The period in ".^" means that each element of the
            % array is exponentiated.  If x is an array, then
            % "x^n" it taken to be "matrix exponentiation".
            % exp(array) automatically works correctly on a 
            % single value or an array.
            % "array .* array" represents element by element
            % multiplication whereas "array * array" it taken
            % as matrix multiplication.
        end
    end
end