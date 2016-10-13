----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:28:06 10/13/2016 
-- Design Name: 
-- Module Name:    npc - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity npc is
	PORT( clk : in STD_LOGIC;
			rst : in STD_LOGIC;
			address : in STD_LOGIC_VECTOR (31 downto 0);
			sig : out STD_LOGIC_VECTOR (31 downto 0)
	);
end npc;

architecture arqnpc of npc is


begin
	process(clk, address,rst)
	begin
		if (rst = '0')then
		    sig <= (others => '0');
		else
			if(rising_edge(clk))then
				sig <= address;
			end if;
		end if;
	end process;

end arqnpc;

