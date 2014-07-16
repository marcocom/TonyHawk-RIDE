package com.barliesque.morf.utils {
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author David Barlia
	 */
	
	 /**
	  * @param	clip		The MovieClip timeline from which to get frame labels
	  * @param	zeroBased	Default = false
	  * @return				An object with properties matching the frame labels, and containing frame numbers
	  */
	public function getLabeledFrames(clip:MovieClip, zeroBased:Boolean = false):Object {
		var frames:Object = { };
		
		for (var i:int = 0; i < clip.currentLabels.length; i++) {
			frames[clip.currentLabels[i].name] = clip.currentLabels[i].frame - (zeroBased ? 1 : 0);
		}
		
		return(frames);
	}
	
}