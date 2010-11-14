package  
{
	import components.TransformComponent;
	import core.GameObject;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Square 
	{
		public static const BLUE_SQUARE:Array = new Array( SquareScriptComponent, SquareRenderComponent, TransformComponent );
		public static const OTHER_SQUARE:Array = new Array( SquareScriptComponent, OtherSquareRenderComponent, TransformComponent );
	}
}