﻿package com.thride.home{	import flash.events.Event;		public class HomeNavEvent extends Event 	{		public static const NAVCHOICE:String = "navChoice";		public static const LINKOUT:String = "linkOut";		public static var args:*;				public function HomeNavEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, ... a:*) 		{ 			super(type, bubbles, cancelable); //(type:String, bubbles:Boolean = false, cancelable:Boolean = false)			args = a;					} 		public function get values():Array		{			return args as Array;		}		public override function clone():Event 		{ 			return new TopNavEvent(type, bubbles, cancelable, args);		} 		public override function toString():String 		{ 			return formatToString("TopNavEvent", "type", "values", "eventPhase"); 		}	}}