package Engine 
{
	/**
	 * Component base class. Extend this to create a new component type.
	 */
	public class Component extends BaseObject
	{
		protected var _owner:SceneObject = null;
		
		public function get owner():SceneObject { return _owner; }
		public function set owner( value:SceneObject ):void { _owner = value; }
		
		public function get type():Number { return COMPONENT; }
		
		public function update():void
		{
			
		}
	}
}