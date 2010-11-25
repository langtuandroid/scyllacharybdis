package handlers 
{
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.PublicMessageRequest;

	import core.NetworkObject;
	import core.BaseObject;	
	import core.EventManager;
	import models.GameRoomModel;
	import models.RoomModel;
	import models.ChatMessageModel;

	/**
	*/
	public class ChatMessageHandler extends BaseObject
	{
		/****************************************/
		// Type definition
		/****************************************/
		
		public override function getType():String 
		{
			return CHATMESSAGE_HANDLER;
		}
		
		/****************************************/
		// Class Details
		/****************************************/

		private var _eventManager:EventManager;

		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public final override function engine_awake():void
		{
			// Get the event manager
			_eventManager = getDependency(EventManager);
			
			owner.sfs.addEventListener(SFSEvent.PUBLIC_MESSAGE, onPublicMessage);
			
			super.engine_start();
			
			_eventManager.registerListener("SEND_CHATMESSAGE", this, sendChatMessage );
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
			_eventManager.unregisterListener("SEND_CHATMESSAGE", this, sendChatMessage );

			super.engine_destroy();
			
			owner.sfs.removeEventListener(SFSEvent.PUBLIC_MESSAGE, onPublicMessage);
		}
		
		public final function sendChatMessage( message:* ):void
		{
			var request:PublicMessageRequest = new PublicMessageRequest(message);
			owner.sfs.send(request);
		}
		
		/**
		* On public message, show it in the chat area.
		*/
		private function onPublicMessage(evt:SFSEvent):void
		{
			trace(evt.params.sender + " - " + evt.params.message );
			_eventManager.fireEvent("RECEIVED_CHATMESSAGE", new ChatMessageModel( evt.params.sender, evt.params.message ) );
		}		
	}
}