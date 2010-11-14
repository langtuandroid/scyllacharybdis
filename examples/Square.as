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
		public static function get dependencies():Array { return new Array( SquareScriptComponent, SquareRenderComponent, TransformComponent ); }
	}
}