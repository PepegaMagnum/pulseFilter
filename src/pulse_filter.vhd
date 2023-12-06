library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pulse_filterComponents.all;

-- A pulse filter that lets through signals that have a pulse width greater than G_T. The frequency of sampling is
-- defined by G_CLK. 
-- The filter module uses two counters, one to determine if the signal has an appropiate width, a second one to
-- transmit the signal.

entity pulse_filter is
  generic (
    G_CLK    : time := 20  ns;         -- input clock freq 
    G_T      : time := 5   us          -- pulse time
  );
  port (
    clk      : in  std_logic;          -- main clock signal
    i_data   : in  std_logic;          -- input signal to be filtered
    o_data   : out std_logic           -- filtered i_data signal
  );
end entity pulse_filter;

architecture pulse_filter_rtl of pulse_filter is

-- Constants 

constant integerMinimumCyclesCount      : integer := G_T/G_CLK; -- a constant determining the minimum amount of clock cycles

-- Internal signals connecting all components

signal counterPulseDetectedSignal       : std_logic;
signal pulseCounter                     : integer;
signal transmissionSignal               : std_logic;
signal transmissionCompletedSignal      : std_logic;

begin
    pcc1: pulseCyclesCounter 
    generic map(
        integerMinimumCyclesCount => integerMinimumCyclesCount
    )
    port map (
        i_data => i_data,
        transmission => transmissionSignal,
        clk => clk,
        pulseDetected => counterPulseDetectedSignal,
        pulseCounter => pulseCounter
    );
    
    fc1: filterController port map(
        clk => clk,
        pulseDetected => counterPulseDetectedSignal,
        transmission => transmissionSignal,
        transmissionCompleted => transmissionCompletedSignal
    
    );
    
    pt1: pulseTransmitter port map(
        clk => clk,
        transmission => transmissionSignal,
        pulseDetected => counterPulseDetectedSignal,
        pulseCounter => pulseCounter,
        transmissionCompleted => transmissionCompletedSignal,
        o_data => o_data
    );

end architecture;