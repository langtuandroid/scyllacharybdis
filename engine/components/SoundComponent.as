package components
{
	import flash.media.Sound;
	import flash.net.URLRequest;
	import core.BaseObject;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	
	/**
	 * 
	 */
	public class SoundComponent extends BaseObject
	{
		
		/**
		 * Get the dependencies to instantiate the class
		 */
		public static function get dependencies():Array { return []; }
		
		/****************************************/
		// Type definition
		/****************************************/
		public override final function getType():String 
		{
			return SOUND_COMPONENT;
		}				
		
		/****************************************/
		// Class Details
		/****************************************/
		
		private var _sound:Sound;
		
		/**
		 * Instantiate the baseclip upon construction
		 */
		public final override function engine_awake():void
		{
			super.engine_awake();
		}
	
		/**
		 */ 
		public final override function engine_start(): void 
		{
			super.engine_start();
		}
		
		public final override function engine_stop():void
		{
			super.engine_stop();
		}
		
		/**
		 */
		public final override function engine_destroy():void
		{
			super.engine_destroy();
		}
		
		public function loadSound( value:String ):void 
		{ 
			_sound = new Sound( new URLRequest(value) ); 
		}
		
		public function playSound( loopCount:int = 1 ):void 
		{
			if ( _sound == null )
			{
				return;
			}
			_sound.play(0, loopCount, null );
		}
		
        private function progressHandler(event:ProgressEvent):void 
		{
            var loadTime:Number = event.bytesLoaded / event.bytesTotal;
            var LoadPercent:uint = Math.round(100 * loadTime);
              
            trace("Sound file's size in bytes: " + event.bytesTotal + "\n" 
				+ "Bytes being loaded: " + event.bytesLoaded + "\n" 
				+ "Percentage of sound file that is loaded " + LoadPercent + "%.\n"
			);
			
        }
 
        private function errorHandler(errorEvent:IOErrorEvent):void 
		{
            trace("The sound could not be loaded: " + errorEvent.text );
        }		
	}
}