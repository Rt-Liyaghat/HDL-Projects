
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity key is
   Port( clk  : in  STD_LOGIC;
         col  : in  STD_LOGIC_VECTOR (3 downto 0) ;
         row  : out STD_LOGIC_VECTOR (3 downto 0) ;
         seg  : out STD_LOGIC_VECTOR (6 downto 0));
end key;

architecture Behavioral of key is
   signal NOW_row : INTEGER range 0 to 3  := 0 ;
   signal scn_t  : INTEGER := 0 ;
   signal KeyVal     : INTEGER range 0 to 15 := 0 ;
begin

   process(clk)
   begin
      if (clk'EVENT AND clk='1') then
         scn_t <= scn_t + 1;
         if scn_t = 50000 then
            scn_t <= 0;
            NOW_row <= (NOW_row + 1) mod 4;
         end if;
      end if;
   end process;

   process(NOW_row)
   begin
      case NOW_row is
         when 0 => row <= "1110";
         when 1 => row <= "1101";
         when 2 => row <= "1011";
         when 3 => row <= "0111";
         when others => row <= "1111";
      end case;
   end process;

   process(clk)
   begin
      if (clk'EVENT AND clk='1') then
         case NOW_row is
            when 0 =>
               if    col = "1110" then KeyVal <= 0 ;
               elsif col = "1101" then KeyVal <= 1 ;
               elsif col = "1011" then KeyVal <= 2 ;
               elsif col = "0111" then KeyVal <= 3 ;
               end if;
            when 1 =>
               if    col = "1110" then KeyVal <= 4 ;
               elsif col = "1101" then KeyVal <= 5 ;
               elsif col = "1011" then KeyVal <= 6 ;
               elsif col = "0111" then KeyVal <= 7 ;
               end if;
        when 2 =>
               if    col = "1110" then KeyVal <= 8 ;
               elsif col = "1101" then KeyVal <= 9 ;
               elsif col = "1011" then KeyVal <= 10 ;
               elsif col = "0111" then KeyVal <= 11;
               end if;
            when 3 =>
               if    col = "1110" then KeyVal <= 12;
               elsif col = "1101" then KeyVal <= 13;
               elsif col = "1011" then KeyVal <= 14;
               elsif col = "0111" then KeyVal <= 15;
               end if;
        when others => null;
         end case;
      end if;
   end process;

   process(KeyVal)
   begin
      case KeyVal is
         when 0  => seg <= "1111110"; -- 0
         when 1  => seg <= "0110000"; -- 1
         when 2  => seg <= "1101101"; -- 2
         when 3  => seg <= "1111001"; -- 3
         when 4  => seg <= "0110011"; -- 4
         when 5  => seg <= "1011011"; -- 5
         when 6  => seg <= "1011111"; -- 6
         when 7  => seg <= "1110000"; -- 7
         when 8  => seg <= "1111111"; -- 8
         when 9  => seg <= "1111011"; -- 9
         when 10 => seg <= "1110111"; -- A
         when 11 => seg <= "0011111"; -- b
         when 12 => seg <= "1001110"; -- C
         when 13 => seg <= "0111101"; -- d
         when 14 => seg <= "1001111"; -- E
         when 15 => seg <= "1000111"; -- F
         when others => seg <= "0000000";
      end case;
   end process;
end Behavioral;
