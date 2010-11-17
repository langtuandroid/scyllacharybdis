package core 
{
	import flash.utils.Dictionary;
	
	public class EventManager extends BaseObject
	{
		private var _listeners:Dictionary = new Dictionary();
		
		public function registerListener( eventName:String, listener:*, method:Function ):void
		{
			_listeners[[eventName],[listener]] = method;
		}
		
		public function unregisterListener( eventName:String, listener:*, method:Function ):void
		{
			_listeners[[eventName],[listener]] = null;
			delete _listeners[[eventName],[listener]];
		}
		
		public function fireEvent( eventName:String, data:* ):void
		{
			var listeners:Dictionary = _listeners[eventName];
			for each ( var listener:* in listeners ) 
			{
				var method:Function = _listeners[eventName][listener];
				trace(method);
				if ( method != null ) 
				{
					listener.method( data );
				}
			}
		}
	}
}