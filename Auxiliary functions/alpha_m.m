function [am]=alpha_m(V)
am=0.1* ((-40-V)/(exp((-40-V)/10)-1));
end