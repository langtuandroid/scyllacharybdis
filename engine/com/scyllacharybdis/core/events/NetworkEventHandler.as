package com.scyllacharybdis.core.events 
{
	import com.scyllacharybdis.core.objects.BaseObject;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.SFSRoom;
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.util.ConfigData;
	import flash.utils.Dictionary;

	/**
	 */
	[Singleton]
	public class NetworkEventHandler extends EventHandler
	{
		// Smartfox server
		private var _sfs:SmartFox = new SmartFox();
		private var _debug:Boolean = false;

		/**
		 * The engine contructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			// Register event handlers
			_sfs.addEventListener(NetworkEvents.ADMIN_MESSAGE, onServerResponse);
			_sfs.addEventListener(NetworkEvents.CONFIG_LOAD_FAILURE, onServerResponse);
			_sfs.addEventListener(NetworkEvents.CONFIG_LOAD_SUCCESS, onServerResponse);
			_sfs.addEventListener(NetworkEvents.CONNECTION, onServerResponse);
			_sfs.addEventListener(NetworkEvents.CONNECTION_ATTEMPT_HTTP, onServerResponse);
			_sfs.addEventListener(NetworkEvents.CONNECTION_LOST, onServerResponse);
			_sfs.addEventListener(NetworkEvents.CONNECTION_RESUME, onServerResponse);
			_sfs.addEventListener(NetworkEvents.CONNECTION_RETRY, onServerResponse);
			_sfs.addEventListener(NetworkEvents.HANDSHAKE, onServerResponse);
			_sfs.addEventListener(NetworkEvents.INVITATION, onServerResponse);
			_sfs.addEventListener(NetworkEvents.INVITATION_REPLY, onServerResponse);
			_sfs.addEventListener(NetworkEvents.INVITATION_REPLY_ERROR, onServerResponse);
			_sfs.addEventListener(NetworkEvents.LOGIN, onServerResponse);
			_sfs.addEventListener(NetworkEvents.LOGIN_ERROR, onServerResponse);
			_sfs.addEventListener(NetworkEvents.LOGOUT, onServerResponse);
			_sfs.addEventListener(NetworkEvents.MODERATOR_MESSAGE, onServerResponse);
			_sfs.addEventListener(NetworkEvents.OBJECT_MESSAGE, onServerResponse);
			_sfs.addEventListener(NetworkEvents.PLAYER_TO_SPECTATOR, onServerResponse);
			_sfs.addEventListener(NetworkEvents.PLAYER_TO_SPECTATOR_ERROR, onServerResponse);
			_sfs.addEventListener(NetworkEvents.PRIVATE_MESSAGE, onServerResponse);
			_sfs.addEventListener(NetworkEvents.PUBLIC_MESSAGE, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_ADD, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_CAPACITY_CHANGE, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_CAPACITY_CHANGE_ERROR, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_CREATION_ERROR, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_FIND_RESULT, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_GROUP_SUBSCRIBE, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_GROUP_SUBSCRIBE_ERROR, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_GROUP_UNSUBSCRIBE, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_GROUP_UNSUBSCRIBE_ERROR, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_JOIN, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_JOIN_ERROR, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_NAME_CHANGE, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_NAME_CHANGE_ERROR, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_PASSWORD_STATE_CHANGE, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_PASSWORD_STATE_CHANGE_ERROR, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_REMOVE, onServerResponse);
			_sfs.addEventListener(NetworkEvents.ROOM_VARIABLES_UPDATE, onServerResponse);
			_sfs.addEventListener(NetworkEvents.SPECTATOR_TO_PLAYER, onServerResponse);
			_sfs.addEventListener(NetworkEvents.SPECTATOR_TO_PLAYER_ERROR, onServerResponse);
			_sfs.addEventListener(NetworkEvents.UDP_INIT, onServerResponse);
			_sfs.addEventListener(NetworkEvents.USER_COUNT_CHANGE, onServerResponse);
			_sfs.addEventListener(NetworkEvents.USER_ENTER_ROOM, onServerResponse);
			_sfs.addEventListener(NetworkEvents.USER_EXIT_ROOM, onServerResponse);
			_sfs.addEventListener(NetworkEvents.USER_FIND_RESULT, onServerResponse);
			_sfs.addEventListener(NetworkEvents.USER_VARIABLES_UPDATE, onServerResponse);

			_sfs.addEventListener(NetworkEvents.EXTENSION_RESPONSE, onExtensionResponse);
			
			super.engine_awake();
		}
		
		/**
		 * The engine start method
		 * @private
		 */
		public final override function engine_start():void
		{
			super.engine_start();
		}

		/**
		 * The engine stop function
		 * @private
		 */
		public final override function engine_stop():void
		{
			super.engine_stop();
		}

		/**
		 * Destroy is called at the removal of the object
		 * @private
		 */
		public final override function engine_destroy():void
		{
			super.engine_destroy();
			
			// Unregister all the event handlers
			_sfs.removeEventListener(NetworkEvents.ADMIN_MESSAGE, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.CONFIG_LOAD_FAILURE, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.CONFIG_LOAD_SUCCESS, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.CONNECTION, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.CONNECTION_ATTEMPT_HTTP, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.CONNECTION_LOST, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.CONNECTION_RESUME, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.CONNECTION_RETRY, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.HANDSHAKE, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.INVITATION, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.INVITATION_REPLY, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.INVITATION_REPLY_ERROR, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.LOGIN, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.LOGIN_ERROR, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.LOGOUT, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.MODERATOR_MESSAGE, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.OBJECT_MESSAGE, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.PLAYER_TO_SPECTATOR, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.PLAYER_TO_SPECTATOR_ERROR, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.PRIVATE_MESSAGE, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.PUBLIC_MESSAGE, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_ADD, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_CAPACITY_CHANGE, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_CAPACITY_CHANGE_ERROR, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_CREATION_ERROR, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_FIND_RESULT, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_GROUP_SUBSCRIBE, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_GROUP_SUBSCRIBE_ERROR, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_GROUP_UNSUBSCRIBE, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_GROUP_UNSUBSCRIBE_ERROR, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_JOIN, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_JOIN_ERROR, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_NAME_CHANGE, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_NAME_CHANGE_ERROR, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_PASSWORD_STATE_CHANGE, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_PASSWORD_STATE_CHANGE_ERROR, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_REMOVE, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.ROOM_VARIABLES_UPDATE, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.SPECTATOR_TO_PLAYER, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.SPECTATOR_TO_PLAYER_ERROR, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.UDP_INIT, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.USER_COUNT_CHANGE, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.USER_ENTER_ROOM, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.USER_EXIT_ROOM, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.USER_FIND_RESULT, onServerResponse);
			_sfs.removeEventListener(NetworkEvents.USER_VARIABLES_UPDATE, onServerResponse);

			_sfs.removeEventListener(NetworkEvents.EXTENSION_RESPONSE, onExtensionResponse);
			
		}
		
		/**
		 * Set the network debugging
		 * @param	value (Boolean) True = enable debug message.
		 */
		public final function setDebug( value:Boolean ):void
		{
			_debug = value;
			_sfs.debug = value;
		}

		/**
		 * Send a zone message
		 * @param	eventName (String) Server message name
		 * @param	data (SFSObject) Data to be sent to the server. Default = null 
		 */
		public final function sendZoneMessage(eventName:String, data:ISFSObject = null):void
		{
			if ( data == null ) 
			{
				data = SFSObject.newInstance();
			}			
			sendServerMessage( new ExtensionRequest(eventName, data) );				
		}
		
		/**
		 * Send a room message
		 * @param	eventName (String) Server message name
		 * @param	data (SFSObject) Data to be sent to the server. Default = null 
		 * @param   room (SFSRoom) The room to send the message too. By default it should be the current room
		 */
		public final function sendRoomMessage(eventName:String, data:ISFSObject = null, room:Room = null ):void
		{
			if ( data == null ) 
			{
				data = SFSObject.newInstance();
			}
			if ( room == null ) 
			{
				room = _sfs.lastJoinedRoom;
			}
			
			sendServerMessage( new ExtensionRequest(eventName, data, room) );				
		}
		
		/**
		 * Server response handler
		 * @param	evt (NetworkEvents) The data from the server
		 * @private
		 */
		public final function onServerResponse(evt:NetworkEvents):void
		{
			// Get the network message information
			var cmd:String = evt.params.cmd;

			if ( _debug ) 
			{
				trace( "onServerResponse command: " + cmd  );
				trace( "onServerResponse event: " + evt );
			}
			
			
			// Fire the event using the event name and pass the event object
			fireEvent(cmd, evt);
		}	
		
		/**
		 * Extension response handler
		 * @param	evt (NetworkEvents) The data from the server
		 * @private
		 */
		public final function onExtensionResponse(evt:NetworkEvents):void
		{
			// Get the network message information
			var params:ISFSObject = evt.params.params;
			var cmd:String = evt.params.cmd;
			
			if ( _debug ) 
			{
				trace( "onExtensionResponse command: " + cmd  );
				trace( "onExtensionResponse event: " + evt );
			}
			
			// Fire the event using the event name and pass the event object
			fireEvent(cmd, params);
		}			

		/**
		 * Get the configuration data
		 */
		public function get config():ConfigData
		{
			return _sfs.config;
		}
		
		/**
		 * Are we connected
		 */
		public function get isConnected():Boolean
		{
			return _sfs.isConnected;
		}
		
		/**
		 * Load the config from an xml file
		 * @param	filePath
		 * @param	connectOnSuccess
		 */
		public function loadConfig(filePath:String = "sfs-config.xml", connectOnSuccess:Boolean = true):void 
		{
			_sfs.loadConfig(filePath, connectOnSuccess);
		}
		
		/**
		 * Connect to the server
		 * @param	host
		 * @param	port
		 */
		public function connect(host:String = null, port:int = -1):void 
		{
			_sfs.connect(host, port);
		}
		
		/**
		 * Disconnect from the server
		 */
		public function disconnect():void 
		{
			_sfs.disconnect();
		}
		
		/**
		 * Send a server message
		 * @param	request (BaseRequest) The request object to be sent
		 */
		public final function sendServerMessage( request:BaseRequest ):void
		{
			_sfs.send(request);	
		}
		
	}
}