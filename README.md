# Systemverilog Template

This project template are designed to streamline the development of SystemVerilog projects using
Verilator, GTKWave, and Make. The template includes a Makefile with various recipes for compiling,
simulating, and visualizing the design. It also includes a directory structure for organizing the
HDL files, test benches, and simulation waveforms.

---

<!--toc:start-->
- [Systemverilog Template](#systemverilog-template)
  - [To-Do](#to-do)
  - [Before to use](#before-to-use)
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
    - [ ] Explain how to create you own project.
2. [ ] Improve `quartus-tools` for synthesize.
    - [x] Review `quartus_map` flags &amp; document it.
    - [x] Review `global-assigments`
    - [x] Create `qsf` file for synthesis.
    - [ ] Complete `quartus assignments` descriptions.
    - [ ] Modified `Makefile` to use `quartus-pgm` tool (load the design on the board).
3. [ ] Complement the information and use of `yosys`.
4. [ ] Integrate `Xilinx` tools (on-hold)

## Before to use

First you be sure that you have installed the following dependencies:
- [Verilator][2]
- [GTKWave][3]
- [Quartus Prime Lite][5]
- [Yosys][6]
- [GNU Make][7]
- [Clang](15)
- Any text editor of your choice

> [!NOTE]
> `intercept-build` is part of the `scan-build toolset` from Clang. This tool is to create
> `compile_commands.json` that lists the exact compiler commands used to compile each source
> file in a project, helping tools like code editors and analyzers understand the build process.

### Archlinux

On `Archlinux` you can install dependencies using a package manager as [paru][10], [yay][11] or
[pamac][12]. For the last version this template all dependencies have been installed using `paru`:

```bash
paru -S verilator gtkwave quartus-free yosys clang make arrow-usb-blaster
```


### Ubuntu

Install dependencies using from the software sources or the software center.

```bash
sudo apt-get install verilator gtkwave clang yosys build-essential
```

For installing `quartus-prime` you need to download the package from [quartus for linux][13] and
install [compile it][14]

> [!TIP]
> Sometimes verilator does not work properly, for solve this try to reinstall package, to be sure
> that verilator is working as expected run `verilator --help` on command line and compare the
> output with [verilator output](./docs/verilator_output.md)

### Last review

The most recent revision of this project was completed using the following tools and their
respective versions:

* Linux Operating System: ` Manjaro Linux x86_64 kernel: 6.6.52-1-MANJARO`
* [Verilator][1]: `Version 5.028`
* [GTKWave][3] : `Version v3.3.120`
* [Quartus Prime Lite][5] : `Version 23.1`
* [Yosys][6] : `Version 0.43`
* [GNU Make][7] : `Version 4.4.1`
* [Clang][15] : `Version 18.1.8`
* The text editor : [Neovim][9] `v0.10.1`


## How to use it?

### Quick use

1. Verilate your project: `make all` or `make`
2. Build and run the simulation: `make run`
3. Once that you confirm the simulation works as you expected synthesize you project: `make qrtl`

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
