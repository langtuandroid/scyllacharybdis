package core 
{
	
	public class AllocationDetails
	{
		private var _singleton:Boolean;
		private var _object:*;
		private var _requirements:Array;
		private var _componentType:Class;
		private var _counter:int = 0;
		
		public function get singleton():Boolean 
		{
			return _singleton;
		}
		public function set singleton( value:Boolean ):void
		{
			if ( componentType ) 
			{
				trace("can't have a singleton component");
				return;
			}
			_singleton = value;
		}
		public function get object():* 
		{
			return _object;
		}
		public function set object( value:* ):void
		{
			_object = value;
		}
		
		public function get requirements():Array
		{
			return _requirements;
		}
		public function set requirements( value:Array ):void
		{
			_requirements = value;
		}
		
		public function get componentType():Class 
		{
			return _componentType;
		}
		public function set componentType( value:Class ):void
		{
			if ( singleton == true ) 
			{
				trace("can't have a singleton component");
				_singleton = false;
			}
			_componentType = value;
		}		

		public function getCounter():int
		{
			return _counter;
		}
		
		public function incrementCounter():void
		{
			_counter++;
		}
		public function decrementCounter():void
		{
			_counter--;
		}		
		
	}
}