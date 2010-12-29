package intro
{
	import core.managers.EventManager;
	import core.objects.BaseObject;
	/**
	 * ...
	 * @author ...
	 */
	public class ChatExample extends BaseObject
	{
		private var _eventManager:EventManager;

		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public final override function engine_awake():void
		{
			// Get the event manager
			_eventManager = getDependency(EventManager);
			super.engine_start();
			
			_eventManager.registerListener("RECEIVED_CHATMESSAGE", this, displayMessage );
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
			_eventManager.unregisterListener("RECEIVED_CHATMESSAGE", this, displayMessage );
			
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
