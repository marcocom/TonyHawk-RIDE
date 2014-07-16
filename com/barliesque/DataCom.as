﻿package com.barliesque{	import com.barliesque.morf.utils.dec2hex;	import com.barliesque.morf.utils.hex2dec;	import flash.display.DisplayObject;	import flash.events.Event;	import flash.external.ExternalInterface;	import flash.net.sendToURL;	import flash.net.SharedObject;	import flash.net.URLLoader;	import flash.net.URLLoaderDataFormat;	import flash.net.URLRequest;	import flash.net.URLRequestMethod;	import flash.net.URLVariables;		/**	 * ...	 * @author David Barlia	 */	public class DataCom {				static private const overlay:String = ",uv+FRHV!elW;Xd(mYZa3<4TfkUr@5I]L>gjM=hNoipt^xOP26Q:SwA*Bbc[nyz17_JK8Cq)DsE-G90";		static private const COOKIE_NAME_KEY:int = 0x38;		static public var phpURL:String;				//.........................................				private var request:URLRequest;		private var loader:URLLoader;		private var onLoaded:Function;				public var dataIn:Object;	// Data in to php script		public var dataOut:Object;	// Data out from php script				//-----------------------------------------------------------				public function DataCom(phpURL:String = "php/datacom.php") {			DataCom.phpURL = phpURL;			dataOut = { };		}				//-----------------------------------------------------------				public function sendData(action:String, dataIn:Object = null):void {			if (dataIn != null) {				this.dataIn = dataIn;			}			send(action, this.dataIn);		}				//-----------------------------------------------------------				public function getData(action:String, onLoaded:Function, dataIn:Object = null):void {			if (dataIn != null) {				this.dataIn = dataIn;			}			this.onLoaded = onLoaded;						request = new URLRequest();			request.url = absoluteURL(phpURL + "?action=" + action);			request.data = makeURLvars(dataIn);			request.method = URLRequestMethod.POST;						loader = new URLLoader(request);			loader.dataFormat = URLLoaderDataFormat.TEXT;			loader.addEventListener(Event.COMPLETE, requestComplete, false, 0, true);			loader.load(request);		}				public function clear():void {			if (loader != null) {				loader.removeEventListener(Event.COMPLETE, requestComplete);				loader.close();				loader = null;				request = null;			}		}				static public function absoluteURL(relativeURL:String):String {			if (relativeURL.substr(0, 7) != "http://") {				var urlPath:String = ExternalInterface.call("window.location.href.toString");				if (urlPath) {					var local:String = urlPath.substr(0, urlPath.lastIndexOf("/") + 1);					return local + relativeURL;				}			}			return relativeURL;		}				private function requestComplete(e:Event):void {			//			//  Decrypt returned variables into dataOut, and call onLoaded()			//			dataOut = { };trace("-------------------DATA OUT-------------------");						// Strip off BOM if it's there			var rawData:String = String(loader.data);			if (rawData.charCodeAt(0) < 63 || rawData.charCodeAt(0) > 122) {				rawData = rawData.substr(1);//trace("BOM stripped");			} else {//trace("No BOM");			}						// Split into Variables			var dataVar:Array = rawData.split("&");						for (var i:int = 0; i < dataVar.length; i++ ) {				var data:Array = String(dataVar[i]).split("=");				var key:String = data[0];				var value:String = decrypt(data[1]);				if ((value.search("</") > 0) || (value.search("/>"))) {					dataOut[key] = new XML(value);trace("dataOut." + key + " = " + dataOut[key].toXMLString());				} else {					dataOut[key] = value;trace("dataOut." + key + " = " + dataOut[key]);				}			}			onLoaded(dataOut);		}				//-----------------------------------------------------------				static public function send(action:String, myData:Object):void {			var requestURL = phpURL + "?action=" + action;			var request:URLRequest = new URLRequest(requestURL);			request.method = URLRequestMethod.POST;			request.data = makeURLvars(myData);			sendToURL(request);		}				//-----------------------------------------------------------				static private function makeURLvars(myData:Object):URLVariables {trace("-------------------DATA IN-------------------");						//			//  Encrypt and add myData to URLVariables			//			var data:URLVariables = new URLVariables();			for (var tag:String in myData) {trace(tag + " = " + myData[tag]);								data[tag] = encrypt(String(myData[tag]));			}			return data;		}				//-----------------------------------------------------------				static public function encrypt(original:String, key:int = -1):String {			var c:int			var i:int;			var ret:String = "";						if (key == -1) key = int(Math.random() * 239) + 16;						// ENCRYPT the plain text			for (i = 0; i < original.length; i++) {				c = original.charCodeAt(i);								var e:int = overlay.charCodeAt((key + i) % overlay.length);				c ^= e;				c ^= 0x80;								var h:String = c.toString(16);				ret += h.charAt(1) + h.charAt(0);			}						return dec2hex(key, 2, "") + ret;		}						static public function decrypt(encrypted:String):String {			var c:int			var i:int;			var ret:String = "";						if (encrypted == null) return "";			if (encrypted.length < 2) return "";						var key:int = hex2dec(encrypted.substr(0, 2));			var original:String = encrypted.substr(2);						// DE-CRYPT the encrypted text			for (i = 0; i < original.length; i += 2) {				c = int("0x" + original.substr(i + 1, 1) + original.substr(i, 1));								var e:int = overlay.charCodeAt((key + (i / 2)) % overlay.length);				c ^= e;				c ^= 0x80;								ret += String.fromCharCode(c);			}						return ret;		}				//-----------------------------------------------------------				static public function getCookie(name:String):String {			var cookie:SharedObject = SharedObject.getLocal("datacom");			var encryptedName:String = encrypt(name, COOKIE_NAME_KEY);			var data:String = String(cookie.data[encryptedName]);			return(decrypt(data));		}				static public function saveCookie(name:String, data:String):void {			var cookie:SharedObject = SharedObject.getLocal("datacom");			var encryptedName:String = encrypt(name, COOKIE_NAME_KEY);			cookie.data[encryptedName] = encrypt(data);			cookie.flush();		}				//-----------------------------------------------------------			}}