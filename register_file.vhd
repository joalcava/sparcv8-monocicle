library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register_file is
	Port( rs1  : in  STD_LOGIC_VECTOR (4  downto 0);
			rs2  : in  STD_LOGIC_VECTOR (4  downto 0);
			rd   : in  STD_LOGIC_VECTOR (4  downto 0);
			data : in  STD_LOGIC_VECTOR (31 downto 0);
			crs1 : out STD_LOGIC_VECTOR (31 downto 0);
			crs2 : out STD_LOGIC_VECTOR (31 downto 0)
			);
			
end register_file;

architecture ArqRegFile of register_file is

	type ram_type is array (0 to 31) of std_logic_vector (31 downto 0);
	signal reg : ram_type := (others => x"00000000");
	
begin

	crs1 <= reg(conv_integer(rs1 ));
	crs2 <= reg(conv_integer(rs2 ));
	reg(conv_integer(rd)) <= data;

end ArqRegFile;

