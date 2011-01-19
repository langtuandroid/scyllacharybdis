package com.scyllacharybdis.core.composite 
{
	import com.scyllacharybdis.interfaces.IBaseComponent;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author 
	 */
	public class CompositeObject 
	{
		private var _components:Dictionary = new Dictionary(true);
		
		public function addComponent( type:Class, object:IBaseComponent  ):void
		{
			_components[type] = object;
		}
		
		public function removeComponent( type:Class ):void
		{
			_components[type] = null;
		}
		
		public function getComponent( type:Class ):IBaseComponent
		{
			return _components[type];
		}
		
		public function getComponents():Dictionary
		{
			return _components;
		}
		
		public function awakeComponents():void
		{
			for each ( var comp:IBaseComponent in _components )
			{
				comp.awake(this);
			}
		}
		public function updateComponents():void
		{
			for each ( var comp:IBaseComponent in _components )
			{
				comp.update();
			}
		}
		public function destroyComponents():void
		{
			for each ( var comp:IBaseComponent in _components )
			{
				comp.destroy();
			}
		}
	}
}