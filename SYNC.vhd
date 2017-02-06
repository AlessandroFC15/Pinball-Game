library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my.all;
 
ENTITY SYNC IS
PORT(
CLK : IN STD_LOGIC;
HSYNC , VSYNC : OUT STD_LOGIC;
R, G, B : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
KEYS : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
LED: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
);
END SYNC;
 
ARCHITECTURE MAIN OF SYNC IS
	SIGNAL RGB : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL DRAWBOLA : STD_LOGIC;
	SIGNAL X_BOLA, Y_BOLA : INTEGER RANGE 0 TO 1688 := 600;
	SIGNAL HPOS : INTEGER RANGE 0 TO 1688 := 0;
	SIGNAL VPOS : INTEGER RANGE 0 TO 1066 := 0;
	SIGNAL HBOLA : INTEGER RANGE 0 TO 1688 := 0;
	SIGNAL VBOLA : INTEGER RANGE 0 TO 1066 := 0;
	SIGNAL DY : INTEGER RANGE -15 TO 15 := 10;
	SIGNAL DX : INTEGER RANGE -10 TO 10 := 10;

	SIGNAL HBARRA : INTEGER RANGE 0 TO 1688 := 0;
	SIGNAL VBARRA : INTEGER RANGE 0 TO 1066 := 0;
	SIGNAL X_BARRA, Y_BARRA : INTEGER RANGE 0 TO 1688 := 400;
	SIGNAL DRAWBARRA : STD_LOGIC;
	SIGNAL RGB_BARRA : STD_LOGIC_VECTOR(3 DOWNTO 0);

	SIGNAL POINTS : INTEGER RANGE 0 TO 100 := 0;
	SIGNAL TAMANHO_HORIZONTAL : INTEGER RANGE 0 TO 100 := 30;
	SIGNAL TAMANHO_VERTICAL : INTEGER RANGE 0 TO 200 := 150;
	SIGNAL NUM_VEZES_TOQUE_BARRA : INTEGER RANGE 0 TO 2000 := 0;

