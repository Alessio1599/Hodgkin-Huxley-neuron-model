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

![Action Potential](path_to_figure_2_image)

## Description of the Mathematical Model

The model consists of four first-order ordinary differential equations (ODEs) for the state variables V, m, h, and n, and six algebraic equations for the rates of channel gating.

### Differential Equations

1. Membrane potential variation (Equation 1)
2. Sodium activation gate kinetics (Equation 2)
3. Sodium inactivation gate kinetics (Equation 3)
4. Potassium activation gate kinetics (Equation 4)

Parameters used in the model:
- \( g_{Na\_max} = 120 \)
- \( g_{k\_max} = 36 \)
- \( g_{eq} = 0.3 \)
- \( C = 4 \)
- \( E_{Na} = 55 \)
- \( E_k = -77 \)
- \( E_{eq} = -54.4 \)

Initial conditions:
- \( V_0 = -65 \) mV
- Initial gating variables (m, n, h) set to maintain equilibrium in the absence of current.

## Numerical Experimentation

Three numerical methods were used to solve the Hodgkin-Huxley model: Euler Explicit, Euler Implicit, and Heun’s method. The solution computed using MATLAB's ODE45 function (with a relative error tolerance of \( 10^{-10} \)) served as the exact solution.

### Stability Analysis

Experiments were conducted with step sizes \( h = 0.01, 0.1, 0.3, \) and \( 0.5 \). Stability and accuracy of each method were analyzed:

1. **Euler Explicit:** Stable for \( h = 0.01 \) and \( 0.1 \). Unstable for \( h = 0.3 \) and \( 0.5 \).
2. **Euler Implicit:** Stable but less accurate for larger step sizes.
3. **Heun's Method:** Stable for smaller step sizes but unstable for \( h = 0.5 \).

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
