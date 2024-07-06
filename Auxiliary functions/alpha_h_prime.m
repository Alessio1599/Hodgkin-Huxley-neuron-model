function [ahp]=alpha_h_prime(V)
global gNa  gK  gEq C ENa EK EEq

ahp=-(0.07/20)*exp((-65-V)/20);
%ah=0.07*exp((-65-V)/20);
end