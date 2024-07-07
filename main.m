clc
close all
clear all

addpath('Numerical methods')
addpath('Auxiliary functions')

%% Parameters
global gNa  gK  gEq C ENa EK EEq

gNa=120;
gK=35;
gEq=0.3;
C=4; %Membrane capacitance
ENa=55;
EK=-77;
EEq=-54.4;

%Initial values
V0=-65;
m0=alpha_m(V0)/(alpha_m(V0)+beta_m(V0));
h0=alpha_h(V0)/(alpha_h(V0)+beta_h(V0));
n0=alpha_n(V0)/(alpha_n(V0)+beta_n(V0));


tspan=[0,20]; %Time interval
X0=[V0, m0, h0, n0];%Initial condition

%% symbolic solution
syms V(t) m(t) h(t) n(t)
ode1=diff(V,t)==(1/C)*(-gNa*m^3*h*(V-ENa)-gK*n^4*(V-EK)-gEq*(V-EEq)+i);
ode2=diff(m,t)==0.1*((-40-V)/(exp((-40-V)/10)-1))*(1-m)-4*exp((-65-V)/18)*m;
ode3=diff(h,t)==0.07*exp((-65-V)/20)*(1-h)-1/(exp((-35-V)/10)+1)*h;
ode4=diff(n,t)==0.01*((-55-V)/(exp((-55-V)/10 )-1))*(1-n)-0.125*exp((-65-V)/80)*n;
S=dsolve(ode1,ode2,ode3,ode4,V(0)==V0, m(0)==m0, h(0)==h0, n(0)==n0);   
%% Euler explicit
h=0.3; %step size

[tEE,XEE]=eul_exp(@fun,tspan,X0,h);

plot(tEE,XEE(:,1))
    title('Numerical solution using Euler explicit')
    ylabel('Membrane potential [mV]')
    xlabel('Time [ms]')
%% Euler implicit
[tEI, XEI]=eul_imp(@fun,@jacf,tspan,X0,h);

figure
plot(tEI,XEI(:,1))
    title('Numerical solution using Euler implicit')
    ylabel('Membrane potential [mV]')
    xlabel('Time [ms]')
%% Heun's method
[tH, XH]=heun(@fun,tspan,X0,h);

figure
plot(tH,XH(:,1))
    title('Numerical solution using Heun')
    ylabel('Membrane potential [mV]')
    xlabel('Time [ms]')

%% ODE45 (Explicit Runge Kutta)adaptive step size
[t45,X45]=ode45(@fun,tspan,X0,odeset('reltol',1.e-10));

figure
plot(t45,X45(:,1))
    title('Numerical solution using ODE45')
    ylabel('Membrane potential [mV]')
    xlabel('Time [ms]')
figure
plot(t45,X45(:,2),t45,X45(:,3),t45,X45(:,4))
    title('Numerical solutions usign ODE45')
    xlabel('Time[ms]')
    ylabel('Gaiting Variables')
    legend('m (Sodium activation gate)','h (Sodium inactivation gate)','n (Potassium activation gate)')

%% Visualization of the results
figure
plot(tEE,XEE(:,1),tEI,XEI(:,1),tH,XH(:,1),t45,X45(:,1))
    title('Numerical solutions')
    ylabel('Membrane potential [mV]')
    xlabel('Time [ms]')
    legend('Euler explicit','Euler implicit','Heun','ODE45')

figure
plot(tEE,XEE(:,2),'b',tEE,XEE(:,3),'g',tEE,XEE(:,4),'m')
hold on
plot(tEI,XEI(:,2),'b',tEI,XEI(:,3),'g',tEI,XEI(:,4),'m')
plot(tH,XH(:,2),'b',tH,XH(:,3),'g',tH,XH(:,4),'m')
plot(t45,X45(:,2),'b',t45,X45(:,3),'g',t45,X45(:,4),'m')

    title('Gating variables for the HH model m,n,h')
    xlabel('Time[ms]')
    ylabel('Gating variables')
    legend('m Euler explicit','n Euler explicit','h Euler explicit','m Euler implicit','n Euler implicit','h Euler implicit','m Heun','n Heun','h Heun','m ODE45','n ODE45','h ODE45')

%% Quantitative comparison between the solutions
X_45=spline(t45,X45(:,1),tEE');

eEE=norm(X_45-XEE(:,1))/norm(X_45(:,1))

X_45=spline(t45,X45(:,1),tEI');
eEI=norm(X_45-XEI(:,1))/norm(X_45(:,1))

X_45=spline(t45,X45(:,1),tH');
eH=norm(X_45-XH(:,1))/norm(X_45(:,1))

%% Considering different step sizes h
h=[0.01 0.1 0.3 0.5];
n=length(h);
%initialization of the vectors that will contain the relative errors
eEE=zeros(n,1);
eEI=zeros(n,1);
eH=zeros(n,1);

for i=1:n
    tic
    [tEE,XEE]=eul_exp(@fun,tspan,X0,h(i));
    toc
    tic
    [tEI, XEI]=eul_imp(@fun,@jacf,tspan,X0,h(i));
    toc
    tic
    [tH, XH]=heun(@fun,tspan,X0,h(i));
    toc

    X_45=spline(t45,X45(:,1),tEE');
    eEE(i)=norm(X_45-XEE(:,1))/norm(X_45(:,1));

    X_45=spline(t45,X45(:,1),tEI');
    eEI(i)=norm(X_45-XEI(:,1))/norm(X_45(:,1));

    X_45=spline(t45,X45(:,1),tH');
    eH(i)=norm(X_45-XH(:,1))/norm(X_45(:,1));
end
figure
loglog(h,eEE,'.-')
hold on
loglog(h,eEI,'.-')
loglog(h,eH,'.-')
loglog(h,h)
loglog(h,h.^2)
    legend('Euler explicit','Euler implicit','Heun','reference s=1','reference s=2')
    xlabel('step size h')
    ylabel('relative error')
