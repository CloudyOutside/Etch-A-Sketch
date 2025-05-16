----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 01:21:54 AM
-- Design Name: 
-- Module Name: encoder_ctrl_tb - Behavioral
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

entity encoder_ctrl_tb is
end encoder_ctrl_tb;

architecture testbench of encoder_ctrl_tb is
signal tb_clk : std_logic := '0';
signal tb_A : std_logic := '1';
signal tb_B : std_logic := '1';
signal tb_BTN : std_logic := '0';
signal position : std_logic_vector(9 downto 0);


component encoder_ctrl is
port(
        clk: in std_logic;
        A : in  std_logic;	
        B : in  std_logic;
        BTN : in  std_logic;
        POS : out std_logic_vector(9 downto 0)
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

    enc_proc: process
    begin

        wait for 1 ms;
        tb_A <= '0';
        
        wait for 1 ms;
        tb_B <= '0';
        
        wait for 1 ms;
        tb_A <= '1';
        
        wait for 1 ms;
        tb_B <= '1';
        
    end process enc_proc;
    
    dut : encoder_ctrl
    port map (
    clk => tb_clk,
    A => tb_A,
    B => tb_B,
    BTN => tb_BTN,
    POS => position
    );
end testbench;
