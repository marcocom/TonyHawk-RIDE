package com.barliesque.morf.utils {
	
	/**
	 * ...
	 * @author David Barlia
	 */
	/**
	 * Converts an integer value to a hexadecimal String with a specified number of digits.  Leading zeros will be added to ensure the desired number of digits.  Since digits will never be removed from the final value, use 1 for the digits parameter if no leading zeros is preferred.
	 * @param	dec		The integer value to convert
	 * @param	digits	Number of digit
	 * @param	prefix	A hexadecimal prefix, (default "#")
	 * @return
	 */
	public function dec2hex(dec:uint, digits:int = 6, prefix:String = "#"):String {
		var hex:String = dec.toString(16).toUpperCase();
		var z:int = digits - hex.length;
		for (var i:int = 0; i < z; ++i) {
			hex = "0" + hex;
		}
		return prefix + hex;
	}
	
}