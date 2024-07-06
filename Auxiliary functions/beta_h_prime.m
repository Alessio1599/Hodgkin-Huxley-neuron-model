function [bhp]=beta_h_prime(V)

bhp=-(-0.1*exp((-35-V)/10))/(exp((-35-V)/10)+1)^2;

%bh=1/(    exp((-35-V)/10)+1    );
end