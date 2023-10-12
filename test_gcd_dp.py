# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

# test_my_design.py (extended)

import cocotb
from cocotb.triggers import FallingEdge, Timer


async def generate_clock(dut):
    #Generate clock pulses.

    for cycle in range(25):
        dut.clk_i.value = 0
        await Timer(1, units="ns")
        dut.clk_i.value = 1
        await Timer(1, units="ns")


@cocotb.test()
async def my_second_test(dut):
    #Try accessing the design.

    await cocotb.start(generate_clock(dut))  # run the clock "in the background"
    #se coloca en decimal el valor
    dut.gcd_enable = 1;
    dut.nreset_i.value = 1;

    dut.operand_a_i.value = 3;
    dut.operand_b_i.value = 2;
    dut.state.value = 0;

    await Timer(5, units="ns")  # wait a bit
        

    await FallingEdge(dut.clk_i)  # wait for falling edge/"negedge"
    dut._log.info("nreset_i is %s: ", dut.nreset_i.value)
    dut._log.info("operand_a %s: ", dut.operand_a_i.value)
    dut._log.info("operand_b %s: ", dut.operand_b_i.value)

    dut._log.info("compute_enable %s: ", dut.compute_enable.value)
    dut._log.info("compare_zero %s: ", dut.compare_zero.value)
    dut._log.info("gcd_o %s: ", dut.gcd_o.value)    
        

    await Timer(4, units="ns")

    dut.gcd_enable = 0;
    dut.state.value = 1;

    await Timer(4, units="ns")

    dut.state.value = 2;

    await Timer(4, units="ns")

    



        