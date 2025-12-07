#include "tb_mod_main.hpp"        /* Call some definitions */
#include "../obj_dir/Vmod_main.h" /* From Verilating "mod_main.sv" */
#include <cstdint>
#include <iostream>    /* Need std::cout */
#include <verilated.h> /* but you can call the file like this */
#include <verilated_vcd_c.h>

#define MAX_SIM_TIME 2000 /* Duration of the simulation in ps */
#define NPs 20            /* Pulse width in ps */

using std::cout;
using std::endl;

void Param_Init(void);                     /* Parameter initialization */
void Set_In_D(uint8_t tag, uint8_t value); /* Set Input D */

Vmod_main *top;                         /* Instantiation of the mode */

// The 64-bit integer reduces wrap-over issues and allows modulus.
// This is in units of the time precision
// used in Verilog (or from --timescale-override)
uint64_t clock_signal = 0;             /* Current simulation time */
// The 64-bit integer reduces wrap over issues and allows modulus.
// This is in units of the time precision
// used in Verilog (or from --timescale-override)

int main(int argc, char *argv[])
{
    Verilated::commandArgs(argc, argv); // Remember args
    Verilated::traceEverOn(true);

    top = new Vmod_main; // Create model
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    // Do not instead make Vmain as a files-scope static
    // variable, as the "C== static initialization order fiasco"
    // may cause a crash

    top->trace(m_trace, 5);
    m_trace->open("tb_sim/waveform.vcd");

    int counter = 0;
    int cycles = 0;

    while (clock_signal < MAX_SIM_TIME)
    {

        switch (cycles)
        {
            case 0:
                Param_Init();
                break;
            case 1:
                top->i_E = ENABLE;
                Set_In_D(0x0u, 0x01u);
                break;
            case 2:
                top->i_E = ENABLE;
                Set_In_D(0x1u, 0x0Au);
                break;
            case 3:
                top->i_E = ENABLE;
                Set_In_D(0x02u, 0x0B);
                break;
            case 4:
                top->i_E = ENABLE;
                Set_In_D(0x03u, 0x0C);
                break;
            case 5:
                top->i_E = DISABLE;
                Set_In_D(0x04u, 0x0D);
                break;
            case 6:
                top->i_E = 0u;
                Set_In_D(0x05u, 0x0E);
                break;
            case 7:
                top->i_E = 0u;
                Set_In_D(0x06u, 0x0F);
                break;
            case 8:
                top->i_E = ENABLE;
                Set_In_D(0x07u, 0x10);
                break;
            default:
                top->i_E = DISABLE;
                Set_In_D(0u, 0u);
                break;
        }

        top->eval(); // Evaluate mode

        // Just print after a complete cycle pass
        if (counter % 2 == 0)
        {
            cout << cycles << " -> ";              // Print outputs
            cout << "o_Q: " << top->o_Q << " ";    // Print outputs
            cout << "o_nQ: " << top->o_nQ << endl; // Print outputs
        }
        else
        {
        }

        m_trace->dump(clock_signal);

        top->i_clk = !top->i_clk; // Toggle clock signal
        clock_signal += NPs;      // Time passes..
        counter++;
        cycles = counter / 2u;
    }

    m_trace->close();
    top->final(); // Done simulating

    delete top;

    return 0;
}

void Param_Init(void)
{
    top->i_clk = LOW;
    top->i_E   = ENABLE;
    Set_In_D(0u, 0u);
}

void Set_In_D(uint8_t tag, uint8_t value)
{
    top->i_D = (tag << 8u) | (value & 0xFFu);
}
