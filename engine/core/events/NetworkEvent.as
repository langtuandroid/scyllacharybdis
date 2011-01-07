package core.events 
{
	/**
	 * ...
	 * @author 
	 */
	public class NetworkEvent 
	{
		public static const NETWORK_CONNECT : String;
		public static const NETWORK_DISCONNECT : String;
		public static const NETWORK_LOGIN : String;
		public static const NETWORK_LOGOUT : String;
		public static const SEND_CHAT_MESSAGE : String;
		

		
		private var _type:String;
		
		public function NetworkEvents(type:String) 
		{
			_type = type;
		}
		
	}

}