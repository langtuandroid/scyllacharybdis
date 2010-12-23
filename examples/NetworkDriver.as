package  
{
	import core.objects.BaseObject;
	import core.EventManager;
	import models.CreateRoomModel;
	import models.LoginModel;
	import models.RoomModel;
	
	
	/**
	*/
	public class NetworkDriver extends BaseObject
	{
		private var _eventManager:EventManager;
		private var _roomName:String = "The Lobby";

		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public final override function engine_awake():void
		{
			// Get the event manager
			_eventManager = getDependency(EventManager);
			super.engine_start();
			
			_eventManager.registerListener("CONNECTION_SUCCESS", this, connectionSuccess );
			_eventManager.registerListener("CONNECTION_FAILED", this, connectionFailed );
			_eventManager.registerListener("LOGIN_SUCCESS", this, loginSuccess );
			_eventManager.registerListener("LOGIN_FAILED", this, loginFailed );
			_eventManager.registerListener("JOINROOM_SUCCESS", this, joinRoomSuccess );
			_eventManager.registerListener("JOINROOM_FAILED", this, joinRoomFailed );
			_eventManager.registerListener("JOINGAMEROOM_SUCCESS", this, joinGameRoomSuccess );
			_eventManager.registerListener("JOINGAMEROOM_FAILED", this, joinGameRoomFailed );
			
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
			_eventManager.unregisterListener("CONNECTION_SUCCESS", this, connectionSuccess );
			_eventManager.unregisterListener("CONNECTION_FAILED", this, connectionFailed );
			_eventManager.unregisterListener("LOGIN_SUCCESS", this, loginSuccess );
			_eventManager.unregisterListener("LOGIN_FAILED", this, loginFailed );
			_eventManager.unregisterListener("JOINROOM_SUCCESS", this, joinRoomSuccess );
			_eventManager.unregisterListener("JOINROOM_FAILED", this, joinRoomFailed );
			_eventManager.unregisterListener("JOINGAMEROOM_SUCCESS", this, joinGameRoomSuccess );
			_eventManager.unregisterListener("JOINGAMEROOM_FAILED", this, joinGameRoomFailed );
			
			super.engine_destroy();
		}		
		
		
		/**
		 * Connection success event handler
		 */
		public function connectionSuccess( data:* ):void
		{
			trace("Network Driver: connectionSuccess");
			_eventManager.fireEvent( "NETWORK_LOGIN", new LoginModel("ben", "test", 1) );
			//_eventManager.fireEvent( "NETWORK_LOGIN", new LoginModel("ben1", "test", 1) );
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
			_eventManager.fireEvent( "NETWORK_JOINROOM", new RoomModel(_roomName) );
			//_eventManager.fireEvent( "NETWORK_JOINROOM", new RoomModel("TestGameRoom") );
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
			_eventManager.fireEvent( "NETWORK_CREATEROOM", new CreateRoomModel("TestGameRoom", "", 2, "sfsChess", "com.pikitus.games.chess.SFSChess") );
			
			//_eventManager.fireEvent("SEND_CHATMESSAGE", "this is a test message");
			
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
