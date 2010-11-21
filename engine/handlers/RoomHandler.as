package handlers 
{
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.JoinRoomRequest;
	import com.smartfoxserver.v2.requests.RoomSettings;
	import com.smartfoxserver.v2.requests.RoomExtension;
	import com.smartfoxserver.v2.requests.CreateRoomRequest;
	import com.smartfoxserver.v2.entities.Room;

	import core.NetworkManager;
	import core.BaseObject;	

	/**
	*/
	public class RoomHandler extends BaseObject
	{

		/****************************************/
		// Type definition
		/****************************************/
		public override function getType():String 
		{
			return ROOM_HANDLER;
		}
		
		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public override function engine_awake():void
		{
			owner.sfs.addEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreationError);
			owner.sfs.addEventListener(SFSEvent.ROOM_JOIN, onJoinRoom);
			owner.sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, onJoinRoomError);
			
			super.engine_start();
		}
		
		/**
		* Destroy is called at the removal of the object
		* Unregister listeners
		*/
		public override function engine_destroy():void
		{
			super.engine_destroy();

			owner.sfs.temoveEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreationError);
			owner.sfs.removeEventListener(SFSEvent.ROOM_JOIN, onJoinRoom);
			owner.sfs.removeEventListener(SFSEvent.ROOM_JOIN_ERROR, onJoinRoomError);
		}
		
		/****************************************/
		// Class specific
		/****************************************/
		
		private var _roomName:String;
		
		/**
		* Join the passed room.
		*/
		public function joinRoom(name:String):void
		{
			_roomName = name;
			var request:JoinRoomRequest = new JoinRoomRequest(name);
			trace("sending join room request: " + name );
			owner.sfs.send(request);
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
			if (roomName.length > 0)
			{
				var settings:RoomSettings = new RoomSettings(roomName)
				settings.groupId = "game"
				settings.password = roomPwd
				settings.isGame = true
				settings.maxUsers = 2
				settings.maxSpectators = roomMaxS
				settings.extension = new RoomExtension(extensionId, extensionClass)
				
				owner.ssfs.send( new CreateRoomRequest(settings, true, owner.sfs.lastJoinedRoom) )
			}		
		}
		
		/**
		* Leave game and return them to the lobby
		* Join the lobby room. 
		*/
		public function leaveGameRoom():void
		{
	
			var request:JoinRoomRequest = new JoinRoomRequest(owner.sfs.config.zone);
			owner.sfs.send(request);
		}		

		
		
		/****************************************/
		// Event Handlers
		/****************************************/
		
		/**
		 * onRoomCreationError event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onRoomCreationError(evt:SFSEvent):void
		{
			owner.dTrace("===> " + evt.params.errorMessage);
			owner.dTrace("Room creation error:\n" + evt.params.error);
		}

		/**
		 * onJoinRoomError event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onJoinRoomError(evt:SFSEvent):void
		{
			owner.dTrace("Room join error:\n" + evt.params.errorMessage);
		}

		/**
		 * onJoinRoom event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onJoinRoom(evt:SFSEvent):void
		{
			var room:Room = evt.params.room
			if (room.isGame)
			{
				// viewstack.selectedChild = view_game
				
				//if (gameViewInited) 
				// {
				//	initGame()
				// }
			}
		}		
	}
}