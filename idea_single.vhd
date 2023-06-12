----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:     
-- Design Name: 
-- Module Name:    idea_single - Structural 
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

entity idea_single is
    Port ( CLOCK : in  STD_LOGIC;
           START : in  STD_LOGIC;
           KEY : in  STD_LOGIC_VECTOR (127 downto 0);
           X_1 : in  STD_LOGIC_VECTOR (15 downto 0);
           X_2 : in  STD_LOGIC_VECTOR (15 downto 0);
           X_3 : in  STD_LOGIC_VECTOR (15 downto 0);
           X_4 : in  STD_LOGIC_VECTOR (15 downto 0);
           Y_1 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y_2 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y_3 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y_4 : out  STD_LOGIC_VECTOR (15 downto 0);
           READY : out  STD_LOGIC);
end idea_single;

architecture Structural of idea_single is

	COMPONENT round
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
	end component;
	
	COMPONENT trafo
		    Port ( X1 : in  STD_LOGIC_VECTOR (15 downto 0);
           X2 : in  STD_LOGIC_VECTOR (15 downto 0);
           X3 : in  STD_LOGIC_VECTOR (15 downto 0);
           X4 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z1 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z2 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z3 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z4 : in  STD_LOGIC_VECTOR (15 downto 0);
           Y1 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y2 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y3 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y4 : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	COMPONENT register16
		    Port ( Clock : in  STD_LOGIC;
           ENABLE : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (15 downto 0);
           Q : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	COMPONENT mux2x1
		    Port ( S : in  STD_LOGIC;
           D0 : in  STD_LOGIC_VECTOR (15 downto 0);
           D1 : in  STD_LOGIC_VECTOR (15 downto 0);
           O : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	COMPONENT keygenerator
		    Port ( KEY : in  STD_LOGIC_VECTOR (127 downto 0);
           ROUND : in  STD_LOGIC_VECTOR (3 downto 0);
           KEY1 : out  STD_LOGIC_VECTOR (15 downto 0);
           KEY2 : out  STD_LOGIC_VECTOR (15 downto 0);
           KEY3 : out  STD_LOGIC_VECTOR (15 downto 0);
           KEY4 : out  STD_LOGIC_VECTOR (15 downto 0);
           KEY5 : out  STD_LOGIC_VECTOR (15 downto 0);
           KEY6 : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	COMPONENT control
	    Port ( CLK : in  STD_LOGIC;
           START : in  STD_LOGIC;
           ROUND : out  STD_LOGIC_VECTOR (3 downto 0);
           READY : out  STD_LOGIC;
           EN : out  STD_LOGIC;
           S : out  STD_LOGIC);
	end component;

	SIGNAL muxOUT1, muxOUT2, muxOUT3, muxOUT4: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL regIN1, regIN2, regIN3, regIN4: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL regOUT1, regOUT2, regOUT3, regOUT4: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL subKey1, subKEY2, subKey3, subKEY4, subKEY5, subKEY6: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL SEL, EN: STD_LOGIC;
	SIGNAL roundCounter: STD_LOGIC_VECTOR(3 DOWNTO 0);
begin
	
	mux1: mux2x1 PORT map(
		S => SEL,
		D0 => X_1,
		D1 => regOUT1,
		O => muxOUT1
	);

	mux2: mux2x1 PORT map(
		S => SEL,
		D0 => X_2,
		D1 => regOUT2,
		O => muxOUT2
	);
	
	mux3: mux2x1 PORT map(
		S => SEL,
		D0 => X_3,
		D1 => regOUT3,
		O => muxOUT3
	);

	mux4: mux2x1 PORT map(
		S => SEL,
		D0 => X_4,
		D1 => regOUT4,
		O => muxOUT4
	);
	
	reg1: register16 PORT MAP(
		Clock => CLOCK,
		ENABLE => EN,
		D => regIN1,
		Q => regOUT1
	);

	reg2: register16 PORT MAP(
		Clock => CLOCK,
		ENABLE => EN,
		D => regIN2,
		Q => regOUT2
	);

	reg3: register16 PORT MAP(
		Clock => CLOCK,
		ENABLE => EN,
		D => regIN3,
		Q => regOUT3
	);

	reg4: register16 PORT MAP(
		Clock => CLOCK,
		ENABLE => EN,
		D => regIN4,
		Q => regOUT4
	);
	
	roundInst: round PORT map(
		X1 => muxOUT1,
		X2 => muxOUT2,
		X3 => muxOUT3,
		X4 => muxOUT4,
		Z1 => subKey1,
		Z2 => subKey2,
		Z3 => subKey3,
		Z4 => subKey4,
		Z5 => subKey5,
		Z6 => subKey6,
		Y1 => regIN1,
		Y2 => regIN2,
		Y3 => regIN3,
		Y4 => regIN4
	);
	
	controlBlockInst: control PORT map(
		CLK => CLOCK,
		START => START,
		ROUND => roundCounter,
		READY => READY,
		EN => EN,
		S => SEL
	);
	
	keyGenInst: keygenerator PORT map(
		KEY => KEY,
		ROUND => roundCounter,
		KEY1 => subKey1,
		KEY2 => subKey2,
		KEY3 => subKey3,
		KEY4 => subKey4,
		KEY5 => subKey5,
		KEY6 => subKey6
	);
	
	outputTransform: trafo PORT map(
		X1 => regOUT1,
		X2 => regOUT2,
		X3 => regOUT3,
		X4 => regOUT4,
		Z1 => subKey1,
		Z2 => subKey2,
		Z3 => subKey3,
		Z4 => subKey4,
		Y1 => Y_1,
		Y2 => Y_2,
		Y3 => Y_3,
		Y4 => Y_4
	);
	

end Structural;

