----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2025 03:28:43 PM
-- Design Name: 
-- Module Name: encoder_top - Behavioral
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

entity encoder_top is
  Port (
		clk: in std_logic;
        pmodX, pmodY : in std_logic_vector (3 downto 0);
		posX, posY : out std_logic_vector (9 downto 0);
		color : out std_logic_vector (7 downto 0);
		reset_btn : out std_logic
     );
end encoder_top;

architecture Behavioral of encoder_top is

component debounce_btn port 
(
  CLK: in std_logic;
  BTN: in std_logic;
  DBNC : out std_logic
);
end component;
component debounce_encoder port 
(
  CLK: in std_logic;
  BTN: in std_logic;
  DBNC : out std_logic
);
end component;
component encoder_ctrlX port 
(
    clk: in std_logic;
    A : in  std_logic;	
    B : in  std_logic;
    BTN : in  std_logic;
    POSX : out std_logic_vector(9 downto 0)
);
end component;
component encoder_ctrlY port 
(
    clk: in std_logic;
    A : in  std_logic;	
    B : in  std_logic;
    BTN : in  std_logic;
    POSY : out std_logic_vector(9 downto 0)
);
end component;

signal A_outX, B_outX, btn_outX: std_logic;
signal A_outY, B_outY, btn_outY: std_logic;

type color_array is array (0 to 3) of std_logic_vector(7 downto 0);
signal colors : color_array := (
    0 => "11100000", -- Red (typical 3-3-2 format: RRR GGG BB)
    1 => "00011100", -- Green
    2 => "00000011", -- Blue
    3 => "00000000"  -- Black
);
signal counter : std_logic_vector(1 downto 0);
begin
u1: debounce_encoder port map(
clk =>clk,
btn => pmodX(0),
dbnc => A_outX
);
u2: debounce_encoder port map(
clk =>clk,
btn => pmodX(1),
dbnc => B_outX
);
u3: debounce_btn port map(
clk =>clk,
btn => pmodX(2),
dbnc => btn_outX
);
u4: encoder_ctrlX port map(
clk => clk,
A => A_outX,
B => B_outX,
BTN =>btn_outX,
POSX  => posX
);
u5: debounce_encoder port map(
clk =>clk,
btn => pmodY(0),
dbnc => A_outY
);
u6: debounce_encoder port map(
clk =>clk,
btn => pmodY(1),
dbnc => B_outY
);
u7: debounce_btn port map(
clk =>clk,
btn => pmodY(2),
dbnc => btn_outY
);
u8: encoder_ctrlY port map(
clk => clk,
A => A_outY,
B => B_outY,
BTN =>btn_outY,
POSY  => posY
);
reset_btn <= btn_outY;
process(clk)
begin
if rising_edge(clk)then
    if btn_outX = '1' then 
        if counter = "11" then
            counter <= "00";
        else
            counter <= std_logic_vector(unsigned(counter) +1);
        end if;
        color <= colors(to_integer(unsigned(counter)));
    end if;
end if;
end process;

end Behavioral;
