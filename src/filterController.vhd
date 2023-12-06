library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.pulseFilterTypes.all; -- a package containing the states of the FSM.

-- Filter Controller is a component of pulse_filter that controlls the dataflow of the whole module. 
-- It is implemented as a FSM with 3 states: PulseCounting, PulseWidthDetected, TransmitPulse
--
-- PulseCounting is a state in which the filter is reading the input until the pulse cycle counter doesn't signal the controller that
-- the read signal has an impulse with the width longer than G_T. 
--
-- PulseWidthDetected is a state in which the filter has detected a pulse with a width greater than G_T. The filter module remains in that
-- state depending if the pulse ends or not. When it ends it transistions into TransmitPulse state.
--
-- In the transmit pulse, the filter puts out the read signal that has been read and has a width greater than G_T. After finishing
-- the transmition of the signal, the module returns to the PulseCounting state.

entity filterController is
Port (
    clk                         : in std_logic;     -- module clock.
    pulseDetected               : in std_logic;     -- an input signal from pulseCyclesCounter signaling that it has read a signal with 
                                                    -- the appropiate length.
    
    transmission                : out std_logic;    -- an output signal signalling the pulseTransmitter to begin outputting the signal.
    transmissionCompleted       : in std_logic      -- an input signal from pulseTransmitter signalling that it has finished transmitting
                                                    -- the signal.
 );
end filterController;

architecture rtl of filterController is

signal currentState             : State_Type;
signal nextState                : State_Type;
signal transmission_reg         : std_logic;

begin

process(pulseDetected, transmissionCompleted)
begin
    case currentState is 
        when PulseCounting =>
            if pulseDetected = '1' then
                nextState <= PulseWidthDetected;
            else 
                nextState <= PulseCounting;
                transmission_reg <= '0';
            end if;
            
        when PulseWidthDetected =>
            if pulseDetected = '1' then
                nextState <= PulseWidthDetected;
            else
                nextState <= TransmitPulse;
                transmission_reg <= '1';
            end if;
            
        when TransmitPulse =>
            if transmissionCompleted = '0' then
                nextState <= TransmitPulse;
            else
                nextState <= PulseCounting;
                transmission_reg <= '1';
            end if;
        when others =>
            nextState <= PulseCounting;
    end case;    
end process;

-- FSM register

process(clk)
begin
    if rising_edge(clk) then
        currentState <= nextState;
    end if;
    
    
    if rising_edge(clk) then
        transmission <= transmission_reg;
    end if;
    
end process;

end rtl;
