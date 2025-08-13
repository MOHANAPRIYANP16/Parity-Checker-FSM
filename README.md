# 🌀 parity_checker_fsm

## 📌 Overview
This project implements a **Serial Parity Checker** using a **Finite State Machine (FSM)** in Verilog.  
It checks whether the number of `1`s in the received serial data stream is **even** or **odd** and outputs a parity status accordingly.  
The design supports both **even** and **odd** parity modes and validates the parity bit at the end of the sequence.

---

## 📜 Problem Statement
Design a serial **Parity Checker FSM** which:
- Checks if the number of 1's in the data stream is even or odd.
- Outputs **1** if the parity matches the expected mode, **0** otherwise.
- Supports **configurable parity modes**:
  - `mode = 0` → Even parity
  - `mode = 1` → Odd parity
- Validates parity bit at the end of the stream.

---

## ✨ Features
- FSM-based sequential parity detection.
- Supports both even and odd parity modes.
- Works on serial input data streams.
- Designed in Verilog HDL.
- Includes simulation testbench.
- FPGA synthesis-ready.

---

## 🛠 Tools & Hardware
- **HDL Language:** Verilog
- **Simulation Tool:** ModelSim / Vivado Simulator
- **Synthesis Tool:** Xilinx Vivado
- **FPGA Board:** Zynq-7000 (or equivalent)
- **Environment:** Linux/Windows

---

## 🔌 Inputs & Outputs
| Signal Name  | Direction | Description                              |
|--------------|-----------|------------------------------------------|
| `clk`        | Input     | System clock signal                      |
| `reset`      | Input     | Active-high reset                        |
| `data_in`    | Input     | Serial data input bit                    |
| `valid`      | Input     | High when input data is valid             |
| `mode`       | Input     | Parity mode (0 → Even, 1 → Odd)           |
| `parity_ok`  | Output    | High if parity matches expected mode      |
| `counter`    | Output    | 4-bit counter for tracking input length   |

---

## 🔄 FSM States
1. **EVEN_STATE** – Current number of 1's is even.
2. **ODD_STATE** – Current number of 1's is odd.

---

## 📊 FSM State Diagram
![FSM Diagram](images/fsm_diagram.png)

---

## 📂 design.v
<pre>
module parity (
    input clk,
    input reset,
    input data_in,     
    input valid,       
    input mode,        
    output reg parity_ok,
    output reg [3:0] counter
);
    reg curr_state;
    reg next_state;

    parameter EVEN_STATE = 1'b0;
    parameter ODD_STATE  = 1'b1;

    always @(*) begin
        next_state = curr_state;
        if (valid) begin
            if (data_in) begin 
                case (curr_state)
                    EVEN_STATE: next_state = ODD_STATE;
                    ODD_STATE:  next_state = EVEN_STATE;
                endcase
            end else begin
                next_state = curr_state;
            end
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            curr_state <= EVEN_STATE;
            counter <= 4'd0;
            parity_ok <= 1'b0;
        end else begin
            if (valid) begin
                curr_state <= next_state;
                if (counter < 4'd8)
                    counter <= counter + 1;
                if (counter == 4'd8) begin 
                    counter <= 4'd0;
                    case(curr_state)
                        EVEN_STATE: parity_ok <= (mode == 1'b0) ? 1'b1 : 1'b0;
                        ODD_STATE:  parity_ok <= (mode == 1'b1) ? 1'b1 : 1'b0;
                    endcase
                end
            end else begin
                parity_ok <= 1'b0;
                counter <= 4'd0;
            end
        end
    end
endmodule

## 📂 testbench.v

```verilog
module parity_checker_tb;
    reg clk;
    reg rst;
    reg in_bit;
    wire parity;

    parity_checker uut (
        .clk(clk),
        .rst(rst),
        .in_bit(in_bit),
        .parity(parity)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1; in_bit = 0;
        #10 rst = 0;

        #10 in_bit = 1;
        #10 in_bit = 0;
        #10 in_bit = 1;
        #10 in_bit = 1;
        #10 in_bit = 0;
        #10 $stop;
    end
endmodule
                </pre>

