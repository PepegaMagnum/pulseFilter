library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.pulseFilterTypes.all;


entity t_pulse_filter is

end t_pulse_filter;

architecture TEST of t_pulse_filter is

component pulse_filter 
    port (
        clk      : in  std_logic;          
        reset    : in  std_logic;          
        i_data   : in  std_logic;         
        o_data   : out std_logic
        ); 

end component;

    constant G_CLK    : time := 5  ns;        
    constant G_T      : time := 10 us;
    
    signal clk : std_logic := '0'; 
    signal reset : std_logic := '0';
    signal i_data, o_data : std_logic;
begin
    UUT: entity work.pulse_filter(pulse_filter_rtl)
        generic map(
            G_CLK => G_CLK,
            G_T => G_T) 
        port map(
            clk => clk,
            i_data => i_data,
            o_data => o_data
            );
    
    clk <= not clk after G_CLK/2;    
    
    process
    
    procedure setInputPulseWidth(constant pulseWidth : time;
                                 constant leftDistance : time;
                                 constant rightDistance : time
                                 ) is
    begin
        wait for leftDistance;
        i_data <= '1';
        wait for pulseWidth;
        i_data <= '0';
        wait for rightDistance;
    
    end procedure;
    
    begin
        i_data <= '0';
        -- Pulse Width tests
        -- Setting pulse to be longer than G_T
        setInputPulseWidth(G_T + G_CLK , G_T, G_T);
        
        -- Setting pulse to be equal to G_T
   
        setInputPulseWidth(G_T, G_T, G_T);
        
        -- Setting pulse to be less than G_T
        setInputPulseWidth(G_T - G_CLK, G_T, G_T);
        
        wait for 1 us;
        
        -- Testing if changing i_data value between sampling ends pulse width 
        
        setInputPulseWidth(G_T - G_CLK, G_T, G_CLK/8);
        setInputPulseWidth(G_T - G_CLK, G_CLK/8, G_T - G_CLK/4); -- The such signal should be able to go through the filter because the change occured when the module wasn't sampling the signal.
        
        wait for 10 us;
    end process;

end ;