package com.thride.register {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	/**
	 * ...
	 * @author David Barlia
	 */
	public class Toggler extends MovieClip {
		
		static public const SELECT:String = "select";
		
		// on-stage
		public var indicator:MovieClip;
		public var selector:SimpleButton;
		
		public var toggleClick:Boolean = true;

		private var _valid:Boolean;
		private var invalidTint:ColorTransform;
		private var noTint:ColorTransform;
		
		public function Toggler() {
			indicator.visible = false;
			selector.addEventListener(MouseEvent.CLICK, select, false, 0, true);
		}
		
		private function select(e:MouseEvent):void {
			if (toggleClick) {
				selected = !indicator.visible;
			} else {
				selected = true;
			}
			dispatchEvent(new Event(Toggler.SELECT));
		}
		
		public function get selected():Boolean { return indicator.visible; }
		
		public function set selected(value:Boolean):void {
			indicator.visible = value;
		}
		
		public function get valid():Boolean {
			return _valid;
		}
		
		public function set valid(value:Boolean):void {
			_valid = value;
			
			if (invalidTint == null) {
				invalidTint = new ColorTransform(0.8, 0.8, 0.8, 1, 64, -64, -64, 0);
				noTint = new ColorTransform();
			}
			
			selector.transform.colorTransform = _valid ? noTint : invalidTint;
		}		
	}
}