library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sparcv8Monocicle is 
Port ( CLK : in  STD_LOGIC;
RST: in STD_LOGIC;
R : out  STD_LOGIC_VECTOR(31 downto 0);
NCWPCheck: out std_logic;
NZVCCheck: out std_logic_vector(3 downto 0)
			  );
end Sparcv8Monocicle;

architecture Behavioral of Sparcv8Monocicle is

---Componentes

COMPONENT windows_manager
	PORT(
		cwp : IN std_logic;
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		nrs1 : OUT std_logic_vector(5 downto 0);
		nrs2 : OUT std_logic_vector(5 downto 0);
		nrd : OUT std_logic_vector(5 downto 0);
		ncwp : OUT std_logic
		);
	END COMPONENT;

COMPONENT psr
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		nzvc : IN std_logic_vector(3 downto 0);
		ncwp : IN std_logic;
		carry : OUT std_logic;
		cwp : OUT std_logic
		);
	END COMPONENT;
	
COMPONENT psr_modifier
	PORT(
		crs1 : IN std_logic;
		ope2 : IN std_logic;
		alur : IN std_logic_vector(31 downto 0);
		aluop : IN std_logic_vector(5 downto 0);          
		nzvc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

COMPONENT sum32b
	PORT(
		Op1 : IN std_logic_vector(31 downto 0);
		Op2 : IN std_logic_vector(31 downto 0);          
		R : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT alu
	PORT(
		carry : IN std_logic;
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
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		rd : IN std_logic_vector(5 downto 0);
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
	
signal aux1,aux2,aux3,aux4,aux6,aux7,aux9,aux10,aux11:std_logic_vector(31 downto 0);
signal aux5,aux14,aux15,aux16:std_logic_vector(5 downto 0);
signal aux12,aux17,aux18:std_logic;
signal aux13:std_logic_vector(3 downto 0);
begin

---Instancia de los componentes

	Inst_windows_manager: windows_manager PORT MAP(
		cwp => aux18,
		rs1 => aux4(18 downto 14),
		rs2 => aux4(4 downto 0),
		rd => aux4(29 downto 25),
		op => aux4(31 downto 30),
		op3 => aux4(24 downto 19),
		nrs1 => aux14,
		nrs2 => aux15,
		nrd => aux16,
		ncwp => aux17
	);

	Inst_psr: psr PORT MAP(
		clk => CLK,
		reset => RST,
		nzvc => aux13,
		ncwp => aux17,
		carry => aux12,
		cwp => aux18
	);

	Inst_psr_modifier: psr_modifier PORT MAP(
		crs1 => aux6(31),
		ope2 => aux9(31),
		alur => aux10,
		aluop => aux5,
		nzvc => aux13
	);
	
	Inst_sum32b: sum32b PORT MAP(
		Op1 => x"00000001",
		Op2 => aux1,
		R => aux2 
	);
	
	Inst_alu: alu PORT MAP(
		carry => aux12,
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
		rs1 => aux14,
		rs2 => aux15,
		rd => aux16,
		data => aux10,
		crs1 => aux6,
		crs2 => aux7
	);
	
	Inst_sign_ext_unit: sign_ext_unit PORT MAP(
		entrada => aux4(12 downto 0),
		salida => aux11
	);

	NCWPCheck <= aux17;
	NZVCCheck <= aux13;
	R<=aux10;

end Behavioral;


