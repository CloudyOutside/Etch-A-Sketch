----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2025 06:17:17 PM
-- Design Name: 
-- Module Name: drawing - Behavioral
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

entity drawing is
  Port (
  clk : in std_logic;
  pmodX : in std_logic_vector (3 downto 0);
  pmodY : in std_logic_vector (3 downto 0);
  addr : in std_logic_vector(19 downto 0);
  dout : out std_logic_vector(7 downto 0)
   );
end drawing;

architecture Behavioral of drawing is
component encoder_top is
port (
		clk: in std_logic;
        pmodX, pmodY : in std_logic_vector (3 downto 0);
		posX, posY: out std_logic_vector (9 downto 0);
		color : out std_logic_vector(7 downto 0);
		reset_btn : out std_logic
);
end component;

type pixel_row is array (0 to 307199) of std_logic_vector(7 downto 0); -- for 8-bit values
signal screen_buffer : pixel_row := (others => "11111111");
signal positionX, positionY : std_logic_vector(9 downto 0);
signal color : std_logic_vector(7 downto 0);
signal arrayPos : std_logic_vector(19 downto 0);
signal btn : std_logic;
signal reset_flag: std_logic;
signal counter : std_logic_vector(19 downto 0);
begin

u2 : encoder_top 
port map(
clk => clk,
pmodx => pmodX,
pmodY => pmodY,
posX => positionX,
posY => positionY,
color => color,
reset_btn => btn
);


process(clk)
begin
if rising_edge(clk)then
if btn = '1' then
  reset_flag <= '1'; 
end if;

if reset_flag = '1' then
  screen_buffer(to_integer(unsigned(addr))) <= "11111111";
  counter <= std_logic_vector(unsigned(counter) + 1);
  if unsigned(counter) = 307200 then
  reset_flag <= '0';
  counter <= (others => '0');
  end if;
else
arrayPos <= std_logic_vector(unsigned(positionY) * 640 + unsigned(positionX));
screen_buffer(to_integer(unsigned(arrayPos)))<= color;
end if;
dout <= screen_buffer(to_integer(unsigned(addr)));
end if;
end process;
end Behavioral;
