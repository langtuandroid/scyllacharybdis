package  
{
	import components.RenderComponent;
	import core.Material;
	import core.MaterialManager;

	public class BoardRenderComponent extends RenderComponent
	{
		
		/****************************************/
		// Dependency Information
		/****************************************/
		
		/**
		 * Return the class scope
		 */
		public static function get scope():int { return NEW_OBJECT };		
		
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
		
		private var _materialManager:MaterialManager;
		
		/**
		* Awake is called at the construction of the object
		*/
		public override function awake():void
		{
			_materialManager = getDependency(MaterialManager);
			_materialManager.getMaterial("board");
		}
		
		public override function destroy():void 
		{
		}	
		
	}
}