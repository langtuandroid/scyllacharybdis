package core 
{
	/**
	 * Callback object for handing loading
	 * @author 
	 */
	public class Callback 
	{
		private var _object:*;
		private var _method:Function;
		
		public function Command(object:*, method:Function) 
		{
			_object = object;
			_method = method;
		}
		
		public function get object():* { return _object; }
		
		public function set object(value:*):void 
		{
			_object = value;
		}
		
		public function get method():Function { return _method; }
		
		public function set method(value:Function):void 
		{
			_method = value;
		}
		
	}

}