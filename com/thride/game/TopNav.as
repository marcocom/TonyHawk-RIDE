﻿package com.thride.game{	import com.asual.swfaddress.*;	import com.thride.Global;		import flash.display.Loader;	import flash.display.MovieClip;	import flash.display.Sprite;		import flash.events.Event;	import flash.events.MouseEvent;		import flash.net.URLRequest;		import flash.text.TextField;	import flash.text.TextFieldAutoSize;		import flash.geom.Rectangle;		import gs.TweenLite;	import gs.easing.*;	//TweenLite.to(mc, 1, {x:46, y:43, scaleX:1, scaleY:1, rotation:0, alpha:1, tint:0x3399ff, ease:Elastic.easeOut, onComplete:FunctionName });			public class TopNav extends MovieClip	{		private var navMargin:Number = 10;				public  var country:String;				private var xmlList:XMLList;		private var topNavMC:Sprite;		private var navArr:Array;				private var currentNav:TopNavLink;				public function TopNav($xmlList:XMLList)		{						addEventListener(Event.ADDED_TO_STAGE, onAdded);						xmlList = $xmlList;			country = Global.COUNTRY; 			initNav();		}								///////////////////////////////////////////////////NAV				private function initNav()		{			topNavMC = new Sprite();			addChild(topNavMC);			navArr = new Array();									var totalNavs:Number = xmlList.elements().length();			//trace("\nINITNAV() ----------------total:"+totalNavs);			for (var i:int; i < totalNavs; i++){				//trace("NAV - "+xmlList.section[i].valueOf());				var navmc:TopNavLink = new TopNavLink(xmlList.section[i].valueOf(), xmlList.section[i].@id);				navmc.x = topNavMC.width + navMargin;				navmc.y = 10;				topNavMC.addChild(navmc);								navmc.name = "nav"+i;								if(xmlList.section[i].@enabled == "true"){					navmc.addEventListener(MouseEvent.CLICK, navClick);					navmc.addEventListener(MouseEvent.MOUSE_OVER, navOver);					navmc.addEventListener(MouseEvent.MOUSE_OUT, navOut);					navmc.buttonMode = true;				} else {					navmc.deadAnim();				}								//navArr.push( { clip:navmc, id:xmlList.section[i].@id, xmlurl:xmlList.section[i].@xml } );				navArr.push(navmc);				if(i == (totalNavs-1)) navmc.slant.visible = false;			}						//trace("----------------------------total:"+totalNavs);						SWFAddress.addEventListener(SWFAddressEvent.CHANGE, addressChange);			addressChange(null);		}								///////////////////////////////////////////////HANDLERS												public function navAction(id:String)		{			trace("TOPNAV/NAVACTION :"+id);			var url:String = "game/"+id;			SWFAddress.setValue(url);			//dispatchEvent(new TopNavEvent(TopNavEvent.NAVCHOICE, true, true, id));					}										public function navClick(e:MouseEvent)		{			//trace("navClick : "+e.currentTarget.id);			var mc:TopNavLink = e.currentTarget as TopNavLink;			navAction(mc.id);			if(currentNav) currentNav.addEventListener(MouseEvent.MOUSE_OUT, navOut);			currentNav = mc;			currentNav.removeEventListener(MouseEvent.MOUSE_OUT, navOut);		}												public function navOut(e:MouseEvent)		{			//trace("navOut");			e.currentTarget.outAnim();		}		public function navOver(e:MouseEvent)		{			//trace("navOver");			e.currentTarget.overAnim();		}								/////////SWFADDRESS				private function addressChange(e:SWFAddressEvent)		{									var arr:Array = SWFAddress.getPathNames();								trace("GAME:SUBNAV --- ADDRESS CHANGE ARR: length:"+arr.length+" vals:"+arr[1]);				for(var i:int; i < navArr.length; i++){					if(arr[1] == navArr[i].id && currentNav != navArr[i]){						trace("FOUND:"+navArr[i].id);						navArr[i].overAnim();						if(currentNav){ 							currentNav.addEventListener(MouseEvent.MOUSE_OUT, navOut);							currentNav.outAnim();						}						currentNav = navArr[i];						currentNav.removeEventListener(MouseEvent.MOUSE_OUT, navOut);					}				}						//e.value == "/" ? homeNavigate(null) : navAction(e.value);			//disable nav here		}				////////CONSTRUCT				private function onAdded(e:Event)		{								}			}}