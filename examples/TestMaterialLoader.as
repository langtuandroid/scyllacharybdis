package 
{
	import core.BaseObject;
	import core.MaterialManager;

	[Singleton]
	[Requirements (MaterialManager)]
	public class TestMaterialLoader extends BaseObject
	{

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