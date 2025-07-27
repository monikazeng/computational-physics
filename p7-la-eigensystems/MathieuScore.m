classdef MathieuScore < NumericalRecipes.FunctorShoot
    properties
        even
    end
    methods
        function obj = MathieuScore(even)
            obj.even = even;
        end
        function y = vector(obj,t,v)
            % v(1) = Y, v(2)=Z, v(3)=a
            % y(1,1) = P or Q
            if obj.even
                y(1,1) = v(2);
            else
                y(1,1) = v(1);
            end
        end
    end
end