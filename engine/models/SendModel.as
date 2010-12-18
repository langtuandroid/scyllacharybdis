package models 
{
	import com.smartfoxserver.v2.entities.Room;
	/**
	 * ...
	 * @author ...
	 */
	public class SendModel 
	{
		private var _eventName:String;
		private var _modelName:String;
		private var _model:*;
		private var _room:Room;
		
		public function SendModel(eventName:String, modelName:String, model:*, room:Room=null ) 
		{
			_eventName = eventName;
			_modelName = modelName;
			_model = model;
			_room = room;
		}
		
		public function get eventName():String { return _eventName; }
		
		public function set eventName(eventName:String):void 
		{
			_eventName = eventName;
		}
		
		public function get modelName():String { return _modelName; }
		
		public function set modelName(modelName:String):void 
		{
			_modelName = modelName;
		}
		
		public function get model():* { return _model; }
		
		public function set model(model:*):void 
		{
			_model = model;
		}
		
		public function get room():Room { return _room; }
		
		public function set room(room:Room):void 
		{
			_room = room;
		}
		
	}

}