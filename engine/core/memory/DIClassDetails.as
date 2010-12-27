package core.memory 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	public class DIClassDetails 
	{
		private var _className:Class;
		private var _singleton = false;
		private var _componentType:Class;
		private var _dependencies:Dictionary = new Dictionary();

		public function get className():Class { return _className; }
		
		public function set className(value:Class):void 
		{
			_className = value;
		}
		
		public function get singleton(): { return _singleton; }
		
		public function set singleton(value:):void 
		{
			_singleton = value;
		}
		
		public function get componentType():Class { return _componentType; }
		
		public function set componentType(value:Class):void 
		{
			_componentType = value;
		}
		
		public function get dependencies():Dictionary { return _dependencies; }

		private var addDependency( value:DIClassDetails )
		{
			_dependencies[value] = value;
		}
		
	}
}