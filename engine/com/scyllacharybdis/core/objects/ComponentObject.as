package com.scyllacharybdis.core.objects 
{
	/**
	 * ...
	 * @author 
	 */
	public class ComponentObject extends BaseObject
	{
		private var _owner:Object;
		
		/**
		 * Get the owner of the component
		 */
		public final function get owner():Object { return _owner; }
		
		/**
		 * Set the owner of the component
		 */
		public final function set owner(value:Object):void 
		{
			_owner = value;
		}
		
		/**
		 * Get the component type
		 */
		public final function getComponentType():Class
		{
			return getClassDetails().componentType;
		}		
		
	}

}