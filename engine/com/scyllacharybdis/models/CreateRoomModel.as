package com.scyllacharybdis.models 
{
	/**
	 */
	public class CreateRoomModel 
	{
		private var _name:String;
		private var _roomPass:String;
		private var _maxSize:int;
		private var _extensionId:String;
		private var _extensionClass:String;
		
		/**
		 * Create a Room model constructor
		 * @param	roomName (String) The Room name
		 * @param	roomPwd (String) The password for the room
		 * @param	roomMaxS (int) The max number of users in this room
		 * @param	extensionId (String) The extension id. Example: sfsTris
		 * @param	extensionClass (String) The extension class. Example: sfs2x.extensions.games.tris.SFSTrisGame
		 */
		public function CreateRoomModel(roomName:String, roomPwd:String=null, roomMaxS:int=0, extensionId:String="", extensionClass:String = "") 
		{
			_name = roomName;
			_roomPass = roomPwd;
			_maxSize = roomMaxS;
			_extensionId = extensionId;
			_extensionClass = extensionClass;
		}
		
		/**
		 * Get the room name
		 */
		public function get name():String { return _name; };
		
		/**
		 * Get the room password
		 */
		public function get roomPass():String { return _roomPass; };
		
		/**
		 * Get the max room size
		 */
		public function get maxSize():int { return _maxSize; };
		
		/**
		 * Get the extention id 
		 */
		public function get extensionId():String { return _extensionId; };
		
		/**
		 * Get the extention class
		 */
		public function get extensionClass():String { return _extensionClass; };
	}
}