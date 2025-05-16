----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2025 03:29:00 PM
-- Design Name: 
-- Module Name: enconder_ctrl - Behavioral
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

entity encoder_ctrlY is
  Port ( 
        clk: in std_logic;
        A : in  std_logic;	
        B : in  std_logic;
        BTN : in  std_logic;
        POSY : out std_logic_vector(9 downto 0)
  );
end encoder_ctrlY;

architecture Behavioral of encoder_ctrlY is
    type stateType is ( idle, R1, R2, R3, L1, L2, L3, add, sub);
    signal curState: stateType;
    signal counter : std_logic_vector(9 downto 0) := (others => '0');
begin
process (clk)
begin
    if rising_edge(clk) then
        case curState is
            when idle =>
                if B = '0' then
                    curState <= R1;
                elsif A = '0' then
                    curState <= L1;
                end if;

            when R1 =>
                if B = '1' then
                    curState <= idle;
                elsif A = '0' then
                    curState <= R2;
                else
                    curState <= R1;
                end if;
            when R2 =>				
                if A ='1' then
                    curState <= R1;
                elsif B = '1' then
                    curState <= R3;
                else
                    curState <= R2;
               end if;
            when R3 =>
                if B ='0' then
                    curState <= R2;
                elsif A = '1' then
                    curState <= sub;
                else
                    curState <= R3;
                end if;
            when L1 =>
                if A ='1' then
                    curState <= idle;
                elsif B = '0' then
                    curState <= L2;
                else
                    curState <= L1;
                end if;
            --L2	
            when L2 =>
                if B ='1' then
                   curState <= L1;
                elsif A = '1' then
                    curState <= L3;
                else
                    curState <= L2;
                end if;
            --L3
            when L3 =>
                if A ='0' then
                    curState <= L2;
                elsif B = '1' then
                    curState <= add;
                else
                    curState <= L3;
                end if;
            when add =>
                if unsigned(counter) < 479 then
                    counter <= std_logic_vector(unsigned(counter) + 1);
                else
                    counter <= std_logic_vector(to_unsigned(479, 10));
                end if;
                curState <= idle;

            when sub =>
                if counter > "0000000000" then
                    counter <= std_logic_vector(unsigned(counter) - 1);
                else
                    counter <= "0000000000";
                end if;
                curState <= idle;
        end case;
    end if;
    POSY <= counter;
end process;


end Behavioral;
