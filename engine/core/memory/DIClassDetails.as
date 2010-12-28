package core.memory 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	public class DIClassDetails 
	{
		private var _className:Class = null;
		private var _singleton:Boolean = false;
		private var _componentType:Class = null;
		private var _dependencies:Dictionary = new Dictionary();

		public function get className():Class { return _className; }
		
		public function set className(value:Class):void 
		{
			_className = value;
		}
		
		public function get singleton():Boolean { return _singleton; }
		
		public function set singleton(value:Boolean):void 
		{
			_singleton = value;
		}
		
		public function get componentType():Class { return _componentType; }
		
		public function set componentType(value:Class):void 
		{
			_componentType = value;
		}
		
		public function addDependency( value:Class ):void
		{
			_dependencies[value] = value;
		}
		
		public function getDependencies():Dictionary
		{
			return _dependencies;
		}
	}
}