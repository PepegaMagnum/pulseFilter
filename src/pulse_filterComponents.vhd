

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pulseFilterTypes.all;

package pulse_filterComponents is


    component pulseCyclesCounter
    generic(
        integerMinimumCyclesCount       : integer
    );
    port(
        i_data                          : in std_logic;
        transmission                    : in std_logic;
        clk                             : in std_logic;
        pulseDetected                   : out std_logic;
        pulseCounter                    : out integer
        );
    
    end component;
    
    component filterController
    Port (
        clk                             : in std_logic;
        pulseDetected                   : in std_logic;
        transmission                    : out std_logic;
        transmissionCompleted           : in std_logic 
    );
    end component;
    
    component pulseTransmitter
    Port (
        clk                             : in std_logic; 
        pulseDetected                   : in std_logic;
        pulseCounter                    : in integer;
        transmission                    : in std_logic;
        transmissionCompleted           : out std_logic;
        o_data                          : out std_logic
    );
    end component;
    
end pulse_filterComponents;
