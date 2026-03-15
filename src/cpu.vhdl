------- cpu.vhdl ------------
-- Author: Izabella Hagberg
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	port(a : in unsigned(3 downto 0);
		b : in unsigned(3 downto 0);
		opcode : in std_logic_vector(1 downto 0);
		result : out std_logic_vector(7 downto 0)
	);
end entity;

-- Result |MSB.Z|||||||LSB|
architecture behaviour of alu is
	-- Signal declarations
	signal y : unsigned(4 downto 0);
begin
	process(a,b,opcode)
	begin
		case opcode is
			when "00" => y <= resize(a,5) + resize(b,5);
			when "01" => y <= resize(a,5) - resize(b,5);
			when "10" => y <= not resize(a, 5);
			when "11" => y <= resize(a,5) nand resize(b,5);
			when others => y <= (others => 'Z');
		end case;
	end process;
	-- ||||||	
	-- result(4 downto 0) <= std_logic_vector(y); need to redesign this because of the result sizes
	-- bit number seven is the zero flag that can be used for branching:
	result(7) <= '1' when y = "00000" else '0';
end architecture;
