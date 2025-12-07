# SystemVerilog Template

This project template is designed to streamline the development of SystemVerilog projects using
Verilator, GTKWave, and Make. The template includes a Makefile with various recipes for compiling,
simulating, and visualizing the design. It also includes a directory structure for organizing the
HDL files, test benches, and simulation waveforms.

---

<!--toc:start-->
- [SystemVerilog Template](#systemverilog-template)
  - [To-Do](#to-do)
  - [Prerequisites](#prerequisites)
    - [Archlinux](#archlinux)
    - [Ubuntu](#ubuntu)
    - [Last review](#last-review)
  - [How to use it?](#how-to-use-it)
    - [Quick use](#quick-use)
    - [Make targets](#make-targets)
  - [References](#references)
<!--toc:end-->

---

## To-Do
1. [ ] Improve documentation.
    - [ ] Explain how to create your own project.
2. [ ] Improve `quartus-tools` for synthesis.
    - [x] Review `quartus_map` flags & document it.
    - [x] Review `global-assignments`
    - [x] Create `qsf` file for synthesis.
    - [ ] Complete `quartus assignments` descriptions.
    - [ ] Modify `Makefile` to use `quartus-pgm` tool (load the design on the board).
3. [ ] Complement the information and use of `yosys`.
4. [ ] Integrate `Xilinx` tools (on-hold)

## Prerequisites

First, ensure that you have installed the following dependencies:
- [Verilator][2]
- [GTKWave][3]
- [Quartus Prime Lite][5]
- [Yosys][6]
- [GNU Make][7]
- [Clang](15)
- [Ctags](16)
- Any text editor of your choice

> [!NOTE]
> `intercept-build` is part of the `scan-build toolset` from Clang. This tool is to create
> `compile_commands.json` that lists the exact compiler commands used to compile each source
> file in a project, helping tools like code editors and analyzers understand the build process.

### Archlinux

On `Archlinux` you can install dependencies using a package manager such as [paru][10], [yay][11] or
[pamac][12]. For the latest version of this template, all dependencies were installed using `paru`:

```bash
paru -S verilator gtkwave quartus-free yosys clang make arrow-usb-blaster ctags
```


### Ubuntu

Install dependencies from the software sources or use [apt][17].

```bash
sudo apt-get install verilator gtkwave clang yosys ctags build-essential
```

To install `quartus-prime`, you need to download the package from [quartus for linux][13] and
follow the installation instructions (e.g., extracting the [tarball][14]).

> [!TIP]
> Sometimes Verilator does not work properly. To solve this, try reinstalling the package. To ensure
> that verilator is working as expected run `verilator --help` on command line and compare the
> output with [verilator output](./docs/verilator_output.md)

### Last review

The most recent revision of this project was completed using the following tools and their
respective versions:

* Linux Operating System: ` Manjaro Linux x86_64 kernel: 6.6.52-1-MANJARO`
* [Verilator][1]: `Version 5.034`
* [GTKWave][3] : `Version v3.3.121`
* [Quartus Prime Lite][5] : `Version 24.1`
* [Yosys][6] : `Version 0.44`
* [GNU Make][7] : `Version 4.4.1`
* [Clang][15] : `Version 19.1.7`
* [Ctags][15] : `Version 6.1.0`
* The text editor : [Neovim][9] `v0.11.0`


## How to use it?

### Quick use

1. Verilate your project: `make all` or `make`
2. Build and run the simulation: `make run`
3. Once you confirm the simulation works as expected, synthesize your project: `make qrtl`

### Make targets

The `Makefile` includes the following targets:

- Main targets

    - `make`: Check for errors in the codes, and start the "verilating" process as well as look for errors in the test bench.
    - `make run`: Creates the executable, runs the simulation and displays the generated waves in GTKWave.
    - `make qrtl`: Do Analysis and Synthesis and open the RTLViewer with Intel tools.
    - `make qfull`: Full compilation & analysis with Intel® tools
    - `make view`: Open RTLViewer by Intel® to view the schematic diagram.
    - `make ys`: Create simple RTL diagram with Yosys tool.
    - `make clean`: Clean the project.
    - `make help`: Show a short description of the commands
- Intel® Tools targets
    - `make synth`: Synthesis and analysis with Intel® tools.
    - `make fit`: Place & Route with Intel® tools.
    - `make qasm`: Generate Programming Files with Intel® tools.
    - `make qsta`: Timing analysis with Intel® tools.
    - `make qeda`: Write EDA netlist with Intel® tools.
    - `make net`: Generate netlist with Intel® tools.

## References
* [Verilator][1]
* [GTKWave][2]
* [GNU Make][4]
* [Quartus Prime Lite][5]
* [Yosys][6]
* [GNU Make][7]
* [Neovim][9]

<!--### References-->
[1]: https://verilator.org/guide/latest/overview.html "Verilator"
[2]: https://verilator.org/guide/latest/install.html "Verilator Installation"
[3]: https://github.com/gtkwave/gtkwave "GTKWave"
[4]: https://www.gnu.org/software/make/ "GNU Make"
[5]: https://www.intel.com/content/www/us/en/software-kit/785085/intel-quartus-prime-lite-edition-design-software-version-22-1-2-for-linux.html? "Quartus Prime Lite"
[6]: https://github.com/YosysHQ/yosys "Yosys"
[7]: https://www.gnu.org/software/make/ "GNU Make"
[8]: https://ftp.gnu.org/gnu/make/ "GNU Make Installation"
[9]: https://github.com/neovim/neovim "neovim"
[10]: https://github.com/Morganamilo/paru "Paru"
[11]: https://github.com/Jguer/yay "Yay"
[12]: https://wiki.manjaro.org/index.php/Pamac "Pamac"
[13]: https://www.intel.com/content/www/us/en/software-kit/661017/intel-quartus-prime-lite-edition-design-software-version-20-1-for-linux.html "quartus-linux"
[14]: https://askubuntu.com/questions/25961/how-do-i-install-a-tar-gz-or-tar-bz2-file "ubuntu package"
[15]: https://clang.llvm.org/ "clang"
[16]: https://github.com/universal-ctags/ctags "ctags"
[17]: https://help.ubuntu.com/kubuntu/desktopguide/es/apt-get.html "apt"
