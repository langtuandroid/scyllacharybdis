package  
{
	/**
	 * Component Baseclass. Extend this to create a new component type.
	 * 
	 * @author Daniel Lamb
	 */
	public class Component
	{
		public static const COMPONENT:Number = 0;
		public static const RENDER_COMPONENT:Number = 1;
		public static const SCRIPT_COMPONENT:Number = 2;

		protected var mSceneObject:SceneObject = null;
		
		public function get sceneObject():SceneObject { return mSceneObject; }
		public function set sceneObject( value:SceneObject ):void { mSceneObject = value; }
		
		public function get type():Number { return COMPONENT; }
		
		public function Component() 
		{
			
		}
		
		public function Update():void
		{
			
		}
	}
}