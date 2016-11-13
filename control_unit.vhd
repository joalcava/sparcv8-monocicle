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
					when "000000"=> --ADD
						awop<="000000";
					when "000100"=> --SUB
						awop<="000001";
					when "000010"=> --OR
						awop<="000010";
					when "000001"=> --AND
						awop<="000011";
					when "000011"=> --XOR
						awop<="000100";
					when "000110"=> --ORN
						awop<="000101";
					when "000101"=> --ANDN
						awop<="000110";
					when "000111"=> --XNOR
						awop<="000111";					
					when "010000"=> --ADDcc
						awop<="001000";
					when "010100"=> --SUBcc
						awop<="001001";
					when "001000"=> --ADDX
						awop<="001010";
					when "011000"=> --ADDXcc
						awop<="001011";
					when "001100"=> --SUBX
						awop<="001100";
					when "011100"=> --SUBXcc
						awop<="001101";
					when "010010"=> --ORcc
						awop<="001110";
					when "010001"=> --ANDcc
						awop<="001111";
					when "010011"=> --XORcc
						awop<="010000";
					when "010101"=> --ANDNcc
						awop<="010001";
					when "010110"=> --ORNcc
						awop<="010010";
					when "010111"=> --XNORcc
						awop<="010011";
					when "100101"=> --SLL
						awop<="010100";
					when "100110"=> --SRL
						awop<="010101";				
					when others=>
						awop<="000000";
		end case;
	end process;	

end ArqUC;

