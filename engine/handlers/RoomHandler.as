package handlers 
{
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	import core.NetworkManager;
	import core.BaseObject;	


	/**
	*/
	public class RoomHandler extends BaseObject
	{

		/****************************************/
		// Type definition
		/****************************************/
		public override function get type():String 
		{
			return ROOM_HANDLER;
		}
		
		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public override function awake():void
		{
			owner.sfs.addEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreationError);
			owner.sfs.addEventListener(SFSEvent.ROOM_JOIN, onJoinRoom);
			owner.sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, onJoinRoomError);
		}
		
		/**
		* Destroy is called at the removal of the object
		* Unregister listeners
		*/
		public override function destroy():void
		{
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
		private function joinRoom(name:String):void
		{
			_roomName = name;
			var request:JoinRoomRequest = new JoinRoomRequest(name);
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
				settings.extension = new RoomExtension(EXTENSION_ID, EXTENSIONS_CLASS)
				
				owner.ssfs.send( new CreateRoomRequest(settings, true, sfs.lastJoinedRoom) )
			}		
		}
		
		/**
		* Leave game and return them to the lobby
		* Join the lobby room. 
		*/
		private function leaveGameRoom(name:String = ""):void
		{
			if ( name == null ) {
				name = _roomName;
			}
			
			var request:JoinRoomRequest = new JoinRoomRequest(THE_LOBBY_NAME);
			owner.ssfs.send(request);
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
			owner.sfs.dTrace("===> " + evt.params.errorMessage);
			owner.sfs.dTrace("Room creation error:\n" + evt.params.error);
		}

		/**
		 * onJoinRoomError event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onJoinRoomError(evt:SFSEvent):void
		{
			owner.sfs.dTrace("Room join error:\n" + evt.params.errorMessage);
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