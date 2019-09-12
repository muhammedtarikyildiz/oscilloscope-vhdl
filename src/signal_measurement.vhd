-----------------------------------------------------------------------
-- Authors      : Muhammed Tarık YILDIZ <muhammettarikyildiz@gmail.com>
--              : Murat Can Işık <kernet1@hotmail.com>
-- Project      : OSCILLOSCOPE
-- File Name    : signal_measurement.vhd
-- Title        : Measerument of Vpp, Periode Values
-- Description  :
-----------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY SIGNAL_MEASUREMENT IS

PORT
(
		CLK: IN STD_LOGIC;
		RST: IN STD_LOGIC;
		ADC_DATA1: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		ADC_DATA2:IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		VPPMAX1 : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
		VPPMAX2 : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
		VPPMIN1 : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
		VPPMIN2 : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
		PERIODE1 : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
		PERIODE2 : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
		MAX1_OUT : OUT INTEGER RANGE 0 TO 255;
		MAX2_OUT : OUT INTEGER RANGE 0 TO 255;
		MIN1_OUT : OUT INTEGER RANGE 0 TO 255;
		MIN2_OUT : OUT INTEGER RANGE 0 TO 255
);

END ENTITY SIGNAL_MEASUREMENT;


ARCHITECTURE ARCH_SIGNAL_MEASUREMENT OF SIGNAL_MEASUREMENT IS
SHARED VARIABLE MAX1,MAX2,MIN1,MIN2: INTEGER RANGE 0 TO 255 := 0;
SIGNAL DATA_INT1:INTEGER RANGE 0 TO 255 ;
SIGNAL DATA_INT2:INTEGER RANGE 0 TO 255 ;
SIGNAL PERIODE_CNT1:INTEGER RANGE 0 TO 100_000 := 0;
SIGNAL BOOL_CNT1:BOOLEAN := FALSE;
SIGNAL PERIODE_CNT2:INTEGER RANGE 0 TO 100_000 := 0;
SIGNAL BOOL_CNT2:BOOLEAN := FALSE;
BEGIN
	DATA_INT1 <= TO_INTEGER(UNSIGNED(ADC_DATA1));
	DATA_INT2 <= TO_INTEGER(UNSIGNED(ADC_DATA2));
	
	PROCESS(CLK)
	VARIABLE TEMP_VALUE:STD_LOGIC_VECTOR(12 DOWNTO 0);
	VARIABLE TMP_INT:INTEGER;
	VARIABLE C,D,E:INTEGER RANGE 0 TO 9;
	VARIABLE TMP_PERIODE_CNT:INTEGER RANGE 0 TO 50_000_000;
	VARIABLE TMP_PERIODE_OUT:STD_LOGIC_VECTOR(12 DOWNTO 0);
	BEGIN
	-----------------------------------------------
	IF RISING_EDGE(CLK) THEN
		IF RST = '1' THEN
		MAX1 := 0;
		MAX2 := 0;
		MIN1 := 255;
		MIN2 := 255;
		END IF;
	-------------------------------------------------
		IF DATA_INT1 > MAX1 THEN
			MAX1 := DATA_INT1;
			TMP_INT := DATA_INT1;
			IF TMP_INT > 127 THEN
				TEMP_VALUE(12) := '0';
			ELSE
				TEMP_VALUE(12) := '1';
			END IF;
			TMP_INT := TMP_INT * 1294;
			TMP_INT := TMP_INT / 1000;
			E := TMP_INT MOD 10;
			TMP_INT := TMP_INT / 10;
			D := TMP_INT MOD 10;
			TMP_INT := TMP_INT /10;
			C := TMP_INT MOD 10; 
			VPPMAX1(12) <= TEMP_VALUE(12);
			VPPMAX1(11 DOWNTO 8) <= STD_LOGIC_VECTOR(TO_UNSIGNED(C,4));
			VPPMAX1(7 DOWNTO 4) <= STD_LOGIC_VECTOR(TO_UNSIGNED(D,4));
			VPPMAX1(3 DOWNTO 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(E,4));
		END IF;
		-----------------------------------------------------------
		IF DATA_INT1 < MIN1 THEN
			MIN1 := DATA_INT1;
			TMP_INT := DATA_INT1;
			IF TMP_INT > 127 THEN
				TEMP_VALUE(12) := '0';
			ELSE
				TEMP_VALUE(12) := '1';
			END IF;
			TMP_INT := TMP_INT * 1294;
			TMP_INT := TMP_INT / 1000;
			E := TMP_INT MOD 10;
			TMP_INT := TMP_INT / 10;
			D := TMP_INT MOD 10;
			TMP_INT := TMP_INT /10;
			C := TMP_INT MOD 10; 
			VPPMIN1(12) <= TEMP_VALUE(12);
			VPPMIN1(11 DOWNTO 8) <= STD_LOGIC_VECTOR(TO_UNSIGNED(C,4));
			VPPMIN1(7 DOWNTO 4) <= STD_LOGIC_VECTOR(TO_UNSIGNED(D,4));
			VPPMIN1(3 DOWNTO 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(E,4));
		END IF;
		-----------------------------------------------------------
		IF DATA_INT2 > MAX2 THEN
			MAX2 := DATA_INT2;
			TMP_INT := DATA_INT2;
			IF TMP_INT > 127 THEN
				TEMP_VALUE(12) := '0';
			ELSE
				TEMP_VALUE(12) := '1';
			END IF;
			TMP_INT := TMP_INT * 1294;
			TMP_INT := TMP_INT / 1000;
			E := TMP_INT MOD 10;
			TMP_INT := TMP_INT / 10;
			D := TMP_INT MOD 10;
			TMP_INT := TMP_INT /10;
			C := TMP_INT MOD 10; 
			VPPMAX2(12) <= TEMP_VALUE(12);
			VPPMAX2(11 DOWNTO 8) <= STD_LOGIC_VECTOR(TO_UNSIGNED(C,4));
			VPPMAX2(7 DOWNTO 4) <= STD_LOGIC_VECTOR(TO_UNSIGNED(D,4));
			VPPMAX2(3 DOWNTO 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(E,4));
		END IF;
		------------------------------------------------------------
		IF DATA_INT2 < MIN2 THEN
			MIN2 := DATA_INT2;
			TMP_INT := DATA_INT2;
			IF TMP_INT > 127 THEN
				TEMP_VALUE(12) := '0';
			ELSE
				TEMP_VALUE(12) := '1';
			END IF;
			TMP_INT := TMP_INT * 1294;
			TMP_INT := TMP_INT / 1000;
			E := TMP_INT MOD 10;
			TMP_INT := TMP_INT / 10;
			D := TMP_INT MOD 10;
			TMP_INT := TMP_INT /10;
			C := TMP_INT MOD 10; 
			VPPMIN2(12) <= TEMP_VALUE(12);
			VPPMIN2(11 DOWNTO 8) <= STD_LOGIC_VECTOR(TO_UNSIGNED(C,4));
			VPPMIN2(7 DOWNTO 4) <= STD_LOGIC_VECTOR(TO_UNSIGNED(D,4));
			VPPMIN2(3 DOWNTO 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(E,4));
		END IF;
		------------------------------------------------------------
		MAX1_OUT <= MAX1;
		MAX2_OUT <= MAX2;
		MIN1_OUT <= MIN1;
		MIN2_OUT <= MIN2;
		------------------------PERIODE1 CALCULATION-------------------
		IF MAX1 - DATA_INT1 < 5 AND MAX1-DATA_INT1 >= 0 THEN
			BOOL_CNT1 <= TRUE;
		END IF;
		
		IF (MIN1-DATA_INT1 > 5 OR MIN1-DATA_INT1 < 0) AND BOOL_CNT1 = TRUE THEN
			PERIODE_CNT1 <= PERIODE_CNT1 + 1;
		ELSIF BOOL_CNT1 = TRUE AND MIN1-DATA_INT1 < 5 AND MIN1-DATA_INT1 >= 0 THEN
			BOOL_CNT1 <= FALSE;
			TMP_PERIODE_CNT := PERIODE_CNT1;
			TMP_PERIODE_CNT := TMP_PERIODE_CNT * 20;
			TMP_PERIODE_CNT := TMP_PERIODE_CNT / 1000;
			
			IF TMP_PERIODE_CNT > 1000 THEN
				TMP_PERIODE_CNT := TMP_PERIODE_CNT / 1000;
				TMP_PERIODE_OUT(12) := '1';
			ELSE
				TMP_PERIODE_OUT(12) := '0';
			END IF;
			
			E := TMP_PERIODE_CNT MOD 10; --PERIODE C
			TMP_PERIODE_CNT := TMP_PERIODE_CNT / 10; 
			D := TMP_PERIODE_CNT MOD 10;-- PERIODE B
			TMP_PERIODE_CNT := TMP_PERIODE_CNT /10;
			C := TMP_PERIODE_CNT MOD 10; -- PERIODE A
			
			TMP_PERIODE_OUT(3 DOWNTO 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(C,4));
			TMP_PERIODE_OUT(7 DOWNTO 4) := STD_LOGIC_VECTOR(TO_UNSIGNED(D,4));
			TMP_PERIODE_OUT(11 DOWNTO 8) := STD_LOGIC_VECTOR(TO_UNSIGNED(E,4));
			PERIODE1 <= TMP_PERIODE_OUT;
			PERIODE_CNT1 <= 0;
		END IF;
		
		------------------------END PERIODE1 CALCULATION---------------
		------------------------PERIODE2 CALCULATION-------------------
		IF MAX2 - DATA_INT2 < 5 AND MAX2-DATA_INT2 >= 0 THEN
			BOOL_CNT2 <= TRUE;
		END IF;
		
		IF (MIN2-DATA_INT2 > 5 OR MIN2-DATA_INT2 < 0) AND BOOL_CNT2 = TRUE THEN
			PERIODE_CNT2 <= PERIODE_CNT2 + 1;
		ELSIF BOOL_CNT2 = TRUE AND MIN2-DATA_INT2 < 5 AND MIN2-DATA_INT2 >= 0 THEN
			BOOL_CNT2 <= FALSE;
			TMP_PERIODE_CNT := PERIODE_CNT2;
			TMP_PERIODE_CNT := TMP_PERIODE_CNT * 20;
			TMP_PERIODE_CNT := TMP_PERIODE_CNT / 1000;
			IF TMP_PERIODE_CNT > 1000 THEN
				TMP_PERIODE_CNT := TMP_PERIODE_CNT / 1000;
				TMP_PERIODE_OUT(12) := '1';
			ELSE
				TMP_PERIODE_OUT(12) := '0';
			END IF;
			
			E := TMP_PERIODE_CNT MOD 10; --PERIODE C
			TMP_PERIODE_CNT := TMP_PERIODE_CNT / 10; 
			D := TMP_PERIODE_CNT MOD 10; -- PERIODE B
			TMP_PERIODE_CNT := TMP_PERIODE_CNT /10;
			C := TMP_PERIODE_CNT MOD 10; -- PERIODE A
			
			TMP_PERIODE_OUT(3 DOWNTO 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(C,4));
			TMP_PERIODE_OUT(7 DOWNTO 4) := STD_LOGIC_VECTOR(TO_UNSIGNED(D,4));
			TMP_PERIODE_OUT(11 DOWNTO 8) := STD_LOGIC_VECTOR(TO_UNSIGNED(E,4));
			PERIODE2 <= TMP_PERIODE_OUT;
			PERIODE_CNT2 <= 0;
		END IF;
		------------------------END PERIODE2 CALCULATION----------------
	END IF;
	END PROCESS;

END ARCHITECTURE ARCH_SIGNAL_MEASUREMENT;