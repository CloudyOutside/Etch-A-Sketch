
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2025 06:37:07 PM
-- Design Name: 
-- Module Name: pixel_pusher - Behavioral
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

entity pixel_pusher is
  Port (
    clk, en, vs, vid: in std_logic;
    pixel : in  std_logic_vector(7 downto 0);
--    pmodX : in std_logic_vector (3 downto 0);
--    pmodY : in std_logic_vector (3 downto 0);
    hcount, vcount : in std_logic_vector(9 downto 0);
    R, B : out std_logic_vector(4 downto 0);
    G : out std_logic_vector(5 downto 0);
    addr : out std_logic_vector(19 downto 0)
   );
end pixel_pusher;
architecture Behavioral of pixel_pusher is
--component encoder_topX is
--port (
--		clk: in std_logic;
--        pmodX : in std_logic_vector (3 downto 0);
--		posX: out std_logic_vector (8 downto 0)
--);
--end component;
--component encoder_topY is
--port (
--		clk: in std_logic;
--        pmodY : in std_logic_vector (3 downto 0);
--		posY: out std_logic_vector (8 downto 0)
--);
--end component;

signal address : std_logic_vector(19 downto 0) := (others => '0');
--signal positionX, positionY : std_logic_vector(8 downto 0);
begin
--u1 : encoder_topX 
--port map(
--clk => clk,
--pmodX => pmodX,
--posX => positionX
--);
--u2 : encoder_topY 
--port map(
--clk => clk,
--pmodY => pmodY,
--posY => positionY
--);



process(clk)
begin
if rising_edge(clk) then
        if vs = '0' then
            address <= "00000000000000000000";
        end if;
    if en = '1' then
        if vid = '1' and unsigned(hcount)<640 and unsigned(vcount) < 480 then
            address <= std_logic_vector(unsigned(address)+1);
            R <= pixel(7 downto 5) & "00";
            G <= pixel(4 downto 2) & "000";
            B <= pixel(1 downto 0) & "000";
            end if;
        end if;
    end if;
    if en = '0'or  vid = '0' or unsigned(hcount) >= 640 or unsigned(vcount) >= 480then
        R <= "00000";
        B <= "00000";
        G <= "000000";
        end if;
    addr <= address;        
end process;

end Behavioral;
