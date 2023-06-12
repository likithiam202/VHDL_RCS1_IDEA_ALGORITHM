----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Likith Shivakumar Gowda
-- 
-- Create Date:    09:58:40 05/12/2023 
-- Design Name: 
-- Module Name:    round - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Design for each round transformation
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

entity round is
    Port ( X1 : in  STD_LOGIC_VECTOR (15 downto 0);
           X2 : in  STD_LOGIC_VECTOR (15 downto 0);
           X3 : in  STD_LOGIC_VECTOR (15 downto 0);
           X4 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z1 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z2 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z3 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z4 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z5 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z6 : in  STD_LOGIC_VECTOR (15 downto 0);
           Y1 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y2 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y3 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y4 : out  STD_LOGIC_VECTOR (15 downto 0));
end round;

architecture Behavioral of round is

-- Component declaration is outside the begin in architecture block
component xorop is
    Port ( I1 : in  STD_LOGIC_VECTOR (15 downto 0);
           I2 : in  STD_LOGIC_VECTOR (15 downto 0);
           O : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component addop is
    Port ( I1 : in  STD_LOGIC_VECTOR (15 downto 0);
           I2 : in  STD_LOGIC_VECTOR (15 downto 0);
           O : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component mulop is
    Port ( I_1 : in  STD_LOGIC_VECTOR (15 downto 0);
           I_2 : in  STD_LOGIC_VECTOR (15 downto 0);
           O_1 : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

signal xor_1, xor_2, mul_1, mul_2, mul_3, mul_4, add_1, add_2, add_3, add_4: STD_LOGIC_VECTOR (15 downto 0);
begin

-- LHS is signal of the already created module, RHS is the signal from the round module

-- layer 1
mulop_inst1 : mulop
	port map (
		I_1 => X1,
		I_2 => Z1,
		O_1 => mul_1
	);
	
addop_inst1: addop
	port map (
		I1 => X2,
		I2 => Z2,
		O => add_1
	);

addop_inst2: addop
	port map (
		I1 => X3,
		I2 => Z3,
		O => add_2
	);
	
mulop_inst2: mulop
	port map (
		I_1 => X4,
		I_2 => Z4,
		O_1 => mul_2
	);
	

-- layer 2
xorop_inst1: xorop
	port map (
		I1 => mul_1,
		I2 => add_2,
		O => xor_1
	);
	
-- layer 3
xorop_inst2: xorop
	port map (
		I1 => add_1,
		I2 => mul_2,
		O => xor_2
	);
	
-- layer 4
mulop_inst3: mulop
	port map (
		I_1 => xor_1,
		I_2 => Z5,
		O_1 => mul_3
	);
	
addop_inst3: addop
	port map(
		I1 => mul_3,
		I2 => xor_2,
		O => add_3
	);
	
-- layer 5

mulop_inst4: mulop
	port map (
		I_1 => add_3,
		I_2 => Z6,
		O_1 => mul_4
	);
	
addop_inst4: addop
	port map(
		I1 => mul_3,
		I2 => mul_4,
		O => add_4
		);
		
-- layer 6
xorop_inst3: xorop
	port map(
		I1 => mul_1,
		I2 => mul_4,
		O => Y1
	);

xorop_inst4: xorop
	port map (
		I1 => add_2,
		I2 => mul_4,
		O => Y2
	);
	
-- layer 7
xorop_inst5: xorop
	port map(
		I1 => add_1,
		I2 => add_4,
		O => Y3
	);
	
xorop_inst6: xorop
	port map (
		I1 => add_4,
		I2 => mul_2,
		O => Y4
	);
end Behavioral;
