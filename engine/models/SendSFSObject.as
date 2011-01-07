package models 
{
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.entities.Room;
	/**
	 * ...
	 * @author ...
	 */
	public class SendSFSObject
	{
		private var _eventName:String;
		private var _sfsObject:*;
		private var _room:Room;
		
		public function SendSFSObject(eventName:String, sfsObject:SFSObject, room:Room=null ) 
		{
			_eventName = eventName;
			_sfsObject = sfsObject;
			_room = room;
		}
		
		public function get eventName():String { return _eventName; }
		
		public function set eventName(eventName:String):void 
		{
			_eventName = eventName;
		}
		
		public function get sfsObject():* { return _sfsObject; }
		
		public function set sfsObject(sfsObject:SFSObject):void 
		{
			_sfsObject = sfsObject;
		}
		
		public function get room():Room { return _room; }
		
		public function set room(room:Room):void 
		{
			_room = room;
		}
		
	}

}