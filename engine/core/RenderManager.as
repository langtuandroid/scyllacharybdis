package core 
{
	import flash.utils.Dictionary;

	import core.BaseObject;	
	
	/**
	 */
	public class RenderManager extends BaseObject
	{
		/****************************************/
		// Dependency Information
		/****************************************/
		
		/**
		 * Return the class scope
		 */
		public static function get scope():int { base.SINGLETON_OBJECT };
		
		/**
		 * Return the class dependencies
		 * @returns [dep1, dep2,etc..];
		 */
		public static function get dependencies():Array  {
			return [SceneGraph];	
		}
		
		/****************************************/
		// Constructors and Allocation 
		/****************************************/
		
		private var _sceneGraph:SceneGraph;
		
		/**
		* Awake is called at the construction of the object
		*/
		public override function awake( ):void
		{
			_sceneGraph = getDependency(SceneGraph);
		}
		
		public override function destroy():void 
		{
			_sceneGraph = null;
		}
	}
}