library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- The transmitter component is responsible for transmitting the signal. Based on the pulseCounter input provided by pulseCyclecCounter
-- the transmitter knows how many clock cycles of the signal must be transmitted to replicate the input signal i_data. 
-- After being provided the amount of clock cycles it has to transmit, the module counts down to 0. When the counter reaches 0,
-- the transmission is finished and the transmitter sends a finish signal to the controller.

entity pulseTransmitter is
Port (
    clk                             : in std_logic;
    pulseDetected                   : in std_logic;
    pulseCounter                    : in integer;
    transmission                    : in std_logic;
    transmissionCompleted           : out std_logic;
    o_data                          : out std_logic

);
end pulseTransmitter;

architecture rtl of pulseTransmitter is

-- Registers
signal pulseCounter_reg             : integer;
signal tranmissionCompleted_reg     : std_logic;
signal o_data_reg                   : std_logic;

begin
process(clk)
begin
    
    if rising_edge(clk) then
        if pulseDetected = '1' then
            if transmission = '0' then
                pulseCounter_reg <= pulseCounter;           -- this condition must be set, because the 
                                                            -- counter resets itself after encountering a zero on input.
            end if;
        else
            if transmission = '1' then
                pulseCounter_reg <= pulseCounter_reg - 1;
            end if;
        end if;
        
    end if;

    if pulseCounter_reg > 0 then
        if transmission = '1' then
            o_data_reg <= '1';
        end if;
    elsif pulseCounter_reg = 0 then
        o_data_reg <= '0';
        tranmissionCompleted_reg <= '1';
    else
        o_data_reg <= '0';
        tranmissionCompleted_reg <= '0';
    end if;    
    
    if rising_edge(clk) then
        transmissionCompleted <= tranmissionCompleted_reg;
        o_data <= o_data_reg;
    end if;

end process;

end rtl;
