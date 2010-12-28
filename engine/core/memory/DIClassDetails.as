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
		private var _componentType:String = null;
		private var _dependencies:Dictionary = new Dictionary();
		private var _depCounter:int = 0;
		
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
		
		public function get componentType():String { return _componentType; }
		
		public function set componentType(value:String):void 
		{
			_componentType = value;
		}
		
		public function addDependency( value:String ):void
		{
			if ( _dependencies[value] != null ) {
				return;
			}
			_depCounter++;
			_dependencies[value] = value;
		}
		
		public function getDependencies():Dictionary
		{
			return _dependencies;
		}
		
		public function getDependencyCount():int
		{
			return _depCounter;
		}
	}
}