BEGIN
SQ( HBOLA, VBOLA, X_BOLA, Y_BOLA, RGB, DRAWBOLA);
BARRA(HBARRA, VBARRA, X_BARRA, Y_BARRA, TAMANHO_HORIZONTAL, TAMANHO_VERTICAL, RGB_BARRA, DRAWBARRA);
PROCESS (CLK)
BEGIN

	IF( CLK'EVENT AND CLK='1') THEN
		-- Desenha um quadrado no meio da tela representando a BOLA do jogo
		IF( DRAWBOLA = '1') THEN
			R <= RGB;
			G <= RGB;
			B <= RGB;
		ELSE
			R <= (OTHERS=>'0');
			G <= (OTHERS=>'0');
			B <= (OTHERS=>'0');
		END IF;

		IF( HPOS=1042 OR VPOS=554 ) THEN
			R <= (OTHERS=>'1');
			G <= (OTHERS=>'1');
			B <= (OTHERS=>'1');
		END IF;

		IF( DRAWBARRA='1' ) THEN
			R <= RGB_BARRA;
			G <= RGB_BARRA;
			B <= RGB_BARRA;
		END IF;
		
		IF (POINTS = 0) THEN
				LED(0) <= '0';
				LED(1) <= '0';
				LED(2) <= '0';
				LED(3) <= '0';
				LED(4) <= '0';
				LED(5) <= '0';
				LED(6) <= '1';
			ELSIF (POINTS = 1) THEN
				LED(0) <= '1';
				LED(1) <= '0';
				LED(2) <= '0';
				LED(3) <= '1';
				LED(4) <= '1';
				LED(5) <= '1';
				LED(6) <= '1';
			ELSIF (POINTS = 2) THEN
				LED(0) <= '0';
				LED(1) <= '0';
				LED(2) <= '1';
				LED(3) <= '0';
				LED(4) <= '0';
				LED(5) <= '1';
				LED(6) <= '0';
			ELSIF (POINTS = 3) THEN
				LED(0) <= '0';
				LED(1) <= '0';
				LED(2) <= '0';
				LED(3) <= '0';
				LED(4) <= '1';
				LED(5) <= '1';
				LED(6) <= '0';
			ELSIF (POINTS = 4) THEN
				LED(0) <= '1';
				LED(1) <= '0';
				LED(2) <= '0';
				LED(3) <= '1';
				LED(4) <= '1';
				LED(5) <= '0';
				LED(6) <= '0';
			ELSIF (POINTS = 5) THEN
				LED(0) <= '0';
				LED(1) <= '1';
				LED(2) <= '0';
				LED(3) <= '0';
				LED(4) <= '1';
				LED(5) <= '0';
				LED(6) <= '0';
			ELSIF (POINTS = 6) THEN
				LED(0) <= '0';
				LED(1) <= '1';
				LED(2) <= '0';
				LED(3) <= '0';
				LED(4) <= '0';
				LED(5) <= '0';
				LED(6) <= '0';
			ELSIF (POINTS = 7) THEN
				LED(0) <= '0';
				LED(1) <= '0';
				LED(2) <= '0';
				LED(3) <= '1';
				LED(4) <= '1';
				LED(5) <= '1';
				LED(6) <= '1';
			ELSIF (POINTS = 8) THEN
				LED(0) <= '0';
				LED(1) <= '0';
				LED(2) <= '0';
				LED(3) <= '0';
				LED(4) <= '0';
				LED(5) <= '0';
				LED(6) <= '0';
			ELSIF (POINTS = 9) THEN
				LED(0) <= '0';
				LED(1) <= '0';
				LED(2) <= '0';
				LED(3) <= '0';
				LED(4) <= '1';
				LED(5) <= '0';
				LED(6) <= '0';
			ELSE
				LED(0) <= '1';
				LED(1) <= '1';
				LED(2) <= '1';
				LED(3) <= '1';
				LED(4) <= '1';
				LED(5) <= '1';
				LED(6) <= '1';
			END IF;

		-- Controla a BOLA
		IF( HBOLA < 1688 ) THEN
			HBOLA <= HBOLA + 1;
		ELSE
			HBOLA <= 0;

			IF( VBOLA < 1066 ) THEN
				VBOLA <= VBOLA + 1;
			ELSE
				IF( Y_BOLA > (1066-50) ) THEN
					DY <= -10;
					
					Y_BOLA <= Y_BOLA + DY;
					X_BOLA <= X_BOLA + DX;
					
				ELSIF(Y_BOLA < 50) THEN
					DY <= 10;
					
					Y_BOLA <= Y_BOLA + DY;
					X_BOLA <= X_BOLA + DX;
				ELSIF (X_BOLA > 1638) THEN
					DX <= -10;
					
					Y_BOLA <= Y_BOLA + DY;
					X_BOLA <= X_BOLA + DX;
				ELSIF (X_BOLA < 400 + 40 AND Y_BOLA >= Y_BARRA AND Y_BOLA <= Y_BARRA + 200) THEN
					DX <= 10;
					
					Y_BOLA <= Y_BOLA + DY;
					X_BOLA <= X_BOLA + DX;
					
					TAMANHO_VERTICAL <= TAMANHO_VERTICAL - 7;
					
					IF( DRAWBARRA='1' ) THEN
						R <= RGB_BARRA;
						G <= RGB_BARRA;
						B <= RGB_BARRA;
					END IF;
				ELSIF (X_BOLA < 400) THEN
					DX <= 10;
					POINTS <= POINTS + 1;
					
					IF (POINTS = 0) THEN
						LED(0) <= '0';
						LED(1) <= '0';
						LED(2) <= '0';
						LED(3) <= '0';
						LED(4) <= '0';
						LED(5) <= '0';
						LED(6) <= '1';
					ELSIF (POINTS = 1) THEN
						LED(0) <= '1';
						LED(1) <= '0';
						LED(2) <= '0';
						LED(3) <= '1';
						LED(4) <= '1';
						LED(5) <= '1';
						LED(6) <= '1';
					ELSIF (POINTS = 2) THEN
						LED(0) <= '0';
						LED(1) <= '0';
						LED(2) <= '1';
						LED(3) <= '0';
						LED(4) <= '0';
						LED(5) <= '1';
						LED(6) <= '0';
					ELSIF (POINTS = 3) THEN
						LED(0) <= '0';
						LED(1) <= '0';
						LED(2) <= '0';
						LED(3) <= '0';
						LED(4) <= '1';
						LED(5) <= '1';
						LED(6) <= '0';
					ELSIF (POINTS = 4) THEN
						LED(0) <= '1';
						LED(1) <= '0';
						LED(2) <= '0';
						LED(3) <= '1';
						LED(4) <= '1';
						LED(5) <= '0';
						LED(6) <= '0';
					ELSIF (POINTS = 5) THEN
						LED(0) <= '0';
						LED(1) <= '1';
						LED(2) <= '0';
						LED(3) <= '0';
						LED(4) <= '1';
						LED(5) <= '0';
						LED(6) <= '0';
					ELSIF (POINTS = 6) THEN
						LED(0) <= '0';
						LED(1) <= '1';
						LED(2) <= '0';
						LED(3) <= '0';
						LED(4) <= '0';
						LED(5) <= '0';
						LED(6) <= '0';
					ELSIF (POINTS = 7) THEN
						LED(0) <= '0';
						LED(1) <= '0';
						LED(2) <= '0';
						LED(3) <= '1';
						LED(4) <= '1';
						LED(5) <= '1';
						LED(6) <= '1';
					ELSIF (POINTS = 8) THEN
						LED(0) <= '0';
						LED(1) <= '0';
						LED(2) <= '0';
						LED(3) <= '0';
						LED(4) <= '0';
						LED(5) <= '0';
						LED(6) <= '0';
					ELSIF (POINTS = 9) THEN
						LED(0) <= '0';
						LED(1) <= '0';
						LED(2) <= '0';
						LED(3) <= '0';
						LED(4) <= '1';
						LED(5) <= '0';
						LED(6) <= '0';
						POINTS <= 0;
					ELSE
					
						LED(0) <= '0';
						LED(1) <= '0';
						LED(2) <= '0';
						LED(3) <= '0';
						LED(4) <= '0';
						LED(5) <= '0';
						LED(6) <= '1';
						
						POINTS <= 0;
					END IF;
					
					Y_BOLA <= 550 + DY;
					X_BOLA <= 1000 + DX; 
					
				ELSE
					Y_BOLA <= Y_BOLA + DY;
					X_BOLA <= X_BOLA + DX;
					
				END IF;
				

				VBOLA <= 0;
			END IF;
		END IF;

		IF( HBARRA < 1688 ) THEN
			HBARRA <= HBARRA + 1;
		ELSE
			HBARRA <= 0;

			IF( VBARRA < 1066 ) THEN
				VBARRA <= VBARRA + 1;
			ELSE
				IF( KEYS(0) = '0' ) THEN
					Y_BARRA <= Y_BARRA - 10;
				END IF;
				
				IF( KEYS(1) = '0' ) THEN
					Y_BARRA <= Y_BARRA + 10;
				END IF;
			
				VBARRA <= 0;
			END IF;
		END IF;
		 
		-- Controla outros objetos

		IF( HPOS < 1688 ) THEN
			HPOS <= HPOS + 1;
		ELSE
			HPOS <= 0;
		 
			IF( VPOS < 1066 ) THEN
				VPOS <= VPOS + 1;
			ELSE
				VPOS <= 0;
			END IF;
		END IF;
		 
		IF( HPOS > 48 AND HPOS < 160 ) THEN
			HSYNC <= '0';
		ELSE
			HSYNC <= '1';
		END IF;
		 
		IF( VPOS > 0  AND VPOS < 4 ) THEN
			VSYNC <= '0';
		ELSE
			VSYNC <= '1';
		END IF;
		 
		IF( (HPOS > 0 AND HPOS < 408) OR (VPOS > 0 AND VPOS < 42) ) THEN
			R <= (OTHERS=>'0');
			G <= (OTHERS=>'0');
			B <= (OTHERS=>'0');
		END IF;
	END IF;
END PROCESS;
END MAIN;