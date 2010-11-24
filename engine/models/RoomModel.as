package models 
{
	/**
	 */
	public class RoomModel 
	{
		private var _name:String;
		public function RoomModel(name:String) 
		{
			_name = name;
		}
		
		public function get name():String { return _name; };
	}

}