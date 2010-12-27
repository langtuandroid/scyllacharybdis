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
		private var _dependencies:Dictionary = null;
		private var _depList:Dictionary = new Dictionary();

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
		
		public function get dependencies():Dictionary { return _dependencies; }

		public function set dependencies(value:Dictionary):void 
		{
			_dependencies = value;
		}

		public function addDependencyClass( value:Class ):void
		{
			_depList[value] = value;
		}
		
		public function getDependencyClass():Dictionary
		{
			return _depList;
		}
	}
}