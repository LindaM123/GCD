import os
import logging
import random
import math
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge
from cocotb.triggers import RisingEdge
from cocotb_test.simulator import run
import pytest

class TB:
    def __init__(self, dut, clock_period_ns=20):
        self.dut = dut

        # self.log = logging.getLogger("cocotb.tb") por ahora no miremos esto
        # self.log.setLevel(logging.DEBUG)

        cocotb.start_soon(Clock(dut.clk_i, clock_period_ns, units="ns").start())

    async def reset(self) -> None:
        """
        Reset DUT
        """
        self.dut.reset_i.value = 0 #Cambia esto con los nombres de tu proyecto
        await FallingEdge(self.dut.clk_i)
        await FallingEdge(self.dut.clk_i)
        self.dut.reset_i.value = 1
        await RisingEdge(self.dut.clk_i)


@cocotb.test()
async def uart_reset_test(dut):
    """
    Reset DUT and check if internal registers were reset correctly
    """

    tb = TB(dut, 20)

    await tb.reset() # Aqui esperas que pase la funcion reset que definiste arriba

    # check if registers were reset
    # assert(dut.rx_busy.value == 0) Ejemplo de como hacer check de un valor


@cocotb.test()
async def uart_clock_divider_test(dut):
    """
    Tries random clock divider settings > 0 and checks enable16 signal gets
    asserted correctly.
    """

    tb = TB(dut, 20)

    await tb.reset()

    for i in range(5):
        # div = random.randint(1, math.pow(2, dut.uart_div_constant.value.n_bits) - 1) Esto te puede ayudar a genrear numero aleateroreos

        #tb.log.info(f"Setting DUT clock divider to {div}")
        #dut.uart_div_constant.setimmediatevalue(div) Ejemplo de como porner el valor en la entrada
"""
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
    dut.nreset_i.value = 1;
    dut.operand_a_i.value = 2;
    dut.operand_b_i.value = 1;

    await Timer(5, units="ns")  # wait a bit
    await FallingEdge(dut.clk_i)  # wait for falling edge/"negedge"
    dut._log.info("state is %s", dut.state.value)
    dut._log.info("nreset_i is %s", dut.nreset_i.value)
    dut._log.info("variables a and b are %s", dut.gcd_inputs.value)
    dut._log.info("gcd_o is %s", dut.gcd_o.value)
"""

