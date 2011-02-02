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
		public static const CONNECT_REQUEST : String = "CONNECTION_REQUEST";
		public static const DISCONNECT_REQUEST : String = "DISCONNECT_REQUEST";
		public static const CONNECTION_REQUEST_SUCCESS : String = "CONNECTION_SUCCESS";
		public static const CONNECTION_REQUEST_FAILED : String = "CONNECTION_FAILED";

		// Authentication events
		public static const LOGIN_REQUEST : String = "LOGIN";
		public static const LOGOUT_REQUEST : String = "LOGOUT";
		public static const LOGIN_REQUEST_SUCCESS : String = "LOGIN_SUCCESS";
		public static const LOGIN_REQUEST_FAILED : String = "LOGIN_FAILED";
		
		// Room events
		public static const CREATE_ROOM_REQUEST : String = "CREATEROOM";
		public static const JOIN_ROOM_REQUEST : String = "JOINROOM";
		public static const LEAVE_ROOM_REQUEST : String = "LEAVBROOM";
		public static const JOIN_ROOM_REQUEST_SUCCESS : String = "JOINROOM_SUCCESS";
		public static const JOIN_ROOM_REQUEST_FAILED : String = "JOINROOM_FAILED";
		public static const JOIN_GAME_ROOM_REQUEST_SUCCESS : String = "JOINGAMEROOM_SUCCESS";
		public static const JOIN_GAME_ROOM_REQUEST_FAILED : String = "JOINGAMEROOM_FAILED";

		// Chat message events
		public static const SEND_CHAT_MESSAGE_REQUEST : String = "SEND_CHAT_MESSAGE";
		public static const RECEIVED_CHAT_MESSAGE_REQUEST : String = "RECEIVED_CHAT_MESSAGE";

		/*******************************/
		// Smartfox message 
		/*******************************/
		public static const ADMIN_MESSAGE : String = SFSEvent.ADMIN_MESSAGE;
		
		public static const CONFIG_LOAD_FAILURE : String = SFSEvent.CONFIG_LOAD_FAILURE;
		public static const CONFIG_LOAD_SUCCESS : String = SFSEvent.CONFIG_LOAD_SUCCESS;
		
		public static const CONNECTION : String = SFSEvent.CONNECTION;
		public static const CONNECTION_ATTEMPT_HTTP : String = SFSEvent.CONNECTION_ATTEMPT_HTTP;
		public static const CONNECTION_LOST : String = SFSEvent.CONNECTION_LOST;
		public static const CONNECTION_RESUME : String = SFSEvent.CONNECTION_RESUME;
		public static const CONNECTION_RETRY : String = SFSEvent.CONNECTION_RETRY;
		
		public static const EXTENSION_RESPONSE : String = SFSEvent.EXTENSION_RESPONSE;
		
		public static const HANDSHAKE : String = SFSEvent.HANDSHAKE;
		
		public static const INVITATION : String = SFSEvent.INVITATION;
		public static const INVITATION_REPLY : String = SFSEvent.INVITATION_REPLY;
		public static const INVITATION_REPLY_ERROR : String = SFSEvent.INVITATION_REPLY_ERROR;
		
		public static const LOGIN : String = SFSEvent.LOGIN;
		public static const LOGIN_ERROR : String = SFSEvent.LOGIN_ERROR;
		public static const LOGOUT : String = SFSEvent.LOGOUT;
		
		public static const MODERATOR_MESSAGE : String = SFSEvent.MODERATOR_MESSAGE;
		public static const OBJECT_MESSAGE : String = SFSEvent.OBJECT_MESSAGE;
		
		public static const PLAYER_TO_SPECTATOR : String = SFSEvent.PLAYER_TO_SPECTATOR;
		public static const PLAYER_TO_SPECTATOR_ERROR : String = SFSEvent.PLAYER_TO_SPECTATOR_ERROR;
		
		public static const PRIVATE_MESSAGE : String = SFSEvent.PRIVATE_MESSAGE;
		public static const PUBLIC_MESSAGE : String = SFSEvent.PUBLIC_MESSAGE;
		
		public static const ROOM_ADD : String = SFSEvent.ROOM_ADD;
		public static const ROOM_CAPACITY_CHANGE : String = SFSEvent.ROOM_CAPACITY_CHANGE;
		public static const ROOM_CAPACITY_CHANGE_ERROR : String = SFSEvent.ROOM_CAPACITY_CHANGE_ERROR;
		public static const ROOM_CREATION_ERROR : String = SFSEvent.ROOM_CREATION_ERROR;
		public static const ROOM_FIND_RESULT : String = SFSEvent.ROOM_FIND_RESULT;
		public static const ROOM_GROUP_SUBSCRIBE : String = SFSEvent.ROOM_GROUP_SUBSCRIBE;
		public static const ROOM_GROUP_SUBSCRIBE_ERROR : String = SFSEvent.ROOM_GROUP_SUBSCRIBE_ERROR;
		public static const ROOM_GROUP_UNSUBSCRIBE : String = SFSEvent.ROOM_GROUP_UNSUBSCRIBE;
		public static const ROOM_GROUP_UNSUBSCRIBE_ERROR : String = SFSEvent.ROOM_GROUP_UNSUBSCRIBE_ERROR;
		public static const ROOM_JOIN : String = SFSEvent.ROOM_JOIN;
		public static const ROOM_JOIN_ERROR : String = SFSEvent.ROOM_JOIN_ERROR;
		public static const ROOM_NAME_CHANGE : String = SFSEvent.ROOM_NAME_CHANGE;
		public static const ROOM_NAME_CHANGE_ERROR : String = SFSEvent.ROOM_NAME_CHANGE_ERROR;
		public static const ROOM_PASSWORD_STATE_CHANGE : String = SFSEvent.ROOM_PASSWORD_STATE_CHANGE;
		public static const ROOM_PASSWORD_STATE_CHANGE_ERROR : String = SFSEvent.ROOM_PASSWORD_STATE_CHANGE_ERROR;
		public static const ROOM_REMOVE : String = SFSEvent.ROOM_REMOVE;
		public static const ROOM_VARIABLES_UPDATE : String = SFSEvent.ROOM_VARIABLES_UPDATE;
		
		public static const SPECTATOR_TO_PLAYER : String = SFSEvent.SPECTATOR_TO_PLAYER;
		public static const SPECTATOR_TO_PLAYER_ERROR : String = SFSEvent.SPECTATOR_TO_PLAYER_ERROR;
		
		public static const UDP_INIT : String = SFSEvent.UDP_INIT;
		
		public static const USER_COUNT_CHANGE : String = SFSEvent.USER_COUNT_CHANGE;
		public static const USER_ENTER_ROOM : String = SFSEvent.USER_ENTER_ROOM;
		public static const USER_EXIT_ROOM : String = SFSEvent.USER_EXIT_ROOM;
		public static const USER_FIND_RESULT : String = SFSEvent.USER_FIND_RESULT;
		public static const USER_VARIABLES_UPDATE : String = SFSEvent.USER_VARIABLES_UPDATE;

		
		public function NetworkEvents(type:String, params:Object):void
		{
			super(type, params);
		}
		
	}

}