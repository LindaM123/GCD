# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

# test_my_design.py (extended)

import cocotb
from cocotb.triggers import FallingEdge, Timer


async def generate_clock(dut):
    #Generate clock pulses.

    for cycle in range(10):
        dut.clk_i.value = 0
        await Timer(1, units="ns")
        dut.clk_i.value = 1
        await Timer(1, units="ns")


@cocotb.test()
async def my_second_test(dut):
    #Try accessing the design.

    await cocotb.start(generate_clock(dut))  # run the clock "in the background"
    #se coloca en decimal el valor
    dut.operand_a_i.value = 3;
    dut.operand_b_i.value = 2;
    dut.nreset_i.value = 1;

    #await Timer(5, units="ns")  # wait a bit
    await FallingEdge(dut.clk_i)  # wait for falling edge/"negedge"
    


    dut._log.info("nreset_i is %s", dut.nreset_i.value)
    dut._log.info("variables a and b are %s", dut.operand_a_i.value)

    for algo in range(22):
        #if(FallingEdge(dut.clk_i)):
        dut._log.info("clk is %s", dut.clk_i.value)
        dut._log.info("state is %s", dut.state.value)    
        dut._log.info("next_state is %s", dut.next_state.value)   
        dut._log.info("variables a and b are %s", dut.gcd_inputs.value)
        dut._log.info("variables gcd_in_temp are %s", dut.gcd_in_temp.value)
        dut._log.info("gcd_o_temp is %s", dut.gcd_o_temp.value)
        dut._log.info("gcd_o is %s", dut.gcd_o.value)
        await Timer(0.5, units="ns")

