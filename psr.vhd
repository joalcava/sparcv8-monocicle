----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:25:06 10/20/2016 
-- Design Name: 
-- Module Name:    psr - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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


entity psr is
Port(
	clk   : in std_logic;
	reset : in std_logic;
	nzvc  : in  std_logic_vector(3 downto 0);
	carry : out std_logic
);
end psr;

architecture psrArq of psr is

signal PSRDATA : std_logic_vector (4 downto 0) := x"00000000";

begin

process(clk)
begin
	if (rising_edge(clk))then
		PSRDATA(3 downto 0) <= nzvc;
	end if;
end process;

end psrArq;

