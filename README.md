# Computational Modeling of Cerebellar Granule Neurons

## Project Overview
This repository contains a computational framework for simulating the electrophysiological behavior of cerebellar granule cells. Using the **Adaptive Exponential Integrate-and-Fire (AdEx)** model, the project focuses on capturing the characteristic firing patterns of these neurons within a high-performance simulation environment.

## Model Architecture
The simulation is implemented using the **NEURON Simulation Environment** and utilizes the following components:
* **Template-Based Design**: A modular `pcadex` template structure for efficient cell initialization and management.
* **AdEx Dynamics**: Implementation of a point-process model (`PROADEX`) to simulate membrane potential dynamics and adaptive spiking behaviors.
* **Stimulus & Recording**: Integrated routines for applying current clamps (e.g., specific amplitudes and durations) and recording high-resolution voltage traces for further analysis.

## Technical Implementation
* **HOC Scripting**: Custom logic developed in HOC to automate cell creation, define biophysical properties, and manage simulation control flows.
* **Variable Time-Step Integration**: Use of the `CVode` solver within NEURON to ensure numerical stability and computational efficiency during simulations.
* **Data Output**: Automated generation of voltage data (CSV format) for comparative analysis with experimental results.

## Requirements
* **NEURON Simulation Environment** (7.x or higher)
* Standard C/C++ compiler for compiling NMODL (`.mod`) files associated with the AdEx model.

## Usage
1. Compile any required `.mod` files using `nrnivmodl`.
2. Execute the main simulation script:
   ```bash
   nrngui createcells_new_granule.hoc

*Note: Specific physiological parameters and experimental configurations have been abstracted to adhere to institutional collaboration agreements.*
