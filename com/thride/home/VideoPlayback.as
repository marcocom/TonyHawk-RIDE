﻿package com.thride.home{    import flash.display.Sprite;	import flash.display.Stage;    import flash.events.*;    import flash.media.Video;	import flash.media.Sound;	import flash.media.SoundTransform;	import flash.media.SoundMixer;    import flash.net.NetConnection;    import flash.net.NetStream;		import com.thride.Global;	import com.thride.AudioEvent;	    public class VideoPlayback extends Sprite    {        private var url:String;		private var movWidth:Number;		private var movHeight:Number;		private var movDuration:Number;		private var movInst:String;		private var stream:NetStream;		private var connection:NetConnection;		private var video:Video;		private var sound:SoundTransform;		private var muteStatus:Boolean = false;		private var _lastVolume:Number = 1;		private var nextFunc:Function;		private var bg_volume:Number;		        public function VideoPlayback($asset:String, $w:Number, $h:Number, $currentVolume:Number, $closeFunc) {			url = $asset;			movWidth = $w;			movHeight = $h;						_lastVolume = $currentVolume;			nextFunc = $closeFunc;						addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			trace(">>>>>>>>>>>>>>>>>>>VIDEOPLAYER : volume:"+_lastVolume);		}				public function onAddedToStage(event:Event)		{			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);			trace("VIDEO ADDED:"+url);			if (connection == null) {				connection = new NetConnection();				connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);				connection.connect(null);			}			//connectStream();			stage.dispatchEvent(new AudioEvent(AudioEvent.TOGGLE, true, false, false));		}				private function onRemoved(e:Event) {						stage.dispatchEvent(new AudioEvent(AudioEvent.TOGGLE, true, false, true));		}		        private function connectStream(){			if (stream == null) {				stream = new NetStream(connection);				stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);				stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);								var client:Object = new Object();				client.onMetaData = onMetaData;								stream.client = client;				//stream.receiveAudio(true);            	//stream.receiveVideo(true);			}			if (video == null) {				video = new Video();				video.attachNetStream(stream);				video.smoothing = true;				video.width = movWidth;				video.height = movHeight;				stream.play(url);					stream.seek(0);				addChild(video);				 			}			sound = new SoundTransform();			!muteStatus ? setvolume(_lastVolume) : mute(true);			        }		private function onMetaData(data:Object)		{           movDuration = data.duration;                   }        private function securityErrorHandler(event:SecurityErrorEvent)		{            trace("securityErrorHandler: " + event);        }                private function asyncErrorHandler(event:AsyncErrorEvent)		{            // ignore AsyncErrorEvent events.        }				        private function netStatusHandler(event:NetStatusEvent):void {            switch (event.info.code) {                case "NetConnection.Connect.Success":                    connectStream();                    break;                case "NetStream.Play.StreamNotFound":                    trace("WARNING", "Unable to locate video: " + url);                    break;				case "NetStream.Play.Stop":					//playVid();					trace("PLAYING NEXT MOVIE");					nextFunc();					break;					            }        }						public function mute(muted:Boolean):void		{            muteStatus = muted;			var s:SoundTransform = new SoundTransform((muted ? 0 : _lastVolume),0);            			stream.soundTransform = s;			this.soundTransform = s;        }        public function setvolume(vol:Number):void        {   			trace("PLAYBACK SETVOLUME:"+vol);			//_lastVolume = sound.volume = vol;            //if(!muteStatus) stream.soundTransform = sound;			var vs:SoundTransform = new SoundTransform(vol, 0);			_lastVolume = vol;			stream.soundTransform = vs;			this.soundTransform = vs        }				public function unloadVid()		{			SoundMixer.stopAll(); 						if (stream != null) {				stream.close();			}			if (url != null) {				video.clear();			}			if (connection != null) {				connection.close();			}			if (video != null) {				removeChild(video);			}			url = null;			connection = null;			stream = null;			video = null;		}		public function changeVideo(asset)		{						unloadVid();			url = asset;			onAddedToStage(null);		}				public function playVid()		{			stream.seek(0);			stream.resume();		}		public function pauseVid()		{			stream.pause();		}		public function resumeVid()		{			stream.resume();		}		public function get vidInstance():String 		{			return movInst;		}		public function set vidInstance(value:String)		{			movInst = value;		}		public function get vidDuration():Number 		{			return movDuration;		}		public function get vidTime():Number 		{			return stream.time;		}		public function get vidLoaded():Number 		{			var currPercent:Number = Math.round(stream.bytesLoaded / stream.bytesTotal);			return currPercent;		}		public function get vidPlayed():Number 		{			var currPercent:Number = (movDuration / stream.time);			return currPercent;		}		public function vidSeek(num:Number)		{			stream.seek(num);		}		public function set _vidWidth(num:Number)		{			video.width = num;		}		public function set _vidHeight(num:Number)		{			video.height = num;		}				public function get _volume():Number		{			return _lastVolume;		}		    }}