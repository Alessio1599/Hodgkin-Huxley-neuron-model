function [an]=alpha_n(V)
an=0.01*((-55-V)/(exp((-55-V)/10 )-1));
end