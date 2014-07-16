﻿package com.thride.events{	import flash.display.Stage;	import flash.display.Loader;	import flash.display.MovieClip;	import flash.display.Sprite;		import flash.events.Event;	import flash.events.MouseEvent;		import flash.net.URLRequest;	import flash.net.URLLoader;		import flash.geom.Point;		import flash.text.TextField;	import flash.text.TextFieldAutoSize;		import flash.utils.Timer;		import flash.geom.Rectangle;		import gs.TweenLite;	import gs.easing.*;	//TweenLite.to(mc, 1, {x:46, y:43, scaleX:1, scaleY:1, rotation:0, alpha:1, tint:0x3399ff, ease:Elastic.easeOut, onComplete:FunctionName });			public class Location extends MovieClip	{		private var xmlObj:XML ;				private var titleTxt:loctxt;				public var index:Number;				public function Location($xmlObj:XML, $index:Number)		{			xmlObj = $xmlObj;			index = $index;			addEventListener(Event.ADDED_TO_STAGE, onAdded);						initLook();			initHit();					}				private function initLook()		{			var date:loctxt = new loctxt();			addChild(date);			var datetxt:TextField = date.getChildByName("txt") as TextField;			datetxt.autoSize = TextFieldAutoSize.LEFT;			datetxt.text = xmlObj.@date;						datetxt.width = datetxt.textWidth+5;			datetxt.height = datetxt.textHeight;						titleTxt = new loctxt();			addChild(titleTxt);			var ltxt:TextField = titleTxt.getChildByName("txt") as TextField;			ltxt.autoSize = TextFieldAutoSize.LEFT;			ltxt.text = xmlObj.@city+", "+xmlObj.@state;						ltxt.width = ltxt.textWidth+5;			ltxt.height = ltxt.textHeight;						ltxt.x = datetxt.width + 5;		}				public function onState(){			TweenLite.killTweensOf(this);			TweenLite.to(this, .25, {tint:0xCC0000});		}				public function offState(){			TweenLite.killTweensOf(this);			TweenLite.to(this, .25, {tint:0x000000});		}				private function initHit()		{			var hit:Sprite = new Sprite();			hit.graphics.beginFill(0x000000, 0);			hit.graphics.drawRect(0, 0, this.width, this.height);			hit.graphics.endFill();			addChild(hit);		}		///////////////////////////GETSET						public function get _data():Object		{			var a:Object = new Object();			a.title = xmlObj.@title;			a.address = xmlObj.@address;			a.city = xmlObj.@city;			a.state = xmlObj.@state;			a.zip = xmlObj.@zip;			a.date = xmlObj.@date;			a.lat = xmlObj.@lat;			a.long = xmlObj.@long;			a.zoom = xmlObj.@zoom;			a.facebook = xmlObj.@facebook;			a.twitter = xmlObj.@twitter;						a.phone = xmlObj.@phone;			a.url = xmlObj.@url;			a.index = index;			return a;		}						//////////////////////////CONSTRUCT		private function onAdded(e:Event)		{					}			}}