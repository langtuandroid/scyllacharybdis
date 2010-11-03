package  
{
	/**
	 * Component base class. Extend this to create a new component type.
	 */
	public class Component extends ISCObject
	{
		public static const COMPONENT:Number = 0;
		public static const RENDER_COMPONENT:Number = 1;
		public static const SCRIPT_COMPONENT:Number = 2;

		protected var _owner:SceneObject = null;
		
		public function get owner():SceneObject { return _owner; }
		public function set owner( value:SceneObject ):void { _owner = value; }
		
		public function get type():Number { return COMPONENT; }
		
		public function Component() 
		{
			
		}
		
		public function update():void
		{
			
		}
	}
}