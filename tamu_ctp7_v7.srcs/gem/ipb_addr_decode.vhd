library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.ipbus_pkg.all;

package ipb_addr_decode is

  type t_integer_arr  is array(natural range <>) of integer;
  type t_ipb_slv is record
    oh_reg   : t_integer_arr(0 to 15);
    oh_evt   : t_integer_arr(0 to 15);
    counters : integer;
    daq      : integer;
    ttc      : integer;
    trigger  : integer;
  end record;
  
  constant C_NUM_IPB_SLAVES : integer := 36;
  
  -- IPbus slave index definition
  constant C_IPB_SLV : t_ipb_slv := (oh_reg   => (0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30),
                                     oh_evt   => (1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31),
                                     ttc      => 32,
                                     counters => 33,
                                     daq      => 34,
                                     trigger  => 35);
  
	function ipb_addr_sel(signal addr : in std_logic_vector(31 downto 0)) return integer;

end ipb_addr_decode;

package body ipb_addr_decode is

	function ipb_addr_sel(signal addr : in std_logic_vector(31 downto 0)) return integer is
		variable sel : integer;
	begin
  
    -- The addressing below supports only up to 16 OHs and up to 12 bits of OH in-module addressing, but this the closest we can get to existing addressing (minimal changes going from GLIB)
    -- Note that lowest two bits cannot be used because they're used to address individual bytes within a 32 bit word
    -- Addressing goes like this: [27:24] - AMC module. Module 0x4 is OH reg forwarding where addressing is [23:20] - OH number, [19:16] - OH module, [15:4] - address within module, [3:2] - not used (could be if need be)
    -- AMC modules:
    --   0x3: TTC
    --   0x4: OH register access
    --   0x5: Tracking data FIFO (non related to DAQ module, just pure VFAT data as received from OH)
    --   0x6: Counters
    --   0x7: DAQ
    --   0x8: Trigger

    -- TTC
    if    std_match(addr, "----001100000000000000000---0000") then sel := C_IPB_SLV.oh_reg(0);

	  -- OH register access request forwarding (minimal change from GLIB, but limited to 16 OHs): [26:22] - OH number, [21:18] - OH module, [17:2] - address within module 
    elsif std_match(addr, "----01000000----------------0000") then sel := C_IPB_SLV.oh_reg(0);
    elsif std_match(addr, "----01000001----------------0000") then sel := C_IPB_SLV.oh_reg(1);
    elsif std_match(addr, "----01000010----------------0000") then sel := C_IPB_SLV.oh_reg(2);
    elsif std_match(addr, "----01000011----------------0000") then sel := C_IPB_SLV.oh_reg(3);
    elsif std_match(addr, "----01000100----------------0000") then sel := C_IPB_SLV.oh_reg(4);
    elsif std_match(addr, "----01000101----------------0000") then sel := C_IPB_SLV.oh_reg(5);
    elsif std_match(addr, "----01000110----------------0000") then sel := C_IPB_SLV.oh_reg(6);
    elsif std_match(addr, "----01000111----------------0000") then sel := C_IPB_SLV.oh_reg(7);
    elsif std_match(addr, "----01001000----------------0000") then sel := C_IPB_SLV.oh_reg(8);
    elsif std_match(addr, "----01001001----------------0000") then sel := C_IPB_SLV.oh_reg(9);
    elsif std_match(addr, "----01001010----------------0000") then sel := C_IPB_SLV.oh_reg(10);
    elsif std_match(addr, "----01001011----------------0000") then sel := C_IPB_SLV.oh_reg(11);
    elsif std_match(addr, "----01001100----------------0000") then sel := C_IPB_SLV.oh_reg(12);
    elsif std_match(addr, "----01001101----------------0000") then sel := C_IPB_SLV.oh_reg(13);
    elsif std_match(addr, "----01001110----------------0000") then sel := C_IPB_SLV.oh_reg(14);
    elsif std_match(addr, "----01001111----------------0000") then sel := C_IPB_SLV.oh_reg(15);

    -- event data
    elsif std_match(addr, "----0101000000000000000000--0000") then sel := C_IPB_SLV.oh_reg(0);
    elsif std_match(addr, "----0101000100000000000000--0000") then sel := C_IPB_SLV.oh_reg(1);
    elsif std_match(addr, "----0101001000000000000000--0000") then sel := C_IPB_SLV.oh_reg(2);
    elsif std_match(addr, "----0101001100000000000000--0000") then sel := C_IPB_SLV.oh_reg(3);
    elsif std_match(addr, "----0101010000000000000000--0000") then sel := C_IPB_SLV.oh_reg(4);
    elsif std_match(addr, "----0101010100000000000000--0000") then sel := C_IPB_SLV.oh_reg(5);
    elsif std_match(addr, "----0101011000000000000000--0000") then sel := C_IPB_SLV.oh_reg(6);
    elsif std_match(addr, "----0101011100000000000000--0000") then sel := C_IPB_SLV.oh_reg(7);
    elsif std_match(addr, "----0101100000000000000000--0000") then sel := C_IPB_SLV.oh_reg(8);
    elsif std_match(addr, "----0101100100000000000000--0000") then sel := C_IPB_SLV.oh_reg(9);
    elsif std_match(addr, "----0101101000000000000000--0000") then sel := C_IPB_SLV.oh_reg(10);
    elsif std_match(addr, "----0101101100000000000000--0000") then sel := C_IPB_SLV.oh_reg(11);
    elsif std_match(addr, "----0101110000000000000000--0000") then sel := C_IPB_SLV.oh_reg(12);
    elsif std_match(addr, "----0101110100000000000000--0000") then sel := C_IPB_SLV.oh_reg(13);
    elsif std_match(addr, "----0101111000000000000000--0000") then sel := C_IPB_SLV.oh_reg(14);
    elsif std_match(addr, "----0101111100000000000000--0000") then sel := C_IPB_SLV.oh_reg(15);

    -- other AMC modules
    elsif std_match(addr, "----0110000000000000--------0000") then sel := C_IPB_SLV.counters;
    elsif std_match(addr, "----011100000000000---------0000") then sel := C_IPB_SLV.daq;
    elsif std_match(addr, "----100000000000000---------0000") then sel := C_IPB_SLV.trigger;
    else sel := 999;
    end if;

	  -- OH register access request forwarding if more than 16 OHs are needed: [26:22] - OH number, [21:18] - OH module, [17:2] - address within module
	  -- not very convenient to read though since everything will be shifted by 2 bits 
