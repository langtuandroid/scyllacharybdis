package models 
{
	/**
	 */
	public class GameRoomModel 
	{
		private var _name:String;
		private var _roomPass:String;
		private var _maxSize:int;
		private var _extensionId:String;
		private var _extensionClass:String;
		
		public function GameRoomModel(roomName:String, roomPwd:String=null, roomMaxS:int=0, extensionId:String="sfsChess", extensionClass:String = "sfs2x.extensions.games.tris.SFSTrisGame") 
		{
			_name = name;
			_roomPass = roomPwd;
			_maxSize = roomMaxS;
			_extensionId = extensionId;
			_extensionClass = extensionClass;
		}
		
		public function get name():String { return _name; };
		public function get roomPass():String { return _roomPass; };
		public function get maxSize():int { return _maxSize; };
		public function get extensionId():String { return _extensionId; };
		public function get extensionClass():String { return _extensionClass; };
	}
}