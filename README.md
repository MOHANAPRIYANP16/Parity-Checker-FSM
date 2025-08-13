# Parity-Checker-FSM

# 🎯 parity_checker_fsm

## 📌 Overview
This project implements a **Parity Checker** using a **Finite State Machine (FSM)** in Verilog.  
The system checks whether the number of `1`s in the input data stream is **even** or **odd** and outputs the corresponding parity status.

---

## 📝 Problem Statement
A **parity checker** verifies data integrity by determining if the number of 1s in a binary sequence is even or odd.  
This project uses an **FSM approach** instead of a simple combinational XOR logic, making it suitable for **sequential data streams** in digital systems.

---

## ✨ Features
- Implements **Even** and **Odd** parity detection
- Designed using FSM principles
- Supports simulation and FPGA synthesis
- Includes timing, power, and schematic reports
- Fully tested using a Verilog testbench
- Demonstration video included

---

## 🛠 Tools & Hardware
- **HDL Language:** Verilog
- **Simulation Tool:** ModelSim / Vivado Simulator
- **Synthesis Tool:** Xilinx Vivado
- **FPGA Board:** [Specify your board model, e.g., Zynq-7000]
- **Additional:** Linux/Windows environment

---

## 🔌 Inputs & Outputs
| Signal Name | Direction | Description |
|-------------|-----------|-------------|
| `clk`       | Input     | System clock |
| `reset`     | Input     | Active-high reset signal |
| `data_in`   | Input     | Serial data input bit |
| `parity`    | Output    | Parity status (0 = Even, 1 = Odd) |

---

## 🔄 FSM States
1. **EVEN_STATE** – Current number of 1's is even
2. **ODD_STATE** – Current number of 1's is odd

---

## 📊 FSM State Diagram
![FSM Diagram](images/fsm_diagram.png)

---


## 📂 design.v


## 📂 testbench.v






