package  
{
	class createRoom {
		
		private const EXTENSION_ID:String = "sfsChess"
		private const EXTENSIONS_CLASS:String = "sfs2x.extensions.games.chess.SFSChessGame"
		
		public function handleCreateRoom(evtEvent)void
		{
			var roomNameString = createGameWin[tf_roomName].text
			var roomPwdString = createGameWin[tf_roomPwd].text
			var roomMaxSint = createGameWin[ns_maxSpectators].value	
		
			if (roomName.length  0)
			{
				var settingsRoomSettings = new RoomSettings(roomName)
				settings.groupId = game
				settings.password = roomPwd
				settings.isGame = true
				settings.maxUsers = 2
				settings.maxSpectators = roomMaxS
				settings.extension = new RoomExtension(EXTENSION_ID, EXTENSIONS_CLASS)
			
				sfs.send( new CreateRoomRequest(settings, true, sfs.lastJoinedRoom) )
			
			}		
		}
	}
}