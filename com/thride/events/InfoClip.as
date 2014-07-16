﻿package com.thride.events{	import flash.display.Stage;	import flash.display.Loader;	import flash.display.MovieClip;	import flash.display.Sprite;		import flash.events.Event;	import flash.events.MouseEvent;	import flash.events.TextEvent;		import flash.net.URLRequest;	import flash.net.URLLoader;		import flash.geom.Point;		import flash.text.TextField;	import flash.text.TextFieldAutoSize;		import flash.utils.Timer;		import flash.geom.Rectangle;		import com.thride.NavEvent;	import gs.TweenLite;	import gs.easing.*;	//TweenLite.to(mc, 1, {x:46, y:43, scaleX:1, scaleY:1, rotation:0, alpha:1, tint:0x3399ff, ease:Elastic.easeOut, onComplete:FunctionName });		import com.thride.Global;		public class InfoClip extends MovieClip	{		private var index:Number;				private var title:String;		private var address:String;		private var city:String;		private var state:String;		private var zip:String;		private var date:String;		private var lat:String;		private var long:String;		private var zoom:String;		private var phonenumber:String;		private var website:String;				private var facebookLink:String;		private var twitterLink:String;		private var phoneTxt:String;		private var linkoutTxt:String;		private var goButLoc:String;				private var dateTxt:TextField;		private var cityTxt:TextField;		private var titleTxt:TextField;		private var addyTxt:TextField;				private var shareBut:MovieClip;		private var phoneBut:MovieClip;		private var backBut:MovieClip;				private var linkoutClip:MovieClip;		private var sendClip:Send2Friend;		private var facebookBut:MovieClip;		private var twitterBut:MovieClip;		private var linkoutCloseBut:MovieClip;				private var totalLocations:Number;				private var callBack:Function;				public function InfoClip()		{			addEventListener(Event.ADDED_TO_STAGE, onAdded);		}				public function init($data:Object, $call:Function, $copy:String, $send2friend:XMLList, $gobut:String, $total:Number)		{			callBack = $call;			linkoutTxt = $copy;						title = $data.title;			address = $data.address;			city = $data.city;			state = $data.state;			zip = $data.zip;			date = $data.date;			lat = $data.lat;			long = $data.long;			zoom = $data.zoom;			facebookLink = $data.facebook;			twitterLink = $data.twitter;			phonenumber = $data.phone;			website = $data.url;			index = $data.index;			totalLocations = $total;			//trace("INFOCLIP :: INIT:"+$data);			var flip = Math.abs(index - totalLocations);			populateCopy();			popImages();						sendClip.init($send2friend, $gobut, flip, city, state);		}				private function onAdded(e:Event)		{			dateTxt = getChildByName("datetxt") as TextField;			cityTxt = getChildByName("citytxt") as TextField;			titleTxt = getChildByName("titletxt") as TextField;			addyTxt = getChildByName("addresstxt") as TextField;						shareBut = getChildByName("sharedyn") as MovieClip;			phoneBut = getChildByName("phonedyn") as MovieClip;			backBut = getChildByName("backdyn") as MovieClip;						linkoutClip = getChildByName("linkout") as MovieClip;			sendClip = getChildByName("sendmail") as Send2Friend;			facebookBut = linkoutClip.getChildByName("facebookdyn") as MovieClip;			twitterBut = linkoutClip.getChildByName("twitterdyn") as MovieClip;			linkoutCloseBut = linkoutClip.getChildByName("closebut") as MovieClip;						linkoutClip.visible = false;			sendClip.visible = false;		}				private function popImages()		{			var shareimg:String = "img/"+Global.COUNTRY+"/events/share.png";			var shareLoader:Loader = new Loader();			function initShare(e:Event)			{				shareBut.addChild(e.currentTarget.content);				shareBut.buttonMode = true;				shareBut.addEventListener(MouseEvent.CLICK, shareAction);			}			shareLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, initShare);			shareLoader.load(new URLRequest(shareimg));						var phoneimg:String = "img/"+Global.COUNTRY+"/events/phone.png";			var phoneLoader:Loader = new Loader();			function initPhone(e:Event)			{				phoneBut.addChild(e.currentTarget.content);				phoneBut.buttonMode = true;				phoneBut.addEventListener(MouseEvent.CLICK, emailAction);			}			phoneLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, initPhone);			phoneLoader.load(new URLRequest(phoneimg));									var backimg:String = "img/"+Global.COUNTRY+"/events/backbut.png";			var backLoader:Loader = new Loader();			function initBack(e:Event)			{				backBut.addChild(e.currentTarget.content);				backBut.buttonMode = true;				backBut.addEventListener(MouseEvent.CLICK, backAction);			}			backLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, initBack);			backLoader.load(new URLRequest(backimg));																		var facebookimg:String = "img/"+Global.COUNTRY+"/link_facebook.png";			var facebookLoader:Loader = new Loader();			function initFaceBook(e:Event)			{				facebookBut.addChild(e.currentTarget.content);				facebookBut.buttonMode = true;				facebookBut.addEventListener(MouseEvent.CLICK, facebookAction);			}			facebookLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, initFaceBook);			facebookLoader.load(new URLRequest(facebookimg));						var twitterimg:String = "img/"+Global.COUNTRY+"/link_twitter.png";			var twitterLoader:Loader = new Loader();			function initTwitter(e:Event)			{				twitterBut.addChild(e.currentTarget.content);				twitterBut.buttonMode = true;				twitterBut.addEventListener(MouseEvent.CLICK, twitterAction);			}			twitterLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, initTwitter);			twitterLoader.load(new URLRequest(twitterimg));					}										//////////////////////////////////////////////HNDLERS		private function backAction(e:MouseEvent){			callBack();		}						private function twitterAction(e:MouseEvent){						var flip:Number = Math.abs(index - totalLocations);			var url:String = "http://twitter.com/home?status=Check+Out+This+THRIDE+demo event!+http://"+Global.DOMAIN + escape("/#/events/")+flip;			dispatchEvent(new NavEvent(NavEvent.LINKOUT, true, true, url));			closeLinkOut(null);		}				private function facebookAction(e:MouseEvent){						var flip:Number = Math.abs(index - totalLocations);			var url:String = "http://www.facebook.com/share.php?u=http://"+Global.DOMAIN + escape("/#/events/")+flip;			dispatchEvent(new NavEvent(NavEvent.LINKOUT, true, true, url));			closeLinkOut(null);		}								private function closeLinkOut(e:MouseEvent){			linkoutClip.visible = false;		}						/////////////////////////////////////////ACTION		private function initLinkOut(){			linkoutClip.visible = true;			var txt:TextField = linkoutClip.getChildByName("titletxt") as TextField;			txt.htmlText = linkoutTxt;			linkoutCloseBut.addEventListener(MouseEvent.CLICK, closeLinkOut);			linkoutCloseBut.buttonMode = true;		}				private function initSend2Friend(){			sendClip.visible = true;		}				private function shareAction(e:Event){			trace("SHARE ACTION ()");			initLinkOut();		}				private function emailAction(e:Event){			trace("SEND ACTION ()");			initSend2Friend();		}						private function populateCopy()		{			dateTxt.text = date;			cityTxt.text = city+", "+state;			titleTxt.text = title;			addyTxt.htmlText = address+"\n"+city+", "+state+" "+zip+"\n\n"+phonenumber+ "\n<a href=\"event:" + website + "\">" + website+"</a>";			addEventListener(TextEvent.LINK, linkHandler);		}						private function linkHandler(e:TextEvent)		{            var url:String = e.text			dispatchEvent(new NavEvent(NavEvent.LINKOUT, true, false, url));        }			}}