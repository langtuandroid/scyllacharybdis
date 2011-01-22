package com.scyllacharybdis.core.events 
{
	/**
	 * ...
	 * @author 
	 */
	public class NetworkEvents 
	{
		static public const ROOM_REMOVE:String = "roomRemove";
		static public const ROOM_ADD:String = "roomAdd";
		static public const USER_EXIT_ROOM:String = "userExitRoom";
		static public const USER_ENTER_ROOM:String = "userEnterRoom";
		static public const USERCOUNT_CHANGED:String = "usercountChanged";
		static public const CREATEROOM_SUCCESS:String = "createroomSuccess";
		// Connection events
		public static const CONNECT : String = "CONNECT";
		public static const DISCONNECT : String = "DISCONNECT";
		public static const CONNECTION_SUCCESS : String = "CONNECTION_SUCCESS";
		public static const CONNECTION_FAILED : String = "CONNECTION_FAILED";

		// Authentication events
		public static const LOGIN : String = "LOGIN";
		public static const LOGOUT : String = "LOGOUT";
		public static const LOGIN_SUCCESS : String = "LOGIN_SUCCESS";
		public static const LOGIN_FAILED : String = "LOGIN_FAILED";
		
		// Room events
		public static const CREATEROOM : String = "CREATEROOM";
		public static const JOINROOM : String = "JOINROOM";
		public static const LEAVBROOM : String = "LEAVBROOM";
		public static const JOINROOM_SUCCESS : String = "JOINROOM_SUCCESS";
		public static const JOINROOM_FAILED : String = "JOINROOM_FAILED";
		public static const JOINGAMEROOM_SUCCESS : String = "JOINGAMEROOM_SUCCESS";
		public static const JOINGAMEROOM_FAILED : String = "JOINGAMEROOM_FAILED";

		// Chat message events
		public static const SEND_CHAT_MESSAGE : String = "SEND_CHAT_MESSAGE";
		public static const RECEIVED_CHAT_MESSAGE : String = "RECEIVED_CHAT_MESSAGE";
		
		private var _type:String;
		
		public function NetworkEvents(type:String):void
		{
			_type = type;
		}
		
	}

}