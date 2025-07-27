% classdef MathieuDerivs < NumericalRecipes.FunctorODE
%     methods(Static)
%         function derivs = dydx(t,y)
%             q = 10;
%             % y(1) = Y, y(2)=Z, y(3)=a
%             derivs(1) = y(2);                       % dy/dt
%             derivs(2) = -(y(3) - 2.0*q*cos(2.0*t)) * y(1);     % dz/dt
%             derivs(3) = 0.0;
%         end
%     end
% end


classdef MathieuDerivs < NumericalRecipes.FunctorODE
    properties
        q
    end
    methods
        function obj = MathieuDerivs(q)
            obj.q = q;
        end
        function derivs = dydx(obj,t,y)
            % y(1) = Y, y(2)=Z, y(3)=a
            derivs(1) = y(2);                       % dy/dt
            derivs(2) = -(y(3) - 2.0*obj.q*cos(2.0*t)) * y(1);     % dz/dt
            derivs(3) = 0.0;
        end
    end
end