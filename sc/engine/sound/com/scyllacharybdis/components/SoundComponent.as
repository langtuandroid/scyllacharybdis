package com.scyllacharybdis.components
{
	import com.scyllacharybdis.interfaces.IBaseComponent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	
	/**
	 * 
	 */
	public class SoundComponent implements IBaseComponent
	{
		private var _sound:Sound;
		
		public function awake(owner:*):void
		{
			
		}
		
		public function update():void
		{
			
		}
		
		public function destroy():void
		{
			
		}
		
		/**
		 * Load a sound file
		 * @param	value (String) The filename
		 */
		public function loadSound( value:String ):void 
		{ 
			_sound = new Sound( new URLRequest("sounds/" + value) ); 
		}
		
		/**
		 * Play the sound
		 * @param	loopCount (int) The number of times you want it to loop.
		 */
		public function playSound( loopCount:int = 1 ):void 
		{
			if ( _sound == null )
			{
				return;
			}
			_sound.play(0, loopCount, null );
		}
		
		/**
		 * Load progress handler
		 * @param	event (ProgressEvent)
		 */
        private function progressHandler(event:ProgressEvent):void 
		{
            var loadTime:Number = event.bytesLoaded / event.bytesTotal;
            var LoadPercent:uint = Math.round(100 * loadTime);
              
            trace("Sound file's size in bytes: " + event.bytesTotal + "\n" 
				+ "Bytes being loaded: " + event.bytesLoaded + "\n" 
				+ "Percentage of sound file that is loaded " + LoadPercent + "%.\n"
			);
        }

		/**
		 * Load file error handler
		 * @param	errorEvent (IOErrorEvent)
		 */
        private function errorHandler(errorEvent:IOErrorEvent):void 
		{
            trace("The sound could not be loaded: " + errorEvent.text );
        }		
	}
}