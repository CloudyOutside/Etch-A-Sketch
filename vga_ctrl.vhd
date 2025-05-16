
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2025 08:21:07 PM
-- Design Name: 
-- Module Name: vga_ctrl - Behavioral
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

entity vga_ctrl is
  Port (
    clk, en : in std_logic;
    hcount, vcount : out std_logic_vector(9 downto 0);
    vid, hs, vs : out std_logic
   );
end vga_ctrl;

architecture Behavioral of vga_ctrl is

signal hcounter : std_logic_vector(9 downto 0) := (others => '0');
signal vcounter : std_logic_vector(9 downto 0) := (others => '0');

begin
process(clk)
begin
    if rising_edge(clk) then
        if en = '1' then
            if(unsigned(hcounter) < 799) then
                hcounter <= std_logic_vector(unsigned(hcounter)+1);
            else
                hcounter <= "0000000000";
                if unsigned(vcounter) < 524 then
                    vcounter <= std_logic_vector(unsigned(vcounter)+1);
                else
                    vcounter <= "0000000000";
                end if;
            end if;
            hcount <= hcounter;
            vcount <= vcounter;
            if(unsigned(hcounter) <= 639 and unsigned(vcounter) <= 479) then
                vid <= '1';
            else
                vid <= '0';
            end if;
            if(unsigned(hcounter) >= 656 and unsigned(hcounter) <= 751) then 
                hs <= '0';
            else
                hs <= '1';
            end if;
            if(unsigned(vcounter) >= 490 and unsigned(vcounter) <= 491) then
                vs <= '0';
            else
                vs <= '1';
            end if;
            
        end if;
    end if;
end process;

end Behavioral;
