package core 
{
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.SmartFox;

	import core.BaseObject;
	import handlers.ConnectionHandler;
	import handlers.LoginHandler;
	import handlers.RoomHandler;

	public class NetworkManager extends ContainerObject
	{
		/****************************************/
		// Dependency Information
		/****************************************/

		/**
		 * Return the class scope
		 */
		public static function get scope():int { return SINGLETON_OBJECT };
		
		
		/****************************************/
		// Overide function
		/****************************************/
		
		private var _sfs:SmartFox = new SmartFox(true);
		
		/**
		* Awake is called at the construction of the object
		*/
		public override function engine_awake():void
		{
			super.engine_awake();
		}
		
		/**
		* Destroy is called at the removal of the object
		*/	
		public override function engine_destroy():void
		{
			super.engine_destroy();
		}
		
		/**
		 * Get the smartfox server
		 */
		public function get sfs():SmartFox { return _sfs; }

		/** 
		 * Connect to the server
		 */
		public function connect():void
		{
			if ( getComponent( CONNECTION_HANDLER ) != null ) 
			{
				getComponent( CONNECTION_HANDLER ).connect();
			}
		}
		
		/**
		 * Disconnect from the server
		 */
		private function disconnect():void
		{
			getComponent( CONNECTION_HANDLER ).disconnect();
		}		
		
		/**
		* Join the passed room.
		*/
		public function joinRoom(name:String = ""):void
		{
			getComponent( ROOM_HANDLER ).joinRoom(name);
		}	
		
		/**
		 * Login to the server
		 * @param	userName (String) Users name
		 * @param	password (String) Users password
		 */
		public function login(userName:String, password:String):void
		{
			getComponent( LOGIN_HANDLER ).login(userName, password);
		}
		
		/**
		 * Create a game room
		 * 
		 * @param	roomName (String) Room name
		 * @param	roomPwd (String Room password
		 * @param	roomMaxS (int) Room Max size 
		 * @param	extensionId (String) The module name
		 * @param	extensionClass (String) The fully qualified class
		 */
		public function createGameRoom(roomName:String, roomPwd:String=null, roomMaxS:int=0, extensionId:String="sfsChess", extensionClass:String = "sfs2x.extensions.games.tris.SFSTrisGame"):void
		{
			getComponent( ROOM_HANDLER ).createGameRoom(roomName, roomPwd, roomMaxS, extensionId, extensionClass);
		}
		
		/**
		* Leave game and return them to the lobby
		* Join the lobby room. 
		*/
		private function leaveGameRoom():void
		{
			getComponent( ROOM_HANDLER ).leaveGameRoom();
		}		

		public function backToLoginScreen():void {}		
				
	}
}

