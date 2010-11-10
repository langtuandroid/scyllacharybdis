package base 
{
	import base.BaseObject;
	import base.GameObject;
	
	/**
	 * Component base class. Extend this to create a new component type.
	 */
	public class Component extends BaseObject
	{
		protected var _owner:GameObject = null;
		
		/**
		 * Get the ownering Game Object
		 */
		public function get owner():GameObject { return _owner; }

		/**
		 * Set the ownering Game Object
		 */
		public function set owner( value:GameObject ):void { _owner = value; }
		
	}
}