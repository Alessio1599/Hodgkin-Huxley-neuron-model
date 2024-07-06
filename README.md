# Hodgkin-Huxley Neuron Model

The Hodgkin-Huxley (H.H.) studies of the action potential, published 60 years ago, are a central pillar of modern neuroscience research, ranging from molecular investigations of the structural basis of ion channel function to the computational implications at the circuit level. The H.H. model is based on the observation that the electrical activity of neurons can be explained by the flow of ions across the nerve cell membrane.

## Table of Contents

<ul>
<li><a href="#project-introduction">Project Introduction</a></li>
<li><a href="#description-of-the-mathematical-model">Description of the Mathematical Model</a></li>
<li><a href="#numerical-experimentation">Numerical Experimentation</a></li>
<li><a href="#references">References</a></li>
</ul>

## Project Introduction

The Hodgkin-Huxley (H.H.) model describes the electrical characteristics of excitable cells such as neurons. The model is based on the implementation of an electrical analogue of the cell membrane. It explains the excitation waveform, called action potential, which results from a current pulse of sufficient amplitude.

### Action Potential Characteristics

1. **Presence of a Threshold:** An action potential is produced only if the membrane potential exceeds a certain value (typically around -55 mV).
2. **Stereotyped Form:** The action potential is "all or nothing," meaning once the threshold is exceeded, the shape of the action potential is consistent, regardless of stimulus strength.


## Description of the Mathematical Model

The model consists of four non linear first-order ordinary differential equations (ODEs) for the state variables $V$, $m$, $h$, and $n$, and six algebraic equations for the rates of channel gating.

### Differential Equations

$$
C \frac{dV}{dt} + g_{Na\_max} m^3 h (V - E_{Na}) + g_{k\_max} n^4 (V - E_k) + g_{eq} (V - E_{eq}) = i \quad (1)
$$

$$
\frac{dm}{dt} = \alpha_m (V) (1 - m) - \beta_m (V) m \quad (2)
$$

$$
\frac{dh}{dt} = \alpha_h (V) (1 - h) - \beta_h (V) h \quad (3)
$$

$$
\frac{dn}{dt} = \alpha_n (V) (1 - n) - \beta_n (V) n \quad (4)
$$

### Auxiliary Variables

The auxiliary variables $\alpha_m(V)$, $\beta_m(V)$, $\alpha_h(V)$, $\beta_h(V)$, $\alpha_n(V)$, and $\beta_n(V)$ are given by the following expressions:

$$
\alpha_m(V) = \frac{0.1 \left( -40 - V \right)}{\exp\left(\frac{-40 - V}{10}\right) - 1}
$$

$$
\beta_m(V) = 4 \exp\left(\frac{-65 - V}{18}\right)
$$

$$
\alpha_h(V) = 0.07 \exp\left(\frac{-65 - V}{20}\right)
$$

$$
\beta_h(V) = \frac{1}{\exp\left(\frac{-35 - V}{10}\right) + 1}
$$

$$
\alpha_n(V) = \frac{0.01 \left( -55 - V \right)}{\exp\left(\frac{-55 - V}{10}\right) - 1}
$$

$$
\beta_n(V) = 0.125 \exp\left(\frac{-65 - V}{80}\right)
$$


### Parameters
In this work, the solution was obtained by imposing a current value of i=6 with the aim to visualize the genesis of a single spike of the action potential. The parameter used were taken from the literature and are:
- $g_{Na\_max} = 120$
- $g_{k\_max} = 36$
- $g_{eq} = 0.3$
- $C = 4$
- $E_{Na} = 55$
- $E_k = -77$
- $E_{eq} = -54.4$

### Initial Conditions

- $V_{0} = -65$ mV
- $m_{0} = 0.05$
- $n_{0} = 0.2$
- $h_{0} = 0.6$

## Numerical Experimentation

Three numerical methods were used to solve the Hodgkin-Huxley model: Euler Explicit, Euler Implicit, and Heun’s method. The solution computed using MATLAB's ODE45 function (with a relative error tolerance of $10^{-10}$) served as the exact solution.

### Stability Analysis

Experiments were conducted with step sizes $h = 0.01, 0.1, 0.3,$ and $0.5$. Stability and accuracy of each method were analyzed:

1. **Euler Explicit:** Stable for $h = 0.01$ and $0.1$. Unstable for $h = 0.3$ and $0.5$.
2. **Euler Implicit:** Stable but less accurate for larger step sizes.
3. **Heun's Method:** Stable for smaller step sizes but unstable for $h = 0.5$.

### Order of Accuracy

Relative error analysis was performed for each method across different step sizes, plotted on a log scale. Results indicated:
- Euler Explicit and Implicit methods have first-order accuracy.
- Heun's method has second-order accuracy and is the most accurate among the methods considered.

### Computational Complexity

Computation times (in seconds) for each method are presented in Table 1 for various step sizes:

| Step size (h) | Computational Time (EE) | Computational Time (EI) | Computational Time (Heun) |
|---------------|--------------------------|--------------------------|---------------------------|
| 0.0001        | 19.096537                | 24.005285                | 23.143380                 |
| 0.001         | 0.429878                 | 2.065663                 | 0.699382                  |
| 0.01          | 0.033762                 | 0.241290                 | 0.066874                  |
| 0.1           | 0.009908                 | 0.041240                 | 0.010251                  |

### Summary

- **Euler Explicit:** Simple, least computational cost, first-order accuracy, conditionally stable.
- **Euler Implicit:** Unconditionally stable, first-order accuracy, highest computational complexity.
- **Heun's Method:** Second-order accuracy, conditionally stable, higher computational cost than Euler Explicit.

## References

1. Hodgkin, A. L., & Huxley, A. F. (1952). A quantitative description of membrane current and its application to conduction and excitation in nerve. _The Journal of Physiology_.
