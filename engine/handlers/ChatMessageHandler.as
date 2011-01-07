package handlers 
{
	import core.events.NetworkEvent;
	import core.events.NetworkEventHandler;
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.PublicMessageRequest;

	import core.objects.BaseObject;	
	import models.RoomModel;
	import models.ChatMessageModel;

	/**
	*/
	[Singleton]
	[Requires ("core.events.NetworkEventHandler")]
	public class ChatMessageHandler extends BaseObject
	{
		private var _networkEventHandler:NetworkEventHandler;

		/**
		 * Awake is called at the construction of the object
		 * Register all the listeners
		 * @private
		 */
		public final override function engine_awake():void
		{
			// Get the event manager
			_networkEventHandler = getDependency(NetworkEventHandler);
			
			_networkEventHandler.addEventListener(SFSEvent.PUBLIC_MESSAGE, this, onPublicMessage);
			
			super.engine_start();
			
			_networkEventHandler.addEventListener(NetworkEvent.SEND_CHAT_MESSAGE, this, sendChatMessage );
		}
		
		/**
		 * Engine start should handle engine related start. 
		 * @private
		 */
		public final override function engine_start():void 
		{
			super.engine_start();
		}
		
		/**
		 * Engine stop should handle engine related stop. 
		 * @private
		 */
		public final override function engine_stop():void 
		{
			super.engine_stop();
		}
		
		/**
		 * Destroy is called at the removal of the object
		 * Unregister listeners
		 * @private
		 */
		public final override function engine_destroy():void
		{
			_networkEventHandler.removeEventListener(NetworkEvent.SEND_CHAT_MESSAGE, this, sendChatMessage );

			super.engine_destroy();
			
			_networkEventHandler.removeEventListener(SFSEvent.PUBLIC_MESSAGE, this, onPublicMessage);
		}
		
		/**
		 * The users constructor. 
		 * Override awake and create any variables and listeners.
		 */
		public override function awake():void
		{
		}
		
		/**
		 * The users start method. 
		 * Start runs when the game object is added to the scene.
		 */
		public override function start():void
		{
		}

		/**
		 * The users stop method.
		 * Stop runs when the game object is added to the scene.
		 */
		public override function stop():void
		{
		}

		/**
		 * The users destructor. 
		 * Override destroy to clean up any variables or listeners.
		 */
		public override function destroy():void
		{
		}

		/**
		 * Send a chat message to the room
		 * @param	message
		 */
		public final function sendChatMessage( message:* ):void
		{
			var request:PublicMessageRequest = new PublicMessageRequest(message);
			_networkEventHandler.sendServerMessage(request);
		}
		
		/**
 		 * On public message, show it in the chat area.
 		 */
		private function onPublicMessage(evt:SFSEvent):void
		{
			trace(evt.params.sender + " - " + evt.params.message );
			_networkEventHandler.fireEvent(NetworkEvent.RECEIVED_CHAT_MESSAGE, new ChatMessageModel( evt.params.sender, evt.params.message ) );
		}		
	}
}