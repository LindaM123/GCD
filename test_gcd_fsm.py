# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

# test_my_design.py (extended)

import cocotb
from cocotb.triggers import FallingEdge, Timer


async def generate_clock(dut):
    #Generate clock pulses.

    for cycle in range(30):
        dut.clk_i.value = 0
        await Timer(1, units="ns")
        dut.clk_i.value = 1
        await Timer(1, units="ns")


@cocotb.test()
async def my_second_test(dut):
    #Try accessing the design.

    await cocotb.start(generate_clock(dut))  # run the clock "in the background"
        
    await Timer(5, units="ns")  # wait a bit
    
    #se coloca en decimal el valor
    dut.gcd_enable.value = 0;
    dut.nreset_i.value = 1;
    dut.compute_enable.value = 0;
    dut.compare_zero.value = 0;

    dut._log.info("next_state is %s: ", dut.next_state.value)
    dut._log.info("state_o is %s: ", dut.state_o.value)

    await Timer(3, units="ns")

    #se coloca en decimal el valor
    dut.gcd_enable.value = 1;
    dut.nreset_i.value = 1;
    dut.compute_enable.value = 0;
    dut.compare_zero.value = 0;

    dut._log.info("next_state is %s: ", dut.next_state.value)
    dut._log.info("state_o is %s: ", dut.state_o.value)

    await Timer(3, units="ns")

    #se coloca en decimal el valor
    dut.gcd_enable.value = 0;
    dut.nreset_i.value = 1;
    dut.compute_enable.value = 0;
    dut.compare_zero.value = 0;

    dut._log.info("next_state is %s: ", dut.next_state.value)
    dut._log.info("state_o is %s: ", dut.state_o.value)

    await Timer(3, units="ns")

    #se coloca en decimal el valor
    dut.gcd_enable.value = 0;
    dut.nreset_i.value = 1;
    dut.compute_enable.value = 1;
    dut.compare_zero.value = 0;

    dut._log.info("next_state is %s: ", dut.next_state.value)
    dut._log.info("state_o is %s: ", dut.state_o.value)

    await Timer(3, units="ns")
    
    #se coloca en decimal el valor
    dut.gcd_enable.value = 0;
    dut.nreset_i.value = 1;
    dut.compute_enable.value = 0;
    dut.compare_zero.value = 1;

    dut._log.info("next_state is %s: ", dut.next_state.value)
    dut._log.info("state_o is %s: ", dut.state_o.value)

    await Timer(3, units="ns")

    #se coloca en decimal el valor
    dut.gcd_enable.value = 0;
    dut.nreset_i.value = 1;
    dut.compute_enable.value = 1;
    dut.compare_zero.value = 0;

    dut._log.info("next_state is %s: ", dut.next_state.value)
    dut._log.info("state_o is %s: ", dut.state_o.value)

    await Timer(3, units="ns")


    #se coloca en decimal el valor
    dut.gcd_enable.value = 1;
    dut.nreset_i.value = 0;
    dut.compute_enable.value = 0;
    dut.compare_zero.value = 1;

    dut._log.info("next_state is %s: ", dut.next_state.value)
    dut._log.info("state_o is %s: ", dut.state_o.value)

    await Timer(3, units="ns")

