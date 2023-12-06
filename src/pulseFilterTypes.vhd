library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pulseFilterTypes is
    type State_Type is ( 
                    PulseCounting, 
                    PulseWidthDetected,
                    TransmitPulse
                    );
end pulseFilterTypes;