package 
{
	import core.BaseObject;
	import core.SceneManager
	
	/**
	 */
	public class TestSceneLoader extends  BaseObject
	{
		/****************************************/
		// Dependency Information
		/****************************************/
		
		/**
		 * Return the class scope
		 */
		public static function get scope():int { return SINGLETON_OBJECT };		
		
		/**
		 * Return the class dependencies
		 */
		public static function get dependencies():Array  
		{
			return [SceneManager];
		}
		
		/****************************************/
		// Constructors and Allocation 
		/****************************************/			
		
		/**
		* Awake is called at the construction of the object
		*/
		public override function awake( ):void
		{
			getDependency(SceneManager).loadScene("gamescene");
		}
		
		/**
		* Destroy is called at the destruction of the object
		*/
		public override function destroy():void 
		{
		}			
	}
}