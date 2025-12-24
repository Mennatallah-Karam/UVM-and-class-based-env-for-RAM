# UVM and Class-Based Verification Environment for RAM

A comprehensive verification project demonstrating both **Class-Based** and **UVM (Universal Verification Methodology)** approaches for verifying a Single Port RAM module using SystemVerilog.

## 📋 Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Design Under Test](#design-under-test)
- [Verification Methodologies](#verification-methodologies)
- [Test Cases](#test-cases)
- [Getting Started](#getting-started)
- [Running Simulations](#running-simulations)
- [Components Description](#components-description)
- [Coverage Goals](#coverage-goals)
- [Results and Reports](#results-and-reports)
- [Tools and Requirements](#tools-and-requirements)

## 🎯 Overview

This project implements professional-grade verification environments for a Single Port RAM using two industry-standard approaches:

1. **Class-Based Environment**: A structured SystemVerilog testbench using object-oriented programming principles
2. **UVM Environment**: A complete UVM-compliant verification environment following Accellera standards

Both environments provide comprehensive functional verification with automated checking, coverage collection, and detailed reporting.

## 📁 Project Structure

```
UVM-and-class-based-env-for-RAM/
│
├── class_based_env/
│   ├── coverage.sv          # Functional coverage definitions
│   ├── driver.sv            # Drives transactions to DUT
│   ├── env.sv               # Top-level environment container
│   ├── file.f               # Compilation file list
│   ├── if.sv                # Interface connecting TB to DUT
│   ├── monitor.sv           # Observes DUT behavior
│   ├── package.sv           # Package and imports
│   ├── run.do               # Simulator run script
│   ├── scoreboard.sv        # Result checker and validator
│   ├── sequencer.sv         # Transaction generator
│   ├── subscriber.sv        # Coverage collector
│   ├── top.sv               # Testbench top module
│   └── transaction.sv       # Transaction class definition
│
├── UVM/
│   ├── my_agent.svh         # UVM agent component
│   ├── my_driver.svh        # UVM driver
│   ├── my_env.svh           # UVM environment
│   ├── my_if.svh            # Interface definition
│   ├── my_monitor.svh       # UVM monitor
│   ├── my_package.sv        # UVM package file
│   ├── my_scoreboard.svh    # UVM scoreboard
│   ├── my_sequencer.svh     # UVM sequencer
│   ├── my_sequence.svh      # Sequence definitions
│   ├── my_subscriber.svh    # Coverage subscriber
│   ├── my_test.svh          # Test cases
│   ├── sequence_item.svh    # Sequence item definition
│   └── top.sv               # UVM testbench top
│
└── README.md                # This file
```

## 🔧 Design Under Test

### RAM Specifications

The DUT is a **Single Port Synchronous RAM** with the following characteristics:

| Parameter | Value |
|-----------|-------|
| Memory Type | Single Port RAM |
| Data Width | 32 bits |
| Address Width | 4 bits |
| Memory Depth | 16 locations (0x0 to 0xF) |
| Clock | Synchronous (positive edge) |
| Reset | Asynchronous active high |

### Interface Signals

```systemverilog
interface ram_if(input bit clk);
    logic        rst;       // Reset signal
    logic        we;        // Write enable
    logic [3:0]  addr;      // Address input
    logic [31:0] data_in;   // Write data
    logic [31:0] data_out;  // Read data
endinterface
```

### Functional Behavior

- **Write Operation**: When `we = 1`, data from `data_in` is written to location `addr`
- **Read Operation**: When `we = 0`, data at location `addr` appears on `data_out`
- **Reset**: When `rst = 1`, all memory locations are cleared to 0
- **Synchronous**: All operations occur on positive clock edge

## 🏗️ Verification Methodologies

### Class-Based Environment Architecture

```
┌──────────────────────────────────────────┐
│           Top Module (top.sv)            │
│  ┌────────────────────────────────────┐  │
│  │      Environment (env.sv)          │  │
│  │                                    │  │
│  │  ┌─────────────┐  ┌─────────────┐  │  │
│  │  │ Sequencer   │  │  Monitor    │  │  │
│  │  │ (transaction│  │  (observes  │  │  │
│  │  │  generator) │  │   signals)  │  │  │
│  │  └──────┬──────┘  └──────┬──────┘  │  │
│  │         │                 │        │  │
│  │         ▼                 ▼        │  │
│  │  ┌─────────────┐  ┌─────────────┐  │  │
│  │  │   Driver    │  │ Scoreboard  │  │  │
│  │  │  (drives    │  │  (checks    │  │  │
│  │  │   DUT)      │  │  results)   │  │  │
│  │  └──────┬──────┘  └─────────────┘  │  │
│  │         │                          │  │
│  │  ┌──────▼──────┐  ┌─────────────┐  │  │
│  │  │ Subscriber  │  │  Coverage   │  │  │
│  │  │ (coverage   │  │  (groups)   │  │  │
│  │  │ collection) │  │             │  │  │
│  │  └─────────────┘  └─────────────┘  │  │
│  └────────────────────────────────────┘  │
│                   │                      │
│          ┌────────▼────────┐             │
│          │  Interface      │             │
│          │  (ram_if)       │             │
│          └────────┬────────┘             │
│                   │                      │
│          ┌────────▼────────┐             │
│          │    RAM DUT      │             │
│          └─────────────────┘             │
└──────────────────────────────────────────┘
```

### UVM Environment Architecture

```
┌──────────────────────────────────────────┐
│         Test (my_test.svh)               │
│    • Configuration                       │
│    • Sequence start                      │
└──────────────┬───────────────────────────┘
               │
┌──────────────▼───────────────────────────┐
│      Environment (my_env.svh)            │
│  ┌───────────────────────────────────┐   │
│  │    Agent (my_agent.svh)           │   │
│  │  ┌─────────────┐  ┌────────────┐  │   │
│  │  │ Sequencer   │◄─┤  Sequence  │  │   │
│  │  └──────┬──────┘  └────────────┘  │   │
│  │         │ seq_item                │   │
│  │         ▼                         │   │
│  │  ┌──────────────┐                 │   │
│  │  │   Driver     │                 │   │
│  │  │              │                 │   │
│  │  └──────┬───────┘                 │   │
│  │         │ vif                     │   │
│  │         │                         │   │
│  │  ┌──────▼───────┐                 │   │
│  │  │   Monitor    │─────────┐       │   │
│  │  └──────────────┘         │       │   │
│  └─────────────────────────┬─┼───────┘   │
│                            │ │           │
│  ┌─────────────────────────▼─┼───────┐   │
│  │    Scoreboard (my_scoreboard)     │   │
│  │    • Checks expected vs actual    │   │
│  └───────────────────────────────────┘   │
│  ┌───────────────────────────────────┐   │
│  │    Subscriber (my_subscriber)     │   │
│  │    • Functional coverage          │   │
│  └───────────────────────────────────┘   │
└──────────────┬───────────────────────────┘
               │
      ┌────────▼────────┐
      │   Interface     │
      │   (my_if.svh)   │
      └────────┬────────┘
               │
      ┌────────▼────────┐
      │    RAM DUT      │
      └─────────────────┘
```

## ✅ Test Cases

### Test Case 1: Reset Verification
**Objective**: Verify all memory locations are cleared on reset

**Procedure**:
1. Assert reset signal
2. De-assert reset
3. Read all 16 memory locations
4. Verify all locations contain 0x0000

**Expected Result**: All locations = 0x0000

---

### Test Case 2: Write and Read All Locations
**Objective**: Verify basic write and read functionality

**Procedure**:
1. Write value 0xFAF5 to all memory locations (0x0 to 0xF)
2. Read back from all locations
3. Compare read data with written data

**Expected Result**: All locations return 0xFAF5

---

### Test Case 3: Boundary Test - Address 0x0
**Objective**: Verify lowest address boundary

**Procedure**:
1. Write unique value (e.g., 0x1234) to address 0x0
2. Read from address 0x0
3. Verify data integrity

**Expected Result**: Data matches written value

---

### Test Case 4: Boundary Test - Address 0xF
**Objective**: Verify highest address boundary

**Procedure**:
1. Write unique value (e.g., 0xABCD) to address 0xF
2. Read from address 0xF
3. Verify data integrity

**Expected Result**: Data matches written value

---

### Test Case 5: Write-Read with Write Enable
**Objective**: Verify write enable control functionality

**Procedure**:
1. Reset RAM
2. Write 0x5FFF to address 0x5 with we=1
3. Read from address 0x5 with we=0
4. Verify correct data retrieval

**Expected Result**: Read data = 0x5FFF

---

### Test Case 6: Random Access Pattern
**Objective**: Comprehensive random testing

**Procedure**:
1. Reset RAM
2. Generate random addresses and data
3. Perform random write operations
4. Read and verify each written location
5. Check write enable functionality

**Expected Result**: All read data matches written data

## 🚀 Getting Started

### Prerequisites

**Required Software**:
- QuestaSim/ModelSim 10.7c or later
- OR Synopsys VCS
- OR Cadence Xcelium

**Required Libraries**:
- UVM library (1.2 or IEEE 1800.2-2017)
- SystemVerilog compiler support

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Mennatallah-Karam/UVM-and-class-based-env-for-RAM.git
cd UVM-and-class-based-env-for-RAM
```

2. Ensure simulator is properly installed and licensed

3. Set UVM library path (for UVM environment):
```bash
export UVM_HOME=/path/to/uvm-1.2
```

## ▶️ Running Simulations

### Class-Based Environment

#### Method 1: Using provided script (QuestaSim/ModelSim)

```bash
cd class_based_env
vsim -do run.do
```

#### Method 2: Manual compilation and simulation

```bash
# Navigate to directory
cd class_based_env

# Compile all files
vlog -f file.f

# Run simulation
vsim -c top -do "run -all; quit -f"

# With GUI
vsim top
run -all
```

#### Method 3: With coverage collection

```bash
vlog -coveropt 3 +cover -f file.f
vsim -coverage top -do "coverage save -onexit cov.ucdb; run -all; quit -f"
vcover report -html cov.ucdb
```

---

### UVM Environment

#### Method 1: Basic compilation and run

```bash
cd UVM

# Compile with UVM
vlog +incdir+$UVM_HOME/src \
     $UVM_HOME/src/uvm.sv \
     +incdir+. \
     my_package.sv \
     top.sv

# Run default test
vsim -c top +UVM_TESTNAME=my_test \
     -do "run -all; quit -f"
```

#### Method 2: With coverage

```bash
# Compile with coverage enabled
vlog -coveropt 3 +cover \
     +incdir+$UVM_HOME/src \
     $UVM_HOME/src/uvm.sv \
     +incdir+. \
     my_package.sv \
     top.sv

# Run with coverage collection
vsim -coverage -vopt top -c \
     +UVM_TESTNAME=my_test \
     -do "coverage save -onexit uvm_cov.ucdb; run -all; quit -f"

# Generate HTML report
vcover report -html uvm_cov.ucdb
```

#### Method 3: With UVM verbosity control

```bash
# Run with different verbosity levels
vsim top +UVM_TESTNAME=my_test +UVM_VERBOSITY=UVM_HIGH

# Available verbosity levels:
# UVM_NONE, UVM_LOW, UVM_MEDIUM, UVM_HIGH, UVM_FULL, UVM_DEBUG
```

## 📦 Components Description

### Class-Based Environment Components

#### 1. Transaction Class (`transaction.sv`)
- Defines data structure for stimulus
- Contains randomization constraints
- Fields: address, data, write_enable, reset

```systemverilog
class transaction;
    rand bit [3:0]  addr;
    rand bit [15:0] data_in;
    rand bit        we;
    bit [15:0]      data_out;
    bit             rst;
endclass
```

#### 2. Sequencer (`sequencer.sv`)
- Generates transaction sequences
- Implements test scenarios
- Sends transactions to driver

#### 3. Driver (`driver.sv`)
- Receives transactions from sequencer
- Converts to pin-level activity
- Drives signals through virtual interface

#### 4. Monitor (`monitor.sv`)
- Observes DUT interface signals
- Captures pin-level activity
- Converts to transaction objects
- Sends to scoreboard and subscriber

#### 5. Scoreboard (`scoreboard.sv`)
- Implements reference model (golden model)
- Compares DUT output with expected results
- Reports mismatches
- Tracks pass/fail statistics

#### 6. Subscriber (`subscriber.sv`)
- Receives transactions from monitor
- Samples functional coverage
- Reports coverage metrics

#### 7. Coverage (`coverage.sv`)
- Defines coverage groups
- Address coverage
- Data coverage
- Operation coverage (read/write)
- Cross coverage

#### 8. Environment (`env.sv`)
- Top-level container
- Instantiates all components
- Connects components together
- Manages simulation phases

---

### UVM Environment Components

#### 1. Sequence Item (`sequence_item.svh`)
```systemverilog
class seq_item extends uvm_sequence_item;
    rand bit [3:0]  addr;
    rand bit [15:0] data_in;
    rand bit        we;
    bit [15:0]      data_out;
    `uvm_object_utils(seq_item)
endclass
```

#### 2. Sequence (`my_sequence.svh`)
- Defines stimulus patterns
- Extends uvm_sequence
- Implements body() task

#### 3. Sequencer (`my_sequencer.svh`)
- Routes sequence items to driver
- Extends uvm_sequencer
- Parameterized with sequence item type

#### 4. Driver (`my_driver.svh`)
- Receives items from sequencer
- Drives DUT through virtual interface
- Implements run_phase()

#### 5. Monitor (`my_monitor.svh`)
- Observes interface signals
- Writes transactions to analysis port
- No functional behavior

#### 6. Agent (`my_agent.svh`)
- Encapsulates driver, monitor, sequencer
- Can be configured as active/passive
- Reusable verification component

#### 7. Scoreboard (`my_scoreboard.svh`)
- Receives transactions via analysis port
- Implements checking logic
- Reports pass/fail status

#### 8. Subscriber (`my_subscriber.svh`)
- Receives transactions via analysis port
- Collects functional coverage
- Extends uvm_subscriber

#### 9. Environment (`my_env.svh`)
- Top-level container
- Instantiates agent, scoreboard, subscriber
- Connects analysis ports

#### 10. Test (`my_test.svh`)
- Extends uvm_test
- Configures environment
- Starts sequences
- Controls simulation flow

## 📊 Coverage Goals

### Functional Coverage

#### Address Coverage
- **Goal**: 100%
- **Bins**: All 16 addresses (0x0 to 0xF)
- **Status**: Individual bins for each address

#### Data Coverage
- **Goal**: >90%
- **Bins**: 
  - All zeros (0x0000)
  - All ones (0xFFFF)
  - Alternating patterns
  - Random values

#### Operation Coverage
- **Goal**: 100%
- **Bins**:
  - Write operation (we=1)
  - Read operation (we=0)
  - Reset operation

#### Cross Coverage
- **Goal**: >85%
- **Crosses**:
  - Address × Write Enable
  - Address × Data patterns
  - Address × Operation type

### Code Coverage

| Metric | Goal | Description |
|--------|------|-------------|
| Line Coverage | >95% | Percentage of executed code lines |
| Branch Coverage | >90% | All conditional branches taken |
| Toggle Coverage | >85% | Signal transitions covered |
| FSM Coverage | 100% | All states and transitions |

## 📈 Results and Reports

### Expected Simulation Output

```
# ========================================
# RAM Verification Environment
# ========================================
# [ENV] Building testbench components...
# [SEQ] Starting test sequence...
# [DRV] Writing 0xFAF5 to address 0x0
# [MON] Captured write transaction
# [SCB] PASS: Expected=0xFAF5, Got=0xFAF5
# ...
# ========================================
# Simulation Results
# ========================================
# Total Transactions: 100
# Passed: 100
# Failed: 0
# Success Rate: 100%
# ========================================
# Coverage Summary
# ========================================
# Address Coverage: 100.00%
# Data Coverage: 93.75%
# Operation Coverage: 100.00%
# Overall Functional Coverage: 97.92%
# ========================================
```

### Generating Reports

```bash
# Coverage report
vcover report -html coverage.ucdb -output cov_report

# Transcript analysis
grep "PASS\|FAIL" transcript > results.txt

# UVM report
grep "UVM_ERROR\|UVM_FATAL" transcript
```

## 🛠️ Tools and Requirements

### Software Requirements

| Tool | Version | Purpose |
|------|---------|---------|
| QuestaSim/ModelSim | 10.7c+ | Simulation |
| VCS | 2018.09+ | Alternative simulator |
| Xcelium | 18.09+ | Alternative simulator |
| UVM Library | 1.2 | UVM methodology |
| SystemVerilog | IEEE 1800-2017 | Language standard |

### Hardware Requirements

- **RAM**: Minimum 4GB (8GB recommended)
- **Processor**: Multi-core recommended for parallel compilation
- **Storage**: 1GB free space for simulation files

## 🐛 Debugging Tips

### Enable Debug Messages

**Class-Based**:
```systemverilog
// In any component
$display("[DEBUG] %0t: Transaction details: %p", $time, trans);
```

**UVM**:
```systemverilog
`uvm_info(get_type_name(), 
          $sformatf("Transaction: %s", trans.sprint()), 
          UVM_MEDIUM)
```

### Waveform Viewing

Add to `run.do` or simulation command:
```tcl
vcd file wave.vcd
vcd add -r /*
```

Or for QuestaSim:
```tcl
log -r /*
```

### Common Issues

**Issue**: UVM library not found
```bash
# Solution
export UVM_HOME=/path/to/uvm-1.2
```

**Issue**: Interface connection errors
```systemverilog
// Check virtual interface assignment
initial begin
    if(!uvm_config_db#(virtual ram_if)::get(this, "", "vif", vif))
        `uvm_fatal("NOVIF", "Virtual interface not set")
end
```

**Issue**: Simulation timeout
```systemverilog
// Add timeout
initial begin
    #100000;
    $display("Simulation timeout!");
    $finish;
end
```

## 📚 Learning Resources

- **UVM Cookbook**: https://verificationacademy.com
- **SystemVerilog for Verification**: Chris Spear & Greg Tumbush
- **IEEE 1800.2-2017**: UVM Standard
- **ChipVerify Tutorials**: https://www.chipverify.com

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📝 License

This project is for educational purposes.

## 👤 Author

**Mennatallah Karam**
- GitHub: [@Mennatallah-Karam](https://github.com/Mennatallah-Karam)

## 🙏 Acknowledgments

- Based on industry-standard verification methodologies
- UVM methodology from Accellera
- Inspired by professional verification practices

---

**Note**: This is an educational project demonstrating verification best practices for single port RAM modules.

For questions or issues, please open an issue on GitHub.
