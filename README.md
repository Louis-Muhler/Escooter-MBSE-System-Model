# Escooter MBSE System Model

This repository contains the complete Model-Based Systems Engineering (MBSE) artifacts for a modern urban e-scooter. The project demonstrates a continuous systems engineering workflow from stakeholder needs to executable simulation models, developed as a cyber-physical system.

Note: This project was developed as part of a Systems Engineering curriculum at DHBW.

## System Scope & Objectives
The system model defines an e-scooter designed for urban mobility, focusing on:
* Performance & Safety: Compliance with urban speed limits, stable handling, and reliable braking.
* Energy Management: Efficient electrical powertrain with sufficient range for daily urban commuting.
* Usability & Security: Intuitive HMI (Display), anti-theft mechanisms, and IoT connectivity (App integration).

## Project Architecture & Artifacts
The repository is structured along a standard Systems Engineering V-Model approach, utilizing the MathWorks ecosystem:

1. Requirements Engineering: Functional, Non-Functional, and Safety/Security requirements. Traceability established between stakeholder needs and system components.
2. System Architecture (System Composer):
   * Functional Architecture: Use Cases and functional flows.
   * Logical Architecture: Subsystem decomposition.
   * Physical Architecture: Component allocation (Battery, Motor, ECU).
   * Interface Control Documents (ICDs): Definition of energy, data, and physical interfaces.
3. System Design (Simulink):
   * Executable models for core functions (e.g., state management, cruise control, SOC calculation).
4. Verification & Validation (V&V):
   * Defined test cases linked to system requirements to ensure design compliance.

## Tech Stack
* MATLAB & Simulink (Base Platform & Simulation)
* System Composer (Architecture Modeling)
* Requirements Toolbox (Requirements Management & Traceability)

## Development Team
* Victoria Einike
* Louis Muhler
* Jonas Münz
* Tim Schäfer
