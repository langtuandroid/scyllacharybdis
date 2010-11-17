package 
{
	import core.BaseObject;
	import core.MaterialManager;

	/**
	 */
	public class TestMaterialLoader extends BaseObject
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
			return [MaterialManager];
		}
		
		/****************************************/
		// Constructors and Allocation 
		/****************************************/			
		
		/**
		* Awake is called at the construction of the object
		*/
		public override function awake( ):void
		{
			getDependency(MaterialManager).loadMaterials();
		}
		
		/**
		* Destroy is called at the destruction of the object
		*/
		public override function destroy():void 
		{
		}			
	}
}