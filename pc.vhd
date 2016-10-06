library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc is
	PORT( clk : in STD_LOGIC;
			rst : in STD_LOGIC;
			address : in STD_LOGIC_VECTOR (31 downto 0);
			sig : out STD_LOGIC_VECTOR (31 downto 0)
	);
end pc;

architecture ArqPC of pc is

begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if (rst = '1') then
				sig <= x"00000000";
			else
					sig <= address;
			end if;
		end if;
	end process;
		


end ArqPC;

