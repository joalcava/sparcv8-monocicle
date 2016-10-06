library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC is
    Port ( op3 : in  STD_LOGIC_VECTOR(5 downto 0);
           op : in  STD_LOGIC_VECTOR(1 downto 0);
           awop : out  STD_LOGIC_VECTOR(5 downto 0)
			  );
end UC;

architecture ArqUC of UC is



begin 
	process(op3)
		begin
		case (op3) is
					when "000000"=>
						awop<="000000";
					when "000100"=>
						awop<="000001";
					when "000010"=>
						awop<="000010";
					when "000001"=>
						awop<="000011";
					when "000011"=>
						awop<="000100";
					when "000110"=>
						awop<="000101";
					when "000101"=>
						awop<="000110";
					when "000111"=>
						awop<="000111";
					when others=>
						awop<="000000";
		end case;
	end process;	

end ArqUC;

