package com.scyllacharybdis.core.events 
{
	import com.scyllacharybdis.interfaces.IBaseObject;
	import flash.utils.Dictionary;
	
	[Singleton]
	public final class EventHandler implements IBaseObject
	{
		
		public function destroy():void
		{
			
		}

		// A 2d dictornary of events and listeners
		private var _listeners:Dictionary = new Dictionary(true);
		
		/**
		 * Register a global event listener 
		 * @param	eventName (String) The event name to listen for
		 * @param	listener (*) The object listening to the event.
		 * @param	method (Function) The function to be called on the object.
		 */
		public final function addEventListener( eventName:String, listener:*, method:Function ):void
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
		public final function removeEventListener( eventName:String, listener:*, method:Function ):void
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