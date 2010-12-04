package core 
{
	import flash.utils.Dictionary;
	
	public class EventManager extends BaseObject
	{
		/**
		 * Return the class scope
		 */
		public static function get scope():int { return SINGLETON_OBJECT };
		
		/****************************************/
		// Class Details
		/****************************************/

		// A 2d dictornary of events and listeners
		private var _listeners:Dictionary = new Dictionary(true);
		
		public final override function engine_awake():void
		{
			super.engine_awake();
		}
		
		public final override function engine_start():void
		{
			super.engine_start();
		}

		public final override function engine_stop():void
		{
			super.engine_stop();
		}

		public final override function engine_destroy():void
		{
			super.engine_destroy();
		}
		
		/**
		 * Register a global event listener 
		 * @param	eventName (String) The event name to listen for
		 * @param	listener (*) The object listening to the event.
		 * @param	method (Function) The function to be called on the object.
		 */
		public final function registerListener( eventName:String, listener:*, method:Function ):void
		{
			if ( _listeners[eventName] == null ) 
			{
				_listeners[eventName] = new Dictionary(true);
			}
			_listeners[eventName][listener] = method;
		}
		
		/**
		 * Unregister a global event listener 
		 * @param	eventName (String) The event name to listen for
		 * @param	listener (*) The object listening to the event.
		 * @param	method (Function) The function to be called on the object.
		 */
		public final function unregisterListener( eventName:String, listener:*, method:Function ):void
		{
			trace("unregisterListener");
			_listeners[eventName][listener] = null;
			delete _listeners[eventName][listener];
		}
		
		/**
		 * Fire a global event
		 * @param	eventName (String) The event name to fire.
		 * @param	data (*) The data associated with the event.
		 */
		public final function fireEvent( eventName:String, data:* = null ):void
		{
			var listeners:Dictionary = _listeners[eventName];
			for ( var listener:* in listeners ) 
			{
				// Get the method
				var method:Function = listeners[listener];
				if ( method != null ) 
				{
					method( data );
				}
			}
		}
	}
}