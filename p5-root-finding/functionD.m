classdef Hw5FunctionD < NumericalRecipes.FunctorD
    properties
        a
        b
        c
        d
        e
        f
        g
    end
    methods
        function obj = Hw5FunctionD(a,b,c,d,e,f,g)
            obj = obj@NumericalRecipes.FunctorD();
            obj.a = a;
            obj.b = b;
            obj.c = c;
            obj.d = d;
            obj.e = e;
            obj.f = f;
            obj.g = g;
        end
        function val = func(obj,x)
%             val = ((obj.a.*x + obj.b).*x + obj.c).*x +obj.d;
            val = (((((obj.a.*x + obj.b).*x + obj.c).*x +obj.d).*x +obj.e).*x +obj.f).*x +obj.g;
        end
        function val = df(obj,x)
%             val = (3.0*obj.a.*x + 2.0*obj.b).*x + obj.c;
            val = ((((6.0*obj.a.*x + 5.0*obj.b).*x + 4.0*obj.c).*x +3.0*obj.d).*x +2.0*obj.e).*x +obj.f;
        end
    end
end