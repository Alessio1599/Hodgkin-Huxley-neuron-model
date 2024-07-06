function [amp]=alpha_m_prime(V)

amp=0.1*(-(exp((-40-V)/10)-1)-(-40-V)*(-1/10)*(exp((-40-V)/10) ))/((exp((-40-V)/10)-1)^2 );

%am=0.1* ( (-40-V)  /   (exp((-40-V)/10)-1)  );
end