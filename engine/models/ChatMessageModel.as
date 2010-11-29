package models 
{
	/**
	 */
	public class ChatMessageModel 
	{
		private var _name:String;
		private var _message:String;
		
		/**
		 * Room Model constructor
		 * @param	name
		 */
		public function ChatMessageModel(name:String, message:String):void
		{
			_name = name;
			_message = message;
		}
		
		public function get name():String { return _name; };
		public function get message():String { return _message; };
	}

}