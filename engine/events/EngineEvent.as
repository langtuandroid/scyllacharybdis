package events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class EngineEvent extends Event 
	{
		public static const AWAKE:int = 0;
		public static const DESTROY:int = 1;
		public static const START:int = 2;
		public static const STOP:int = 3;
		public static const UPDATE:int = 4;
		
		protected var _data:Object;
		
		public function get data():Object { return _data; }
		
		public function EngineEvent(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
	}

}