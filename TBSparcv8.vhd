LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TBSparcv8 IS
END TBSparcv8;
 
ARCHITECTURE behavior OF TBSparcv8 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sparcv8Monocicle
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         R : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal R : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sparcv8Monocicle PORT MAP (
          CLK => CLK,
          RST => RST,
          R => R
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
		CLK<='1';
		RST<='0';
      wait for 100 ns;
      CLK<='0';
		RST<='0';
      wait for 100 ns;
		CLK<='1';
		RST<='0';
      wait for 100 ns;
		CLK<='0';
		RST<='0';
      wait for 100 ns;
		CLK<='1';
		RST<='0';
      wait for 100 ns;
		CLK<='0';
		RST<='0';
      wait for 100 ns;
		CLK<='1';
		RST<='0';
      wait for 100 ns;


      -- insert stimulus here 

      wait;
   end process;

END;
