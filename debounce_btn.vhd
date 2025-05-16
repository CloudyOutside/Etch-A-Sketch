----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2025 03:31:12 PM
-- Design Name: 
-- Module Name: debounce - Behavioral
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

entity debounce_btn is
  Port (
  CLK: in std_logic;
  BTN: in std_logic;
  DBNC : out std_logic
   );
end debounce_btn;

architecture Behavioral of debounce_btn is
signal counter : std_logic_vector(22 downto 0) := (others => '0');
signal shiftreg : std_logic_vector(1 downto 0) := (others => '0');
begin
process(CLK)
    begin
 
        if rising_edge(CLK) then
            shiftreg(1) <= shiftreg(0);  
            shiftreg(0) <= BTN;     
                if (unsigned(counter) > 2499999 and shiftreg(1) = '1') then
                    DBNC <= '1';
                elsif(shiftreg(1) = '1') then
                    counter <= std_logic_vector(unsigned(counter) + 1);
                else
                    counter <= (others => '0');
                    DBNC <= '0';
                end if;
            
            end if;
                
    end process;
    

end Behavioral;