# Binary-Coded-Decimal-Adder
As my first hands-on FPGA project, I designed and tested a BCD Adder on the DE10-Lite board using Intel Quartus Prime. I configured the MAX10 FPGA via System Builder. This was part of the FPGA Capstone course by CU Boulder, taught by Prof. Timothy Scherr grateful for his guidance.


# FPGA Capstone Project – Module I  
## Altera MAX10 Hardware Setup and BCD Adder Design  
**Author:** Abhijit Rai  
**Institution:** Army Institute of Technology, Pune  
**Program:** University of Colorado Boulder – FPGA Specialization (Course 4: Capstone Project – Module I)  
**Date:** Aug 2024

---

## Project Overview

As part of the first module of the FPGA Capstone course, I designed and implemented a Binary Coded Decimal (BCD) Adder using the **Altera MAX10 FPGA** on the **DE10-Lite development board**. The focus was on hands-on embedded design flow, including hardware setup, system configuration, and logic implementation via the **Intel Quartus Prime toolchain**.

The project was completed under the guidance of the University of Colorado Boulder’s Coursera specialization. All development strictly followed the Capstone Project guidelines provided in Module I.

---

## Learning Outcomes

- Developed proficiency in **Quartus Prime Lite Edition 16.1** for synthesis and programming.
- Gained understanding of **SoC architecture** and embedded logic design.
- Built hardware systems using **System Builder** and **schematic/HDL-based design flows**.
- Connected and controlled on-board peripherals (switches, LEDs, 7-segment displays, SDRAM).
- Analyzed RTL output, timing constraints, and design resources.
- Designed a functional **BCD Adder** and validated its output on physical hardware.
- Maintained a complete lab notebook with results and technical analysis.

---

## Hardware and Software Stack

- **FPGA Device:** Altera MAX10 (55nm embedded flash)
- **Board:** DE10-Lite Development Kit by Terasic Technologies
- **Software Tools:**  
  - Intel Quartus Prime v16.1 Lite Edition  
  - DE10-Lite System Builder (from SystemCD v2.0.0)  
  - USB Blaster (for board programming)

---

## Implementation Summary

### 1. Development Environment Setup
- Installed and configured Quartus Prime 16.1 (Lite).
- Reviewed DE10-Lite documentation and system specifications.
- Created organized project folders for multiple configurations.
- Logged all observations, errors, and test results in a structured lab notebook.

---

### 2. System Builder Configurations

#### `DE10_LITE_Default`
- Enabled all peripherals (VGA, LEDs, 7-segment, switches, accelerometer, SDRAM).
- Compiled successfully and verified board behavior via programmed `.sof`.

#### `DE10_LITE_Small`
- Created a minimal config disabling unused peripherals.
- Debugged synthesis warnings and timing errors.
- Logged Fmax, logic utilization, and flip-flop count from the compiler report.

---

### 3. BCD Adder – Combinational Logic Design

- Designed a **BCD Adder** in Verilog to convert binary input (`SW7–0`) to a decimal value.
- Mapped outputs to 7-segment displays (`HEX0` and `HEX1`).
- Verified logic through simulation and real-time board output.

---

## Deliverables

- Quartus Project Files (Zipped):  
  - `DE10_LITE_Default`  
  - `DE10_LITE_Small`
- Lab Notebook (PDF):  
  - Configuration logs, Quartus output screenshots, timing analysis, and final test results.
- Final `.sof` files for programming the board.

---

## Evaluation Criteria

- Board setup and functional synthesis using Quartus.
- Proper implementation of timing constraints and resource reports.
- Correct display output and logic behavior of the BCD adder.
- Quality and completeness of documentation.
- Ability to debug, optimize, and report findings clearly.

---

## References

- University of Colorado Boulder, **FPGA Specialization (Coursera) – Capstone Project Materials**
- **Intel® Quartus® Prime Lite Edition Documentation**
- **Terasic DE10-Lite SystemCD** and hardware resources
- DE10-Lite User Manual, Chapters 1, 3, and 4

---

## Acknowledgements

This project was completed as part of the **“FPGA Capstone: Building FPGA Projects”** course offered by the **University of Colorado Boulder** on **Coursera**, led by **Professor Timothy Scherr**. I'm grateful for the clear instruction and real-world design experience provided through this curriculum.

All tools used are the property of their respective owners:
- **Intel Corporation** – FPGA architecture, Quartus Prime software, and programming tools.
- **Terasic Technologies** – DE10-Lite FPGA development platform.
- Project files respect the licensing and redistribution conditions outlined in the [Intel EULA](https://fpgasoftware.intel.com/eula).

This README and all shared content strictly follow educational fair use and course integrity guidelines. No proprietary IP, encrypted cores, or restricted binaries are redistributed.

---
> **Note:** This repository was originally developed under my other GitHub account, [abhijitrai1619](https://github.com/abhijitrai1619/Smart-Glasses-for-Visually-Impaired).  
> It has been forked and maintained here under [aerostorm19](https://github.com/aerostorm19), also my account, purely for organizational and safety purposes.

