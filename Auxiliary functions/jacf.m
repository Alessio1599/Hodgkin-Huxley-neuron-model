function [jf]=jacf(t,X)

global gNa  gK  gEq C ENa EK EEq

jf=[(1/C)*(-gNa*X(2)^3*X(3)-gK*X(4)^4-gEq) (1/C)*(-3*gNa*X(2)^2*X(3)*(X(1)-ENa) ) (1/C)*(gNa*X(2)^3*(X(1)-ENa)) (1/C)*(-4*gK*X(4)^3*(X(1)-EK)) 
    alpha_m_prime(X(1))*(1-X(2))-beta_m_prime(X(1))*X(2) -alpha_m(X(1))-beta_m(X(1)) 0 0
    alpha_h_prime(X(1))*(1-X(3))-beta_h_prime(X(1))*X(3) 0 -alpha_h(X(1))-beta_h(X(1)) 0
    alpha_n_prime(X(1))*(1-X(4))-beta_n_prime(X(1))*X(4) 0 0 -alpha_n(X(1))-beta_n(X(1)) ];
end