function [dXdt]=fun(t,X)
global gNa  gK  gEq C ENa EK EEq

i=6;%applied current

dXdt=[ (1/C)*(-gNa*X(2)^3*X(3)*(X(1)-ENa) -gK*X(4)^4*(X(1)-EK)-gEq*(X(1)-EEq)+i )
    alpha_m(X(1))*(1-X(2))-beta_m(X(1))*X(2)
    alpha_h(X(1))*(1-X(3))-beta_h(X(1))*X(3)
    alpha_n(X(1))*(1-X(4))-beta_n(X(1))*X(4)];
end