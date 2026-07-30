# digital-design-projects

A collection of digital system design projects implemented in VHDL and Verilog,
developed as part of the Digital System Design course.

Projects cover combinational and sequential logic design, finite state machines,
memory-mapped interfaces, and hardware arithmetic implementations,
targeting Xilinx FPGA boards.

---

## Repository Structure

digital-design-projects/
│
├── verilog/
│   └── arctanhip-cordic/
│       └── TB.v
│
└── vhdl/
    ├── keypad-seven-segment/
    │   └── key.vhd
    │
    ├── lcd-keypad-interface/
    │   └── LCD_show.vhd
    │
    └── traffic-light-controller/
        └── tlc.vhd

---

## Projects

---

### 1. ArcTan via CORDIC — Verilog Testbench

A Verilog testbench for verifying the ArcTanHip module, which computes
the arctangent of a vector using the CORDIC algorithm.

The testbench applies a sequence of (x, y) input vectors with 16-bit
fixed-point representation and monitors the phase output produced by the
CORDIC pipeline.

**Module:** ArcTanHip
**Language:** Verilog
**Interface:**

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| x_in | Input | 16-bit | X component of input vector |
| y_in | Input | 16-bit | Y component of input vector |
| nd | Input | 1-bit | New data strobe |
| clk | Input | 1-bit | Clock |
| sclr | Input | 1-bit | Synchronous clear |
| x_out | Output | 16-bit | X component after CORDIC rotation |
| y_out | Output | 16-bit | Y component after CORDIC rotation |
| phase_out | Output | 16-bit | Computed arctangent (phase angle) |
| rdy | Output | 1-bit | Output ready flag |
| rfd | Output | 1-bit | Ready for data flag |

**Key concepts:** CORDIC algorithm, fixed-point arithmetic,
pipeline verification, Verilog testbench structure

[View Code](./verilog/arctanhip-cordic/TB.v)

---

### 2. 4x4 Keypad Scanner with Seven Segment Display — VHDL

A complete hardware interface for a 4x4 matrix keypad with real-time
display of the pressed key on a seven-segment display.

The design uses a column-scanning technique driven by a clock divider.
Row outputs are cycled through all four columns at a rate derived from
the system clock, and the active column is read back through the row
inputs to determine which key was pressed.

**Module:** key
**Language:** VHDL
**Target:** Xilinx FPGA

**Interface:**

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| clk | Input | 1-bit | System clock |
| col | Input | 4-bit | Column input from keypad |
| row | Output | 4-bit | Row scan output to keypad |
| seg | Output | 7-bit | Seven-segment display output |

**Scanning rate:** Every 50,000 clock cycles per row

**Seven-segment encoding (active high):**

| Key | Display | Segment Pattern |
|-----|---------|-----------------|
| 0 | 0 | 1111110 |
| 1 | 1 | 0110000 |
| 2 | 2 | 1101101 |
| 3 | 3 | 1111001 |
| 4 | 4 | 0110011 |
| 5 | 5 | 1011011 |
| 6 | 6 | 1011111 |
| 7 | 7 | 1110000 |
| 8 | 8 | 1111111 |
| 9 | 9 | 1111011 |
| 10 | A | 1110111 |
| 11 | b | 0011111 |
| 12 | C | 1001110 |
| 13 | d | 0111101 |
| 14 | E | 1001111 |
| 15 | F | 1000111 |

**Key concepts:** Matrix keypad scanning, clock divider,
sequential logic, seven-segment encoding, VHDL process blocks

[View Code](./vhdl/keypad-seven-segment/key.vhd)

---

### 3. LCD Interface with Keypad Input — VHDL

A system-level design that integrates a 4x4 matrix keypad scanner
with a 4-bit mode LCD controller, displaying the pressed key value
on an LCD screen in real time.

The design includes a clock frequency divider, a 4-bit LCD data
interface, keypad scanning logic, and character mapping from key
values to ASCII display strings.

**Module:** LCD_show
**Language:** VHDL
**Target:** Xilinx FPGA

**Interface:**

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| clk_20m_in | Input | 1-bit | 20 MHz system clock |
| lcd_reset | Input | 1-bit | LCD reset signal |
| lcd_d | Output | 4-bit | LCD data bus (4-bit mode) |
| lcd_rs | Output | 1-bit | LCD register select |
| lcd_rw | Output | 1-bit | LCD read/write |
| lcd_e | Output | 1-bit | LCD enable |
| col | Input | 4-bit | Keypad column input |
| row | Output | 4-bit | Keypad row scan output |

**Components used:**
- `generic_freq_div` — clock divider generating 400Hz signal
- `lcd1` — LCD controller module

**Key concepts:** LCD 4-bit interface, clock divider,
component instantiation, keypad integration, ASCII mapping

[View Code](./vhdl/lcd-keypad-interface/LCD_show.vhd)

---

### 4. Traffic Light Controller — VHDL Finite State Machine

A two-intersection traffic light controller implemented as a
Moore Finite State Machine (FSM) in VHDL, with a built-in
clock divider scaling a 20 MHz input clock down to approximately
1 Hz for human-observable timing.

The design supports a standby mode and a test mode for
accelerated simulation and verification.

**Module:** tlc
**Language:** VHDL
**Target:** Xilinx FPGA

**Interface:**

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| clk | Input | 1-bit | 20 MHz system clock |
| stby | Input | 1-bit | Standby / reset signal |
| test | Input | 1-bit | Test mode (accelerated timing) |
| r1, r2 | Output | 1-bit | Red lights for intersections 1 and 2 |
| y1, y2 | Output | 1-bit | Yellow lights for intersections 1 and 2 |
| g1, g2 | Output | 1-bit | Green lights for intersections 1 and 2 |

**State machine:**

| State | Road 1 | Road 2 | Duration (normal) |
|-------|--------|--------|-------------------|
| RG | Red | Green | 36 cycles |
| RY | Red | Yellow | 6 cycles |
| GR | Green | Red | 54 cycles |
| YR | Yellow | Red | 6 cycles |
| YY | Yellow | Yellow | Standby state |

**Key concepts:** Moore FSM, clock divider, state encoding,
synchronous reset, test mode, VHDL type declaration

[View Code](./vhdl/traffic-light-controller/tlc.vhd)

---

## Tools and Environment

| Category | Details |
|----------|---------|
| Languages | VHDL, Verilog |
| EDA Tools | Xilinx ISE, Xilinx Vivado |
| Simulation | ISim, ModelSim |
| Target Platform | Xilinx FPGA |
| HDL Standard | VHDL-93, Verilog-2001 |

---

## How to Use

The source files are plain text and can be opened with any text editor.
For simulation and synthesis:

1. Open Xilinx ISE or Vivado
2. Create a new project
3. Add the relevant source files
4. Set the top-level module
5. Run behavioral simulation or synthesize for your target device

For viewing and editing source files without EDA tools,
any text editor works. Recommended options:

- Visual Studio Code with VHDL/Verilog extensions
- Notepad++

---

## Notes

- All designs target Xilinx FPGA boards.
- The LCD project depends on external components
  (generic_freq_div, lcd1, asci_types) which were provided
  as part of the course framework.
- The ArcTanHip module used in the Verilog testbench
  was generated using the Xilinx CORE Generator (CORDIC IP core).

---

## Author

**Maryam Liaghat**
Student ID: 40130112107
Faculty of Electrical Engineering
Course: Digital System Design
Instructor: (Instructor name)

---

## License

This repository is intended for academic and educational purposes.
