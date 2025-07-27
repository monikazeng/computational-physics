classdef SimpleRandom < handle
    % Simple "linear congruential generator" for pseudo-random numbers.
    % I_{j+1} = Mod(a*I_{j}+b,m); return I_{j+1}/m
    %
    properties
        a
        b
        m
        r
    end
    methods
        function obj = SimpleRandom(aa,bb,mm,rr)
            obj.a = uint32(aa);
            obj.b = uint32(bb);
            obj.m = uint32(mm);
            obj.r = uint32(rr);
        end
        function res = int32(obj) 
            obj.r = mod(obj.a*obj.r + obj.b,obj.m);
            res = obj.r;
        end
        function dran = doub(obj)
            x = obj.int32();
            dran =double(x)/double(obj.m);
        end
    end
end