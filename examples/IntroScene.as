package  
{
	import core.SceneObject;
	/**
	 * ...
	 * @author ...
	 */
	public class IntroScene extends SceneObject
	{
		public override function awake():void 
		{
			trace("Starting IntroScene");
		}
		
		public override function show():void
		{
			trace("Show the IntroScene");
		}
		
		public override function hide():void
		{
			trace("Hide the IntroScene");
		}
		
		public override function destroy():void
		{
			trace("Stoping IntroScene");
		}
	}
}