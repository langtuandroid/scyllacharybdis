package  
{
	import core.SceneObject;
	/**
	 * ...
	 * @author ...
	 */
	public class SecondScene extends SceneObject
	{
		public override function awake():void 
		{
			trace("Starting SecondScene");
		}
		
		public override function show():void
		{
			trace("Show the SecondScene");
		}
		
		public override function hide():void
		{
			trace("Hide the SecondScene");
		}
		
		public override function destroy():void
		{
			trace("Stoping SecondScene");
		}
	}
}