library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sparcv8Monocicle is 
Port ( CLK : in  STD_LOGIC;
RST: in STD_LOGIC;
R : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end Sparcv8Monocicle;

architecture Behavioral of Sparcv8Monocicle is

---Componentes

COMPONENT sum32b
	PORT(
		Op1 : IN std_logic_vector(31 downto 0);
		Op2 : IN std_logic_vector(31 downto 0);          
		R : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT alu
	PORT(
		aluop : IN std_logic_vector(5 downto 0);
		crs1 : IN std_logic_vector(31 downto 0);
		crs2 : IN std_logic_vector(31 downto 0);          
		r : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT UC
	PORT(
		op3 : IN std_logic_vector(5 downto 0);
		op : IN std_logic_vector(1 downto 0);          
		awop : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
COMPONENT instructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT mux32b
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		Sel : IN std_logic;          
		O : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT pc
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		address : IN std_logic_vector(31 downto 0);          
		sig : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
COMPONENT register_file
	PORT(
		rst : IN std_logic;
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		data : IN std_logic_vector(31 downto 0);          
		crs1 : OUT std_logic_vector(31 downto 0);
		crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT sign_ext_unit
	PORT(
		entrada : IN std_logic_vector(12 downto 0);          
		salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
signal aux1,aux2,aux3,aux4,aux6,aux7,aux8,aux9,aux10,aux11:std_logic_vector(31 downto 0);
signal aux5:std_logic_vector(5 downto 0);
begin

---Instancia de los componentes

	Inst_sum32b: sum32b PORT MAP(
		Op1 => x"00000001",
		Op2 => aux1,
		R => aux2 
	);
	
	Inst_alu: alu PORT MAP(
		aluop => aux5,
		crs1 => aux6,
		crs2 => aux9,
		r => aux10
	);
	
	Inst_UC: UC PORT MAP(
		op3 => aux4(24 downto 19),
		op => aux4(31 downto 30),
		awop => aux5
	);
	
	Inst_instructionMemory: instructionMemory PORT MAP(
		address => aux3,
		reset => RST,
		outInstruction => aux4 
	);
	
	Inst_mux32b: mux32b PORT MAP(
		A => aux7,
		B => aux11,
		Sel => aux4(13),
		O => aux9
	);
	
	Inst_pc: pc PORT MAP(
		clk => CLK,
		rst => RST,
		address => aux1,
		sig => aux3
	);
	
	Inst_npc: pc PORT MAP(
		clk => CLK,
		rst => RST,
		address => aux2,
		sig => aux1
	);
	
	Inst_register_file: register_file PORT MAP(
		rst => RST,
		rs1 => aux4(18 downto 14),
		rs2 => aux4(4 downto 0),
		rd => aux4(29 downto 25),
		data => aux10,
		crs1 => aux6,
		crs2 => aux7
	);
	
	Inst_sign_ext_unit: sign_ext_unit PORT MAP(
		entrada => aux4(12 downto 0),
		salida => aux11
	);

	R<=aux10;

end Behavioral;


