package com.scyllacharybdis.networking.handlers 
{
	import com.scyllacharybdis.constants.NetworkEvents;
	import com.scyllacharybdis.interfaces.IBaseObject;
	import com.scyllacharybdis.networking.models.ChatMessageModel;
	import com.scyllacharybdis.networking.NetworkEventHandler;
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.PublicMessageRequest;

	/**
	*/
	[Singleton]
	public class ChatMessageHandler implements IBaseObject
	{
		private var _networkEventHandler:NetworkEventHandler;

		/**
		 * Awake is called at the construction of the object
		 * Register all the listeners
		 * @private
		 */
		public function ChatMessageHandler(networkEventHandler:NetworkEventHandler):void
		{
			// Get the event manager
			_networkEventHandler = networkEventHandler;
		}
		
		public function awake():void
		{
			_networkEventHandler.addEventListener(SFSEvent.PUBLIC_MESSAGE, this, onPublicMessage);
			_networkEventHandler.addEventListener(NetworkEvents.SEND_CHAT_MESSAGE, this, sendChatMessage );
		}
		
		/**
		 * Destroy is called at the removal of the object
		 * Unregister listeners
		 * @private
		 */
		public final function destroy():void
		{
			_networkEventHandler.removeEventListener(NetworkEvents.SEND_CHAT_MESSAGE, this, sendChatMessage );
			_networkEventHandler.removeEventListener(SFSEvent.PUBLIC_MESSAGE, this, onPublicMessage);
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
			_networkEventHandler.fireEvent(NetworkEvents.RECEIVED_CHAT_MESSAGE, new ChatMessageModel( evt.params.sender, evt.params.message ) );
		}		
	}
}