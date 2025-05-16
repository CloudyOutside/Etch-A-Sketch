----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2025 07:25:20 PM
-- Design Name: 
-- Module Name: image_top - Structural
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity image_top is
  Port ( 
    clk : in std_logic;
    pmodX, pmodY : in std_logic_vector(3 downto 0);
    vga_hs, vga_vs : out std_logic;
    vga_r, vga_b : out std_logic_vector(4 downto 0);
    vga_g : out std_logic_vector(5 downto 0)
  );
end image_top;

architecture Structural of image_top is
component clock_div is
  Port (
  CLK : in std_logic;
  OUTPUT : out std_logic
   );
end component;
component drawing is
  PORT (
  clk : in std_logic;
  pmodX : in std_logic_vector (3 downto 0);
  pmodY : in std_logic_vector (3 downto 0);  
  addr : in std_logic_vector(19 downto 0);
  dout : out std_logic_vector(7 downto 0)
  );
end component;
component pixel_pusher
  Port (
    clk, en, vs, vid: in std_logic;
    pixel : in std_logic_vector(7 downto 0);
--    pmodX : in std_logic_vector (3 downto 0);
--    pmodY : in std_logic_vector (3 downto 0);
    addr : out std_logic_vector(19 downto 0);
    hcount, vcount : in std_logic_vector(9 downto 0);
    R, B : out std_logic_vector(4 downto 0);
    G : out std_logic_vector(5 downto 0)
   );
end component;
component vga_ctrl is
  Port (
    clk, en : in std_logic;
    hcount, vcount : out std_logic_vector(9 downto 0);
    vid, hs, vs : out std_logic
   );
end component;
signal u1_out : std_logic;
signal u2_out : std_logic_vector(7 downto 0);
signal u3_out : std_logic_vector(19 downto 0);
signal u4_out_hcount, u4_out_vcount : std_logic_vector(9 downto 0);
signal u4_out_vid : std_logic;
signal u4_out_vs: std_logic;
begin
u1 : clock_div
port map(
clk => clk,
output => u1_out
);
u2 : drawing
port map(
clk => clk,
pmodX =>pmodX,
pmodY =>pmodY,
addr => u3_out,
dout => u2_out
);
u3 : pixel_pusher
port map(
clk => clk,
en => u1_out,
pixel => u2_out,
vid => u4_out_vid,
--pmodX => pmodX,
--pmodY => pmodY,
hcount => u4_out_hcount,
vcount => u4_out_vcount,
addr => u3_out,
vs => u4_out_vs,
R => vga_r,
B => vga_b,
G =>vga_g
);
u4 : vga_ctrl
port map(
clk => clk,
en => u1_out,
hcount => u4_out_hcount,
vcount => u4_out_vcount,
vid => u4_out_vid,
vs => u4_out_vs,
hs => vga_hs
);
vga_vs <= u4_out_vs;
end Structural;