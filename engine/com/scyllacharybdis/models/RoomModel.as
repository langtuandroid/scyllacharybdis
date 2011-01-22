package com.scyllacharybdis.models 
{
	/**
	 */
	public class RoomModel 
	{
		private var _name:String;
		
		/**
		 * Room Model constructor
		 * @param	name (String) Room name to join.
		 */
		public function RoomModel(name:String) 
		{
			_name = name;
		}
		
		/**
		 * Get the room name
		 */
		public function get name():String { return _name; };
	}

}