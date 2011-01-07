package intro  
{
	import core.events.EventHandler;
	import core.events.NetworkEvent;
	import core.events.NetworkEventHandler;
	import core.objects.BaseObject;
	import models.CreateRoomModel;
	import models.LoginModel;
	import models.RoomModel;
	
	
	/**
	*/
	[Requires ("core.events.EventHandler")]
	public class NetworkDriver extends BaseObject
	{
		private var _networkEventHandler:NetworkEventHandler;
		private var _roomName:String = "The Lobby";

		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public final override function engine_awake():void
		{
			// Get the event manager
			_networkEventHandler = getDependency(NetworkEventHandler);
			super.engine_start();
			
			_networkEventHandler.addEventListener(NetworkEvent.CONNECTION_SUCCESS, this, connectionSuccess );
			_networkEventHandler.addEventListener(NetworkEvent.CONNECTION_FAILED, this, connectionFailed );
			_networkEventHandler.addEventListener(NetworkEvent.LOGIN_SUCCESS, this, loginSuccess );
			_networkEventHandler.addEventListener(NetworkEvent.LOGIN_FAILED, this, loginFailed );
			_networkEventHandler.addEventListener(NetworkEvent.JOINROOM_SUCCESS, this, joinRoomSuccess );
			_networkEventHandler.addEventListener(NetworkEvent.JOINROOM_FAILED, this, joinRoomFailed );
			_networkEventHandler.addEventListener(NetworkEvent.JOINGAMEROOM_SUCCESS, this, joinGameRoomSuccess );
			_networkEventHandler.addEventListener(NetworkEvent.JOINGAMEROOM_FAILED, this, joinGameRoomFailed );
			
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
			_networkEventHandler.removeEventListener(NetworkEvent.CONNECTION_SUCCESS, this, connectionSuccess );
			_networkEventHandler.removeEventListener(NetworkEvent.CONNECTION_FAILED, this, connectionFailed );
			_networkEventHandler.removeEventListener(NetworkEvent.LOGIN_SUCCESS, this, loginSuccess );
			_networkEventHandler.removeEventListener(NetworkEvent.LOGIN_FAILED, this, loginFailed );
			_networkEventHandler.removeEventListener(NetworkEvent.JOINROOM_SUCCESS, this, joinRoomSuccess );
			_networkEventHandler.removeEventListener(NetworkEvent.JOINROOM_FAILED, this, joinRoomFailed );
			_networkEventHandler.removeEventListener(NetworkEvent.JOINGAMEROOM_SUCCESS, this, joinGameRoomSuccess );
			_networkEventHandler.removeEventListener(NetworkEvent.JOINGAMEROOM_FAILED, this, joinGameRoomFailed );
			
			
			super.engine_destroy();
		}		
		
		
		/**
		 * Connection success event handler
		 */
		public function connectionSuccess( data:* ):void
		{
			trace("Network Driver: connectionSuccess");
			_networkEventHandler.fireEvent( NetworkEvent.LOGIN, new LoginModel("ben", "test", 1) );
			//_eventHandler.fireEvent( "NETWORK_LOGIN", new LoginModel("ben1", "test", 1) );
		}

		/**
		 * Connection failed event handler
		 */
		public function connectionFailed( data:* ):void
		{
			trace("Network Driver: connectionFailed");
		}

		/**
		 * Login success event handler
		 */
		public function loginSuccess( data:* ):void
		{
			trace("Network Driver: loginSuccess");
			_eventHandler.fireEvent( "NETWORK_JOINROOM", new RoomModel(_roomName) );
			//_eventHandler.fireEvent( "NETWORK_JOINROOM", new RoomModel("TestGameRoom") );
		}

		/**
		 * Login failed event handler
		 */
		public function loginFailed( data:* ):void
		{
			trace("Network Driver: loginFailed");
		}
		
		/**
		 * Join room success event handler
		 */
		public function joinRoomSuccess( data:* ):void
		{
			trace("Network Driver: joinRoomSuccess");
			
			// Commented out the start game since we want to have a chat message ( this works just need a button to attach it to ).
			_eventHandler.fireEvent( "NETWORK_CREATEROOM", new CreateRoomModel("TestGameRoom", "", 2, "sfsChess", "com.pikitus.games.chess.SFSChess") );
			
			//_eventHandler.fireEvent("SEND_CHATMESSAGE", "this is a test message");
			
		}

		/**
		 * Join room failed event handler
		 */
		public function joinRoomFailed( data:* ):void
		{
			trace("Network Driver: joinRoomFailed");
		}
		
		/**
		 * Join game room success event handler
		 */
		public function joinGameRoomSuccess( data:* ):void
		{
			trace("Network Driver: joinGameRoomSuccess");
		}

		/**
		 * Join game room failed event handler
		 */
		public function joinGameRoomFailed( data:* ):void
		{
			trace("Network Driver: joinGameRoomFailed");
		}		
		
	}
}
