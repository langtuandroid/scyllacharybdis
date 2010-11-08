package engine.handlers 
{
	/**
	 */
	public class RoomHandler extends Handler
	{
		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public override function awake():void
		{
			NetworkManager.sfs.addEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreationError);
			NetworkManager.sfs.addEventListener(SFSEvent.ROOM_JOIN, onJoinRoom);
			NetworkManager.sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, onJoinRoomError);
		}
		
		/**
		* Destroy is called at the removal of the object
		* Unregister listeners
		*/
		public override function destroy():void
		{
			NetworkManager.sfs.removeEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreationError);
			NetworkManager.sfs.removeEventListener(SFSEvent.ROOM_JOIN, onJoinRoom);
			NetworkManager.sfs.removeEventListener(SFSEvent.ROOM_JOIN_ERROR, onJoinRoomError);
		}
		
		/**
		 * onRoomCreationError event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onRoomCreationError(evt:SFSEvent):void
		{
			NetworkManager.sfs.dTrace("===> " + evt.params.errorMessage);
			NetworkManager.sfs.dTrace("Room creation error:\n" + evt.params.error);
		}

		/**
		 * onJoinRoomError event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onJoinRoomError(evt:SFSEvent):void
		{
			NetworkManager.sfs.dTrace("Room join error:\n" + evt.params.errorMessage);
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