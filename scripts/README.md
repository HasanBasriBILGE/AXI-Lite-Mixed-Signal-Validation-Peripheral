# 🚀 AXI-Lite Multi-Functional Peripheral

This repository provides a **TCL-based automation script** to quickly create and configure a **Xilinx Vivado project** for **Zynq-7000** based designs.

It is intended as a clean starting point for developing **AXI-Lite based custom peripherals** using **Verilog**.

---

## 🧩 What This Script Does

The `create_project.tcl` script automatically:

- Creates a new Vivado project  
- Sets the FPGA part and board (**Digilent Eclypse Z7**)  
- Configures the target language (**Verilog**)  
- Adds HDL source files from `src/`  
- Adds testbench files from `tb/`  
- Adds constraint files from `constraints/`  
- Updates compile order  

This allows you to start working immediately without manual project setup.

---

## 📁 Project Structure

```text
AXI-Lite-MultiFunctionalPeripheral/
├── scripts/
│   └── create_project.tcl
├── src/            # HDL source files
├── tb/             # Simulation files
├── constraints/    # XDC constraint files
└── README.md
```
---

▶️ How to Run

 1- Open Vivado

 2- Open the TCL Console

 3- Run the script:
```
source scripts/create_project.tcl
```

(Optional) Override the project name:

```
set user_project_name MyCustomProject
source scripts/create_project.tcl
```
---

+ Platform Note

If you plan to use a different FPGA board or platform, the board-related parameters in the .tcl script must be updated.

Recommended workflow:

	+ Create a donor Vivado project for the target board

	+ Copy the part and board_part values from that project

	+ Update the corresponding fields in create_project.tcl

This ensures correct board configuration and prevents synthesis or implementation issues.

---
✅ After Running

Once the script finishes successfully, the project will be ready in Vivado.
---
## 🧩 What This Script Does

The `update_project.tcl` script automatically synchronize all files for Vivado. 

▶ How to Run

 1- Open Vivado
 2- Tools/Run TCL script
 3- Select `update_project.tcl` script after changes.

Next steps after adding new file:

	+ Add HDL files to src/

	+ Add testbench files to tb/

	+ Add constraint files to constraints/

	+ Run TCL script &  run synthesis and implementation
