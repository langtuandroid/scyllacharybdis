package com.scyllacharybdis.core.events 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class NetworkEvents extends SFSEvent
	{
		/*******************************/
		// SC message
		/*******************************/
		
		// Connection events
		public static const CONNECT_REQUEST : String = "CONNECT_REQUEST";
		public static const DISCONNECT_REQUEST : String = "DISCONNECT_REQUEST";
		public static const CONNECTION_REQUEST_SUCCESS : String = "CONNECTION_REQUEST_SUCCESS";
		public static const CONNECTION_REQUEST_FAILED : String = "CONNECTION_REQUEST_FAILED";

		// Authentication events
		public static const LOGIN_REQUEST : String = "LOGIN_REQUEST";
		public static const LOGOUT_REQUEST : String = "LOGOUT_REQUEST";
		public static const LOGIN_REQUEST_SUCCESS : String = "LOGIN_REQUEST_SUCCESS";
		public static const LOGIN_REQUEST_FAILED : String = "LOGIN_REQUEST_FAILED";
		
		// Room events
		public static const CREATE_ROOM_REQUEST : String = "CREATE_ROOM_REQUEST";
		public static const JOIN_ROOM_REQUEST : String = "JOIN_ROOM_REQUEST";
		public static const LEAVE_ROOM_REQUEST : String = "LEAVE_ROOM_REQUEST";
		public static const JOIN_ROOM_REQUEST_SUCCESS : String = "JOIN_ROOM_REQUEST_SUCCESS";
		public static const JOIN_ROOM_REQUEST_FAILED : String = "JOIN_ROOM_REQUEST_FAILED";
		public static const JOIN_GAME_ROOM_REQUEST_SUCCESS : String = "JOIN_GAME_ROOM_REQUEST_SUCCESS";
		public static const JOIN_GAME_ROOM_REQUEST_FAILED : String = "JOIN_GAME_ROOM_REQUEST_FAILED";

		// Chat message events
		public static const SEND_CHAT_MESSAGE_REQUEST : String = "SEND_CHAT_MESSAGE_REQUEST";
		public static const RECEIVED_CHAT_MESSAGE_REQUEST : String = "RECEIVED_CHAT_MESSAGE_REQUEST";
		
		public function NetworkEvents(type:String, params:Object):void
		{
			super(type, params);
		}
		
	}

}