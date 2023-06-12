--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:19:58 06/07/2023
-- Design Name:   
-- Module Name:   /home/liks/vhdllab/submit/rcs1/tb_register16.vhd
-- Project Name:  idea_rcs1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: register16
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_register16 IS
END tb_register16;
 
ARCHITECTURE behavior OF tb_register16 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT register16
    PORT(
         Clock : IN  std_logic;
         ENABLE : IN  std_logic;
         D : IN  std_logic_vector(15 downto 0);
         Q : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal ENABLE : std_logic := '0';
   signal D : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Q : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant Clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: register16 PORT MAP (
          Clock => Clock,
          ENABLE => ENABLE,
          D => D,
          Q => Q
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		
		D <= x"0001";
		ENABLE <= '0';
		
		wait for 10ns;
		
		ENABLE <= '1';
	
      wait for Clock_period*10;
		
		D <= x"ABCD";
		ENABLE <= '0';
		
		wait for 10ns;
		
		ENABLE <= '1';
      -- insert stimulus here 

      wait;
   end process;

END;
