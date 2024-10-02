# Systemverilog Template

This project template is designed to streamline the development of SystemVerilog projects using Verilator, GTKWave, and Make. The template includes a Makefile with various recipes for compiling, simulating, and visualizing the design. It also includes a directory structure for organizing the HDL files, test benches, and simulation waveforms.

---

<!--toc:start-->
- [Systemverilog Template](#systemverilog-template)
  - [To-Do](#to-do)
    - [Verilator](#verilator)
      - [Verilator installation](#verilator-installation)
        - [Ubuntu error](#ubuntu-error)
    - [GTKWave](#gtkwave)
      - [GTKWave installation](#gtkwave-installation)
    - [GNU Make](#gnu-make)
      - [Make installation](#make-installation)
    - [Quartus Prime Lite](#quartus-prime-lite)
      - [Quartus Prime Lite Installation](#quartus-prime-lite-installation)
      - [License](#license)
    - [Yosys](#yosys)
      - [Yosys installation](#yosys-installation)
    - [Other tools](#other-tools)
    - [NVIM Plugins](#nvim-plugins)
  - [How to compile and simulate the project](#how-to-compile-and-simulate-the-project)
    - [Structure of the project](#structure-of-the-project)
    - [Use of Verilator](#use-of-verilator)
    - [Use of quartus tools](#use-of-quartus-tools)
    - [Important recipes for `make` tool](#important-recipes-for-make-tool)
    - [Steps to develop your project](#steps-to-develop-your-project)
    - [Multiple module project](#multiple-module-project)
  - [References](#references)
<!--toc:end-->

---

## To-Do
1. [ ] Improve documentation.
2. [ ] Implement `cmake` for compile output.
3. [ ] Improve `quartus-tools` for synthesize.
    - Review `quartus_map` flags &amp; document it.
    - Review `global-assigments`
    - Create `qsf` file for synthesis.
    - Modified `Makefile` to use `quartus-pgm` tool (load the design on the board).
4. [ ] Complement the information and use of `yosys`.
5. [ ] Integrate `Xilinx` tools (on-hold)
* [Yosys][6]
* The text editor of your choice

The most recent revision of this project was completed using the following tools and their respective versions:

* Linux Operating System: ` Manjaro Linux x86_64 kernel: 6.6.46-1-MANJARO`
* [Verilator][1]: `Version 5.026`
* [GTKWave][3] : `Version v3.3.120`
* [Quartus Prime Lite][5] : `Version 23.1`
* [Yosys][6] : `Version 0.43`
* The text editor : nvim `v0.10.1`

### Verilator

Verilator is an open-source, fast, and efficient hardware description language (HDL) simulator used primarily for the verification and testing of digital designs written in Verilog or SystemVerilog. It is known for its high-performance capabilities and is widely used in the hardware design and verification industry.

Some important features that verilator have are:

* `HDL Language Support`: Verilator primarily supports Verilog and SystemVerilog, which are the two most commonly used hardware description languages for digital design. It can compile and simulate designs written in these languages.
* `Compile-Based Simulation`: Unlike traditional simulators, which interpret HDL code during simulation, Verilator uses a unique compile-based approach. It converts the hardware description code into C++ or SystemC code and then compiles this generated code into an executable. This compilation process enables Verilator to achieve high simulation speeds.
* `Cycle-Accurate Simulation`: Verilator provides cycle-accurate simulation, meaning it accurately models the behavior of digital designs at the cycle level. This level of accuracy is essential for verifying complex hardware systems and ensures precise timing analysis.
* `Performance`: Verilator is known for its speed and efficiency. Due to its compile-based approach and C++/SystemC execution, it can achieve much faster simulation times compared to traditional interpreted simulators.
* `Debugging Support`: Verilator provides useful debugging capabilities, including tracing and signal dumping features. These tools help design and verification engineers in understanding and debugging the behavior of the hardware design during simulation.

#### Verilator installation
Verilator can be found in multiple package managers which makes it easy to install for example:

* for Archlinux

	Before install the package install the next dependencies to prevent mistakes

	```bash
	sudo pacman -S git perl python3 make autoconf g++ flex bison ccache
	sudo pacman -S libgoogle-perftools-dev numactl perl-doc
	sudo pacman -S libfl2  # Ubuntu only (ignore if gives error)
	sudo pacman -S libfl-dev  # Ubuntu only (ignore if gives error)
	sudo pacman -S zlibc zlib1g zlib1g-dev  # Ubuntu only (ignore if gives error)
	```
	After installing the dependencies download `verilator` with the package manager:

	```bash
	sudo pacman -S verilator
	```

* for Ubuntu

	Before install the package install the next dependencies to prevent mistakes

	```bash
	sudo apt-get install git perl python3 make autoconf g++ flex bison ccache
	sudo apt-get install libgoogle-perftools-dev numactl perl-doc
	sudo apt-get install libfl2  # Ubuntu only (ignore if gives error)
	sudo apt-get install libfl-dev  # Ubuntu only (ignore if gives error)
	sudo apt-get install zlibc zlib1g zlib1g-dev  # Ubuntu only (ignore if gives error)
	```
	After installing the dependencies download `verilator` with the package manager:
	```bash
	sudo apt-get install verilator
	```

To verify that verilator has been installed correctly you must run the command or `verilator --help ` and you should see an output like the following:

```bash
NAME
    Verilator - Translate and simulate SystemVerilog code using C++/SystemC

SYNOPSIS
        verilator --help
        verilator --version
        verilator --cc [options] [source_files.v]... [opt_c_files.cpp/c/cc/a/o/so]
        verilator --sc [options] [source_files.v]... [opt_c_files.cpp/c/cc/a/o/so]
        verilator --lint-only -Wall [source_files.v]...

DESCRIPTION
    The "Verilator" package converts all synthesizable, and many behavioral,
    Verilog and SystemVerilog designs into a C++ or SystemC model that after
    compiling can be executed. Verilator is not a traditional simulator, but
    a compiler.

    For documentation see <https://verilator.org/verilator_doc.html>.

ARGUMENT SUMMARY
...
all flags
...
DISTRIBUTION
    The latest version is available from <https://verilator.org>.

    Copyright 2003-2022 by Wilson Snyder. This program is free software; you
    can redistribute it and/or modify the Verilator internals under the
    terms of either the GNU Lesser General Public License Version 3 or the
    Perl Artistic License Version 2.0.

    All Verilog and C++/SystemC code quoted within this documentation file
    are released as Creative Commons Public Domain (CC0). Many example files
    and test files are likewise released under CC0 into effectively the
    Public Domain as described in the files themselves.

SEE ALSO
    verilator_coverage, verilator_gantt, verilator_profcfunc, make,

    "verilator --help" which is the source for this document,

    and <https://verilator.org/verilator_doc.html> for detailed
    documentation.
```

You only have to check if verilator is in the available packages of your package manager: however, it is also possible to compile the tool, for this see the [Verilator Installation][2].

##### Ubuntu error

<!-- TODO: Put the output with the compilation error  -->

It looks like there is a little bug with the Ubuntu installation, and you cannot use `verilator` to compile the project; there are two ways to check this error; the first one, as this paragraph says, is that the project will not compile and the second one just run `verilator --help` in a terminal and compare the output with [Verilator arguments](https://verilator.org/guide/latest/exe_verilator.html), when the bug exists you will see fewer arguments on your prompt.

For the moment, there's no specific solution for this; just be sure that you already have installed all dependencies and remove the package and try to install it again with the following:

```bash
sudo apt-get install verilator
```

After this try to compile the project again or try to check the [Verilator arguments](https://verilator.org/guide/latest/exe_verilator.html)

### GTKWave

GTKWave is a widely used open-source waveform viewer for displaying and analyzing simulation results of digital hardware designs. It is a valuable tool for hardware design and verification engineers as it allows them to visualize waveforms, traces, and other simulation data, aiding in the debugging and analysis of digital circuits. GTKWave is compatible with various HDL simulators as `Verilator`.

GTKWave provides a robust and user-friendly environment for waveform visualization and analysis, making it a popular choice among hardware engineers for debugging and verifying digital designs. Its support for multiple file formats, cross-platform compatibility, and integration with other tools make it a versatile and powerful waveform viewer that streamlines the design and verification processes. Additionally, the ability to group, color-code, annotate, and probe signals further enhances its usability for understanding and debugging complex designs.

#### GTKWave installation

Like verilator, GTKWave is available in multiple package managers, for which you should check if it is available in the package manager of your choice.

* for Archlinux
	```bash
	sudo pacman -S gtkwave
	```

* for Ubuntu
	```bash
	sudo apt-get install gtkwave
	```

In any case you can consult the official [GTKWave][3] repository to install it manually.

### GNU Make

Is a tool which controls the generation of executable and other non-source files of a program from the program's source files. Make gets its knowledge of how to build your program from a file called the Makefile, which lists each of the non-source files and how to compute it from other files. When you write a program, you should write a Makefile for it, so that it is possible to use Make to build and install the program.

This tool is usually available by default if you have a Linux-based environment; however, if you need to install it, you can do it in the following way.

#### Make installation

* for Archlinux
	```bash
	sudo pacman -S make
	```

* for Ubuntu
	```bash
	sudo apt-get install make
	```
In any case, you can consult the official website [GNU Make][4] for its use and installation.

### Quartus Prime Lite

 Quartus Prime Lite is a free version of the Quartus Prime software, which is a powerful design software suite used for designing and programming Field-Programmable Gate Arrays (FPGAs) and Complex Programmable Logic Devices (CPLDs). Quartus Prime Lite provides a subset of the features available in the full version of Quartus Prime, but it still includes many of the essential tools needed for FPGA design, such as a design entry tool, a synthesis tool, a place-and-route tool, and a timing analysis tool. Quartus Prime Lite is a popular choice for hobbyists, students, and small businesses who want to experiment with FPGA design without investing in the full version of Quartus Prime.

#### Quartus Prime Lite Installation

* for Archlinux
    In this case, the package is in `AUR`, so you can install it manually by [quartus](https://aur.archlinux.org/packages/quartus-free), but you can use a package manager which has enabled the `AUR` packages, for example [paru](https://github.com/Morganamilo/paru) or [pamac](https://aur.archlinux.org/packages/pamac-aur).

    * For this project we used `paru` so just run:

        ```bash
        paru -S quartus-free
        ```

    * Pamac
        Use the GUI to search the package `quartus-free`

    With these methods, suppose everything is going to be installed. To be sure, check that the following packages are installed:

    * `quartus-free-devinfo-arria_lite`
    * `quartus-free-devinfo-cyclone`
    * `quartus-free-devinfo-cyclone10lp`
    * `quartus-free-devinfo-cyclonev`
    * `quartus-free-devinfo-max`
    * `quartus-free-devinfo-max10`
    * `quartus-free-devinfo-help`
    * `quartus-free-devinfo-hls`
    * `quartus-free-devinfo-quartus`
    * `quartus-free-devinfo-questa`

    Additionally, if you want to probe your design in a development board, you need to install the USB blaster drivers by:

    ```bash
    paru -S arrow-usb-blaster
    ```


* for Ubuntu
    Check the official documentation in [Intel Quartus Prime Lite Edition Design Software for linux](https://www.intel.com/content/www/us/en/software-kit/785085/intel-quartus-prime-lite-edition-design-software-version-22-1-2-for-linux.html)

#### License
In booth cases it is necessary to set a `LM_LICENCE` to use the tools properly.

**NOTE:** It looks like there are changes in the steps to generate the setup license; for the moment, check [Introduction to Intel FPGA Software Installation and Licensing](https://www.intel.com/content/www/us/en/docs/programmable/683472/22-1/introduction-to-fpga-software-installation.html).

### Yosys
 Yosys is an open-source software suite for Verilog synthesis, which means it is primarily designed to work with Verilog code. However, Yosys also has some support for SystemVerilog constructs, such as interfaces, packages, and assertions. Yosys can also handle some SystemVerilog features that are syntactically similar to Verilog, such as always_ff and always_comb blocks. However, Yosys does not fully support all of the advanced features of SystemVerilog, such as classes, dynamic arrays, and constrained random testing. Therefore, if you are working with SystemVerilog, you may need to use a different synthesis tool that provides more comprehensive support for SystemVerilog.

#### Yosys installation

* for Archlinux
    ```bash
    sudo pacman -S yosys
    ```

* for Ubuntu
	```bash
	sudo apt-get install yosys
	```

<!--### Installation-->

### Other tools

Other tools that can help you to develop your projects are the following:

* [`svls`](https://github.com/dalance/svls)
    As you know exist LSP (Language Server Protocol) that is a communication protocol used to enable interaction between code editors and development tools that provide advanced editing features for programming languages and development environments. LSP provies:
    - Intelligent autocompletation
    - Syntax highlighting
    - Real-time error detection
    - Code  Navigation
    - Refactoring
    - Code references search
    - Safe renaming

    For this case, we have what is `svls`, which is the SystemVerilog language server. Unfortunately, it does not have all the features that `LSP` offers, but the main advantage is that it provides real-time error detection, which optimizes the development of the project.

    This template already contemplates the use of `svls`, so you do not have to worry about configuring it; that is to say, modify the `.svls.toml` file needed for the configuration; in any case, if you do not use it, ignore it.

    For install this tool first check  [svls Repo](https://github.com/dalance/svls).

    <!-- TODO: Complete this -->

* [`svlint`](https://github.com/dalance/svlint)

### NVIM Plugins

## How to compile and simulate the project

### Structure of the project

```bash
├── gtkwave_setup.gtkw
├── makefile
├── obj_dir
│   └── # Here
├── qfiles
│   └── # Here
├── rtl
│   ├── include             # Here
│   │   └── definitions.svh # Here
│   └── mod_main.sv         # Here
├── rtl.ys                  # Here
└── tb_sim                  #
    ├── tb_mod_main.cpp     # Here
    ├── tb_mod_main.hpp     # Here
    └── waveform.vcd        # Here

```

### Use of Verilator
When working with Verilator we can divide the process into the following stages:
* `Verilating`: This is the process by which the HDL files will be transformed to; for this project, C++ as well as linking the created model with the test bench in the same way written in C++.
* `Build` the simulation: In this step you need to build an executable to run the simulation, unlike `modelsim`, which opens a visual environment, Verilator only converts the `HDL` files to `C++`, for this case the one that performs the simulation is the `C++` test bench itself, which will generate the simulation executable.
* `Simulation`: Once the executable has been generated, the generated file must be run, which will generate a `vcd` file to later visualize it in `GTKWave`.

### Use of quartus tools

### Important recipes for `make` tool

```bash
make all   # Check for errors in the codes, and start the `verilating` process as well as look for errors in the test bench.
make build # Create a executable to run the simulation.
make sim   # Shows the waveforms in GTKWave if the make run command has already been executed previously.
make run   # Creates the executable, runs the simulation and displays the generated waves in GTKWave its a combination of build & sim.
make clean # Deletes all files generated by Verilator & Intel tools and by the executable.
make view  # Do Analysis and Synthesis, Generate Netlist, and open the RTLViewer, all with Intel tools.
make ys    # Create a simple RTL diagram with the Yosys tool(experimental).
make help  # You will see this information on your terminal.
```

### Steps to develop your project

1. First create you design in `mod_main.sv` file; this file is in `rtl` directory.
2. Use the linter in your project with `make all` or `make`.
3. Create the simulation inside `tb_mod_main.cpp` file; this file is in `tb_sim` directory.
4. If the last steps do not show errors you can run `make run` to build and execute the simulation.
5. If the simulation works adequately for what you are planning to do, you can use the `Quartus tools` to verify if the design is synthesizable and visualize the `RTL` diagram of the created module, for this run the recipe `make view`.
6. Also you can see the `RTL` diagram using `yosys` tool but if your goal is to upgrade to a development board, I recommend using the `Quartus tools`.

### Multiple module project

This template was designed for a whole `HDL` project; you don't need to worry about modifying the  recipes in the `makefile`, so to create different modules in the project, you just need to create a new `.sv` file with the module inside  `rtl/include` directory like this:

```bash
rtl
├── include
│   ├── definitions.svh
│   └── my_module.sv
└── mod_main.sv
```

After this you only have to call the module just like in the example:

```verilog
`include "definitions.svh"
`include "my_module.sv"     // <-- This is where you call your module

module mod_main(
	// Inputs
	input  Bus   i_D,
	input        i_E,
	// Outputs
	output Bus   o_Q,
	output Bus   o_nQ
);

	/*
	* @brief  Instantiation of my module
	* @Note   Remember that your module must have the same name as the file that contains it.
	*/
	my_module u_My_Module(
		// inputs
        //...
		// outputs
        //...
	);
```

Or if you want to be more organized, you can create different directories inside `rtl/include` directory like this:

```bash
rtl
├── include
│   ├── definitions.svh
│   └── my_module
│       ├── my_module_definitions.svh
│       └── my_module.sv
└── mod_main.sv
```

After this you only have to call the module just like this:

```verilog
`include "definitions.svh"
`include "my_module/my_module.svh"     // <-- This is where you call the definitions of your module if you need it
`include "my_module/my_module.sv"      // <-- This is where you call your module

module mod_main(
	// Inputs
	input  Bus   i_D,
	input        i_E,
	// Outputs
	output Bus   o_Q,
	output Bus   o_nQ
);

	/*
	* @brief  Instantiation of my module
	* @Note   Remember that your module must have the same name as the file that contains it.
	*/
	my_module u_My_Module(
		// inputs
        //...
		// outputs
        //...
	);
```

## References
* [Verilator][1]
* [GTKWave][2]
* [GNU Make][4]
* [Quartus Prime Lite][5]
* [Yosys][6]

<!--### References-->
<!--* Verilator Manual-->
[1]: https://verilator.org/guide/latest/overview.html "Verilator"
<!--* Verilator Installation-->
[2]: https://verilator.org/guide/latest/install.html "Verilator Installation"
<!--* GTKWave-->
[3]: https://github.com/gtkwave/gtkwave "GTKWave"
[4]: https://www.gnu.org/software/make/ "GNU Make"
[5]: https://www.intel.com/content/www/us/en/software-kit/785085/intel-quartus-prime-lite-edition-design-software-version-22-1-2-for-linux.html? "Quartus Prime Lite"
[6]: https://github.com/YosysHQ/yosys "Yosys"

