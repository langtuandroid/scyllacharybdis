package  
{
	import components.RenderComponent;
	import core.Material;
	import core.MaterialManager;

	[Component (RenderComponent)]
	[Requirements (MaterialManager)]
	public class BoardRenderComponent extends RenderComponent
	{
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