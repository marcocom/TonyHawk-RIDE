﻿package com.thride.game{	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.display.Loader;	import flash.display.Graphics;		import flash.display.StageDisplayState;		import flash.text.TextField;	import flash.text.TextFieldAutoSize;	import flash.net.URLLoader;	import flash.net.URLRequest;		import flash.events.Event;	import flash.events.MouseEvent;		import flash.geom.Rectangle;    import flash.xml.XMLDocument;    import flash.xml.XMLNode;    import flash.xml.XMLNodeType;		import com.thride.TopNavEvent;	import com.thride.Global;	import com.asual.swfaddress.*;	import gs.TweenLite;	import gs.easing.*;		public class Info extends MovieClip	{								public var dataXML:XMLList;						private var bgLoader:Loader;				public var imgClip:MovieClip;		public var crosslinkBut:MovieClip;		public var boardAnim:MovieClip;				private var titleTxt:TextField;		private var bodyTxt:TextField;						private var currentContent:*;				public function Info()		{			addEventListener(Event.ADDED_TO_STAGE, onAdded);		}				public function init($dataXML:XMLList)		{			dataXML = $dataXML;									loadGraphic(dataXML.@asset, imgClip);			loadGraphic(dataXML.@crosslink, crosslinkBut);						titleTxt.autoSize = TextFieldAutoSize.LEFT;			titleTxt.htmlText = dataXML.title.valueOf()						bodyTxt.y = titleTxt.y + titleTxt.textHeight + 10;			bodyTxt.htmlText = dataXML.copyblock.valueOf();									crosslinkBut.addEventListener(MouseEvent.CLICK, crosslinkAction);			crosslinkBut.buttonMode = true;			boardAnim.mouseEnabled = false;		}				private function crosslinkAction(e:MouseEvent)		{			SWFAddress.setValue("board");		}				private function loadGraphic(asset:String, target:MovieClip)		{						var l = new Loader();			function finishload(e:Event){				target.addChild(e.currentTarget.content);				TweenLite.from(target, 1, {alpha:0, ease:Strong.easeOut});			}			l.contentLoaderInfo.addEventListener(Event.COMPLETE, finishload);			l.load(new URLRequest(asset));					}										private function onAdded(e:Event)		{			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);						titleTxt = getChildByName("titletxt") as TextField;			bodyTxt = getChildByName("bodytxt") as TextField;			imgClip = getChildByName("imgdyn") as MovieClip;			crosslinkBut = getChildByName("crosslinkdyn") as MovieClip;			boardAnim = getChildByName("boardanim") as MovieClip;					}		private function onRemoved(e:Event){						delete this;		}					}}