----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2025 09:08:30 PM
-- Design Name: 
-- Module Name: vga_ctrl_tb - testbench
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

entity vga_ctrl_tb is
end vga_ctrl_tb;

architecture testbench of vga_ctrl_tb is


    signal tb_clk : std_logic := '0';
    signal tb_en : std_logic := '0';
    signal vid : std_logic;
    signal hs : std_logic;
    signal vs : std_logic;
    signal hcounter : std_logic_vector(9 downto 0);
    signal vcounter : std_logic_vector(9 downto 0);


    component vga_ctrl is
      Port (
        clk, en : in std_logic;
        hcount, vcount : out std_logic_vector(9 downto 0);
        vid, hs, vs : out std_logic
       );
    end component;

begin
    
    clk_gen_proc: process
    begin

        wait for 4 ns;
        tb_clk <= '1';
        
        wait for 4 ns;
        tb_clk <= '0';
        
    end process clk_gen_proc;
    
    en_gen_proc: process
    begin

        wait for 8 ns;
        tb_en <= '1';
        
        wait for 4 ns;
        tb_en <= '0';
        
    end process en_gen_proc;
    
    dut : vga_ctrl
    port map (
    clk => tb_clk,
    en => tb_en,
    hcount => hcounter,
    vcount => vcounter,
    vs => vs,
    hs => hs,
    vid => vid
    );
    
end testbench;
