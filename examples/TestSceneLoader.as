package 
{
	import core.BaseObject;
	import core.SceneManager
	
	[Singleton]
	[Requirements (SceneManager)]
	public class TestSceneLoader extends  BaseObject
	{
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