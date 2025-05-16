
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2025 07:49:11 PM
-- Design Name: 
-- Module Name: clock_div - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_div is
  Port (
  CLK : in std_logic;
  OUTPUT : out std_logic
   );
end clock_div;

architecture Behavioral of clock_div is

signal counter : std_logic_vector(26 downto 0) := (others => '0');

begin

    process(clk)
    begin
    
        if rising_edge(clk) then
            
                -- count one full led period (1 Hz)
                
                if (unsigned(counter) < (4)) then
                    counter <= std_logic_vector(unsigned(counter) + 1);
                    
                else
                    counter <= (others => '0');
                    
                end if;
                
                -- turn the led on for half of the period (50% duty cycle)
                -- when sw0 is high
                
                if (unsigned(counter) < 1) then
                    OUTPUT <= '1';
                    
                else
                    OUTPUT <= '0';
                    
                end if;
            
            end if;
                
    end process;
    

end Behavioral;
