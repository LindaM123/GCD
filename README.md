# 🧮 GCD Hardware Design Project

This project implements a **hardware module to compute the Greatest Common Divisor (GCD)** of two numbers using **SystemVerilog**.  
Unlike the Euclidean algorithm with modulo, this design uses **a subtraction-based algorithm**, which is often more straightforward to implement in hardware.

## 📂 Project Structure

```
GCD-main/
│── Makefile              # Automates compilation and simulation
│── gcd.svh               # Common header file
│── gcd_dp.sv             # Datapath module
│── gcd_fsm.sv            # FSM control module
│── gcd_top.sv            # Top-level integration module
│── my_design_gcd1.sv     # Alternative design version
│── test_gcd.py           # Python testbench
│── test_gcd2.py
│── test_gcd_dp.py
│── test_gcd_fsm.py
│── test_gcd_top.py
│── test_gcd_top_dos.py
```

## 🧠 Design Overview

- **`gcd_dp.sv`** — Implements the datapath for the subtraction-based GCD algorithm.  
- **`gcd_fsm.sv`** — Controls the datapath using a state machine that manages loading, comparing, and subtracting values.  
- **`gcd_top.sv`** — Integrates the FSM and datapath into a single top-level module.  
- **`my_design_gcd1.sv`** — An alternate design version.  
- **`gcd.svh`** — Common definitions and parameters.

🧪 The Python scripts (e.g., `test_gcd_top.py`) are used to **simulate and verify** the design using tools like Cocotb.

## ⚙️ Requirements

- Verilog/SystemVerilog simulator (e.g., Icarus Verilog, Verilator)
- Python 3.x
- [Optional] Cocotb for testbench simulation
- Make (for using the Makefile)

Install Python dependencies if needed:

```bash
pip install cocotb
```

## 🧮 Subtraction-Based GCD Algorithm

This design uses the following algorithm:

```
while (a != b):
    if (a > b):
        a = a - b
    else:
        b = b - a
return a
```

👉 This method **avoids division** and **only uses comparison and subtraction**, which are easier to implement efficiently in hardware.

## 🧭 Architecture

- **Datapath:** Holds two registers (A and B), a comparator, and a subtractor.  
- **FSM Controller:** Directs whether to subtract A–B or B–A, checks for equality, and signals when the GCD is ready.  
- **Top Module:** Connects both components and defines the I/O interface (e.g., start signal, done signal, result).

## 🧪 Running the Tests

To compile and simulate:

```bash
make
```

Or run a specific Python testbench:

```bash
python3 test_gcd_top.py
```

You can also run other test files such as:

```bash
python3 test_gcd_fsm.py
python3 test_gcd_dp.py
```

## 📊 Module Responsibilities

| Module               | Description                                                  |
|-----------------------|--------------------------------------------------------------|
| `gcd_dp.sv`           | Datapath: registers, comparator, subtractor                   |
| `gcd_fsm.sv`          | FSM: controls subtraction sequence and detects when `a == b`  |
| `gcd_top.sv`          | Top-level integration module                                 |
| `test_gcd_*.py`       | Python testbenches for simulation and verification            |

## 🧰 Makefile Usage

```bash
make run        # Compile and run simulation
make clean      # Remove generated files
```

## 📝 Author

Project developed as part of a **digital design and verification** learning project using subtraction-based GCD computation in hardware.
