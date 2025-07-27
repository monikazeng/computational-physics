%%% homework 3 Problem 2 -- Define funct class

classdef funct < NumericalRecipes.Functor 
  properties
      acc;      % accuracy
      count;    % times the integrand is evaluated with x 
  end
  methods
    function obj = funct(acc_input)
%      function obj = funct()
          obj = obj@NumericalRecipes.Functor();
          obj.acc = acc_input;
          obj.count = 0;
     end
     function val = func(obj,x)
        obj.count = obj.count+1;
        boundy1 = ((x*3) - sqrt(-16*(x^2)+10))/5;
        boundy2 = ((x*3) + sqrt(-16*(x^2)+10))/5;
        f = NumericalRecipes.Midpnt(@(y) exp(-x*sin(y)), boundy1, boundy2);
        val = (NumericalRecipes.qromo(f, obj.acc));
    end
  end
end


% myf = funct(10^-10);
% myf.func(0)