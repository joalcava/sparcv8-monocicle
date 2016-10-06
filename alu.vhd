----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:15:33 10/04/2016 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu is
	Port( aluop : in  STD_LOGIC_VECTOR (5  downto 0);
			crs1   : in  STD_LOGIC_VECTOR (31 downto 0); 
			crs2   : in  STD_LOGIC_VECTOR (31 downto 0);
			r     : out STD_LOGIC_VECTOR (31 downto 0)
	);
end alu;

architecture ArqAlu of alu is

begin
	
	process(aluop, crs1, crs2)
	begin
		case (aluop) is
			when "000000" => r <= crs1 + crs2;
			when "000001" => r <= crs1 - crs2;
			when "000010" => r <= crs1 or crs2;
			when "000011" => r <= crs1 and crs2;
			when "000100" => r <= crs1 xor crs2;
			when "000101" => r <= crs1 or not(crs2);
			when "000110" => r <= crs1 and not(crs2);
			when "000111" => r <= crs1 xnor crs2;
			when others => r <= x"00000000";
		end case;
	end process;

end ArqAlu;

