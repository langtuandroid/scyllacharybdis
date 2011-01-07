package core.events 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.entities.SFSRoom;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import com.smartfoxserver.v2.SmartFox;
	import core.objects.ContainerObject;
	/**
	 */
	[Singleton]
	public class NetworkEventHandler extends ContainerObject
	{

		// Smartfox server
		private var _sfs:SmartFox = new SmartFox();

		// A 2d dictornary of events and listeners
		private var _listeners:Dictionary = new Dictionary(true);

		/**
		 * The engine contructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			// Register event handlers
			_sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);			

			super.engine_awake();
		}
		
		/**
		 * The engine start method
		 * @private
		 */
		public final override function engine_start():void
		{
			super.engine_start();
		}

		/**
		 * The engine stop function
		 * @private
		 */
		public final override function engine_stop():void
		{
			super.engine_stop();
		}

		/**
		 * Destroy is called at the removal of the object
		 * @private
		 */
		public final override function engine_destroy():void
		{
			super.engine_destroy();
			
			// Unregister all the event handlers
			_sfs.removeEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);
		}
		
		/**
		 * Set the network debugging
		 * @param	value (Boolean) True = enable debug message.
		 */
		public final function setDebug( value:Boolean ) 
		{
			_sfs.debug = value;
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
		 * Fire a room event
		 * @param	eventName (String) Server message name
		 * @param	data (SFSObject) Data to be sent to the server.
		 * @param   room (SFSRoom) The room to send the message too. By default it should be the current room
		 */
		public final function fireRoomEvent(eventName:String, data:SFSObject, room:SFSRoom = _sfs.lastJoinedRoom)
		{
			//var sfsObject:ISFSObject = SFSObject.newInstance();
			//sfsObject.putClass(data.modelName, data.model);
			var request:ExtensionRequest = new ExtensionRequest(data.eventName, sfsObject, room);
			owner.sfs.send(request);				
		}
		
		/**
		 * Send a zone event
		 * @param	eventName (String) Server message name
		 * @param	data (SFSObject) Data to be sent to the server.
		 */
		public final function fireZoneEventeventName:String, data:SFSObject)
		{
			//var sfsObject:ISFSObject = SFSObject.newInstance();
			//sfsObject.putClass(data.modelName, data.model);
			var request:ExtensionRequest = new ExtensionRequest(data.eventName, sfsObject);
			owner.sfs.send(request);				
		}
		
		/**
		 * Fire a global event
		 * @param	eventName (String) The event name to fire.
		 * @param	data (*) The data associated with the event.
		 * @private
		 */
		private final function fireEvent( eventName:String, data:* = null ):void
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
		
		/**
		 * Extension response handler
		 * @param	evt (SFSEvent) The data from the server
		 * @private
		 */
		public final function onExtensionResponse(evt:SFSEvent):void
		{
			// Get the network message information
			var params:ISFSObject = evt.params.params;
			var cmd:String = evt.params.cmd;
			trace(cmd);
			
			// Fire the event using the event name and pass the event object
			fireEvent(cmd, evt);
		}
				
	}

}