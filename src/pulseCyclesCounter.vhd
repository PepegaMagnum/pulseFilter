library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.pulseFilterTypes.all;

-- PulseCycleCounter is a component of the filter that determins if the signals lasts long enough to be let throught the filter.
-- It does so by counting up the input signals duration in clock cycles and comparing it to integerMinumCyclesCount.
-- After determining the signal has been up for a sufficient amount of clock cycles, the counter sends a signal to the controller.
-- Then it sends the pulseCounter value to the pulseTransmitter.


entity pulseCyclesCounter is
generic(
        integerMinimumCyclesCount : integer
    );
Port ( 
    
    i_data                      : in std_logic;     -- signal input
    transmission                : in std_logic;     -- transmission signal
    clk                         : in std_logic;     -- module clock
    pulseDetected               : out std_logic;    -- signal output that is used to inform the controller
    pulseCounter                : out integer       -- clock cycles counter
);
end pulseCyclesCounter;

architecture rtl of pulseCyclesCounter is

-- Registers
signal i_data_reg               : std_logic;        
signal pulseCounter_reg         : integer;          
signal pulseDetected_reg        : std_logic;        

begin

process (clk)
begin
    if rising_edge(clk) then    
        i_data_reg <= i_data;
        if i_data_reg = '1' then
            pulseCounter_reg <= pulseCounter_reg + 1;
        else
            pulseCounter_reg <= 0;   
        end if;
    end if;
    
    
    if pulseCounter_reg <= integerMinimumCyclesCount then
        pulseDetected_reg <= '0';
    else
        if transmission = '0' then 
            pulseDetected_reg <= '1';               -- When a transmission is occuring the counter doesn't send the pulseDetected signal.
        end if;
    end if;
    
    
    if rising_edge(clk) then
        pulseDetected <= pulseDetected_reg;
        pulseCounter <= pulseCounter_reg;
    end if;
    
end process;



end rtl;
