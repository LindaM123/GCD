# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

# test_my_design.py (extended)

import cocotb
from cocotb.triggers import FallingEdge, Timer, RisingEdge
from random import randint
from math import pow

async def generate_clock(dut):
    for cycle in range(800):
        dut.clk_i.value = 0
        await Timer(1, units="ns")
        dut.clk_i.value = 1
        await Timer(1, units="ns")


@cocotb.test()
async def my_second_test(dut):
    #Try accessing the design.

    await cocotb.start(generate_clock(dut))  # run the clock "in the background"
    #se coloca en decimal el valor
    opa = randint(1,255);
    opb = randint(1,255);

    dut.operand_a_i.value = opa;
    dut.operand_b_i.value = opb;

    dut.gcd_enable_i.value = 1;
    dut.nreset_i.value = 0;

    await Timer(5, units="ns")  # wait a bit
    await RisingEdge(dut.clk_i)  # wait for falling edge/"negedge"
    
    dut.nreset_i.value = 1;

    dut._log.info("nreset_i is %s: ", dut.nreset_i.value)
    dut._log.info("operand_a %s: ", dut.operand_a_i.value)
    dut._log.info("operand_b %s: ", dut.operand_b_i.value)
    

    while dut.gcd_done_o.value == 0 :
    #for algo in range(100):
        #if(FallingEdge(dut.clk_i)):
        await RisingEdge(dut.clk_i)  # wait for falling edge/"negedge"
        dut._log.info("gcd_o  %s: ", dut.gcd_o.value)
        dut._log.info("gcd_done_o %s: ", dut.gcd_done_o.value)
        dut._log.info("gcd_inputs %s: ", dut.dp1.gcd_inputs.value)
        dut._log.info("SUB %s: ", dut.dp1.sub.value)
        #dut._log.info("sub2 %s: ", dut.dp1.sub2.value)
    await RisingEdge(dut.clk_i)  # wait for falling edge/"negedge"
    dut._log.info("gcd_o  %s: ", dut.gcd_o.value)
    dut._log.info("gcd_done_o %s: ", dut.gcd_done_o.value)
    dut._log.info("gcd_inputs %s: ", dut.dp1.gcd_inputs.value)
        #await Timer(1, units="ns")

