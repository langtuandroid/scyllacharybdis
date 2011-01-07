package intro
{
	import core.events.EventHandler;
	import core.events.NetworkEvent;
	import core.events.NetworkEventHandler;
	import core.objects.BaseObject;
	/**
	 * ...
	 * @author ...
	 */
	public class ChatExample extends BaseObject
	{
		private var _networkEventHandler:NetworkEventHandler;

		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public final override function engine_awake():void
		{
			// Get the event manager
			_networkEventHandler = getDependency(NetworkEventHandler);
			super.engine_start();
			
			_networkEventHandler.addEventListener(NetworkEvent.RECEIVED_CHAT_MESSAGE, this, displayMessage );
		}
		
		/**
		 * Engine start should handle engine related start. 
		 */
		public final override function engine_start():void 
		{
			super.engine_start();
		}
		
		/**
		 * Engine stop should handle engine related stop. 
		 */
		public final override function engine_stop():void 
		{
			super.engine_stop();
		}
		
		/**
		* Destroy is called at the removal of the object
		* Unregister listeners
		*/
		public final override function engine_destroy():void
		{
			_networkEventHandler.removeEventListener(NetworkEvent.RECEIVED_CHAT_MESSAGE, this, displayMessage );
			
			super.engine_destroy();
		}		
		
		
		/**
		 * Display the chat message
		 */
		public function displayMessage( data:* ):void
		{
			trace("displayMessage: " + data);
		}
	}
}