--  	if    std_match(addr, "----000000--------------------00") then sel := C_IPB_SLV.oh_reg(0);
--    elsif std_match(addr, "----000001--------------------00") then sel := C_IPB_SLV.oh_reg(1);
--    elsif std_match(addr, "----000010--------------------00") then sel := C_IPB_SLV.oh_reg(2);
--    elsif std_match(addr, "----000011--------------------00") then sel := C_IPB_SLV.oh_reg(3);
--    elsif std_match(addr, "----000100--------------------00") then sel := C_IPB_SLV.oh_reg(4);
--    elsif std_match(addr, "----000101--------------------00") then sel := C_IPB_SLV.oh_reg(5);
--    elsif std_match(addr, "----000110--------------------00") then sel := C_IPB_SLV.oh_reg(6);
--    elsif std_match(addr, "----000111--------------------00") then sel := C_IPB_SLV.oh_reg(7);
--    elsif std_match(addr, "----001000--------------------00") then sel := C_IPB_SLV.oh_reg(8);
--    elsif std_match(addr, "----001001--------------------00") then sel := C_IPB_SLV.oh_reg(9);
--    elsif std_match(addr, "----001010--------------------00") then sel := C_IPB_SLV.oh_reg(10);
--    elsif std_match(addr, "----001011--------------------00") then sel := C_IPB_SLV.oh_reg(11);


-- in GLIB:
--		if    std_match(addr, "0100----00000000----------------") then sel := C_IPB_SLV.oh_reg(0);
--		elsif std_match(addr, "0100----00010000----------------") then sel := C_IPB_SLV.oh_reg(1);
--		elsif std_match(addr, "010100000000000000000000000000--") then sel := C_IPB_SLV.oh_evt(0);
--		elsif std_match(addr, "010100000001000000000000000000--") then sel := C_IPB_SLV.oh_evt(1);
--		elsif std_match(addr, "011000000000000000000000--------") then sel := C_IPB_SLV.counters;
--		elsif std_match(addr, "01110000000000000000000---------") then sel := C_IPB_SLV.daq;
--		elsif std_match(addr, "01111000000000000000000---------") then sel := C_IPB_SLV.trigger;
--		elsif std_match(addr, "01111100000000000000000000000---") then sel := C_IPB_SLV.ttc;
--		else sel := 99;
--		end if;
		return sel;
	end ipb_addr_sel;

end ipb_addr_decode;