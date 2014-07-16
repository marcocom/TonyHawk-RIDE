package com.barliesque.morf.utils {
	
	/**
	 * ...
	 * @author David Barlia
	 */
	
	/**
	 * Converts a hexadecimal value in string format to an integer
	 * @param	hex	Hexadecimal string in any usual format: "0xFF", "#ff", "ff"
	 * @return	integer value
	 */
	public function hex2dec(hex:String):int {
		
		var hexVal:String = filterString(hex.toUpperCase(), "0123456789ABCDEF");
		var nibble:int = 1;
		var dec:int = 0;
		
		for (var i:int = hexVal.length - 1; i >= 0; --i) {
			var digit:String = "0x" + hexVal.substr(i, 1);
			dec += int(digit) * nibble;
			nibble <<= 4;
		}
		return dec;
	}
	
}