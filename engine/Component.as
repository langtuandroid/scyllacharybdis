package Engine 
{
	/**
	 * Component base class. Extend this to create a new component type.
	 */
	public class Component extends BaseObject
	{
		protected var _owner:GameObject = null;
		
		public function get owner():GameObject { return _owner; }
		public function set owner( value:GameObject ):void { _owner = value; }
		
		public override function get type():int { return COMPONENT; }
	}
}