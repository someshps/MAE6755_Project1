
<img width="200" height="200" alt="one35" src="https://github.com/user-attachments/assets/6752d648-af41-45ef-9727-81f6ee96d869" />


# Study the effect of various fault orientations for a tunnel

This repository contains the work done for a course project in the course MAE6755 Finite Element Method: Theory and Applications in Mechanics and Multiphysics (Cornell University, Spring 2025). The project aims to study Cavity failure in homogeneous and fractured media. The simulations were performed using [MOOSE](https://mooseframework.inl.gov/), and the primary objective was to determine conditions under which the rock yields in **tension or shear**. The geometry files were prepared and meshed using the tool gmsh (https://gmsh.info). 

## Given Information 

- **Tunnel Geometry**: Circular tunnel of diameter 10 m (radius `a = 5 m`)
- **Depth**: 100 m
- **Stress state**: Biaxial state of stress defined by vertical stress `p` and horizontal stress `K*p`
- **Rock Density**: 2500 kg/m³
- **Analysis Goal**: Evaluate stress distribution and determine tensile or shear failure zones

---

## Problem was handled in steps which are as follows. 

### Step 1: Base Case — Tunnel Without a Fault

- **Objective**: Verify stress distribution around a circular cavity without any fault (1a).
- **Tasks**:
  - Simulate for multiple values of lateral stress coefficient `K` (1a).
  - Validate FEM results with **Kirsch equations** for stress around circular openings (1a).
  - Research literature for three rock types and extract (1b):
    - Specific weight
    - Young’s modulus
    - Poisson’s ratio
    - Tensile strength
    - Shear strength
  - Analyze whether tensile or shear yield stress is exceeded for each rock (1b).

### Step 2: One Vertical Fault

- **Objective**: Investigate effect of a vertical fault intersecting the tunnel.
- **Approach**:
  - Choose one rock type from Step 1.
  - Introduce a **vertical fault plane** passing through the tunnel centroid.
  - Model fault as:
    - Hard normal contact (non-penetrability)
    - Frictional tangential contact (same friction as in MOOSE contact tutorial)
  - Simulate for varying values of `p` and `K`.
  - Check conditions where tensile or shear failure occurs.

### Step 3: Effect of Fault Orientation

- **Objective**: Assess how fault orientation affects tunnel stability.
- **Method**:
  - Repeat simulations from Step 2 for different fault angles (e.g., 0°, 45°, 90°, 135°).
  - Discuss which configurations pose the **greatest risk** in terms of tensile or shear yielding.

---

## What does the repository contain?

- Moose input files, Geometry files, Mesh files for simulating each case.
- Plots for evolution of stress state as one moves along the radial direction. 
- Data sampled along the radial direction this includes, vonmises_stress stress_xx stress_xy stress_yy stress_zz strain_xx strain_xy strain_yy strain_zz
- A report for the analysis

---

## References

    -https://www.engineeringtoolbox.com/young-modulus-d_417.html
    -Study on the rock physical mechanical properties evaluation of tight oil reservoir in Chang 7 member, Longdong area, Ordos Basin, China.
    -https://www.engineeringtoolbox.com/poissons-ratio-d_1224.html}
    -Hampton, J., Frash, L., Matzar, L., \& Gutierrez, M. (2018). Extended-term monitoring of acoustic emissions post-laboratory hydraulic fracturing. ARMA US Rock Mechanics Symposium.
    -MOOSE-tuto-4-project1c.pdf (Canvas Tutorial from the course)
    -MOOSE-tuto-1.pdf (Canvas Tutorial from the course)
    -MOOSE-tuto-2-project1a.pdf (Canvas Tutorial from the course)

---

## How to Navigate this directory?

-The master directory contains four folders one for each step mentioned in the problem above. 

-step1a folder subfolders for figures, data and codes. 

-step1b folder has same three subfolders for data, figures and codes. Codes for all the three rock types are present in the same folder 1bcodes but the figures and data are further in the folders names after the rock type. 

-step2 folder contains a subfolder for all the codes and folder corresponding to each value of k for which the simulation was run and then this further inside has a folder for each value of depth which contains all the data and figures related to that simulation. 

-same structure is followed for the step3 folder with one35 denotes fault at 135 degree orientation fortyf denotes the folder for 45 degree orientation, hfault contains the data for horizontal fault. 
















