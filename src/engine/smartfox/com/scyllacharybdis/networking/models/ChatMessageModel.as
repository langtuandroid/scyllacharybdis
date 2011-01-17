package com.scyllacharybdis.networking.models
{
	/**
	 */
	public class ChatMessageModel 
	{
		private var _name:String;
		private var _message:String;
		
		/**
		 * Room Model constructor
		 * @param	name (String) The players name that sent the message.
		 * @param   message (String) The message data.
		 */
		public function ChatMessageModel(name:String, message:String):void
		{
			_name = name;
			_message = message;
		}
		
		/**
		 * Get the name of the user that sent a message.
		 */
		public function get name():String { return _name; };
		
		/**
		 * Get the message content.
		 */
		public function get message():String { return _message; };
	}

}