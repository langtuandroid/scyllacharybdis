package square 
{
	import core.GameObject;
	/**
	 * ...
	 * @author ...
	 */
	[Requires ( square.SquareScriptComponent, square.SquareScriptComponent ) ]
	public class Square extends GameObject 
	{
		public function Square() 
		{
			
		}
		
		/**
		public override function get dependencyClasses():Array	{ 
			var superDeps:Array = super.dependencyClasses;
			var deps:Array = new Array( SquareScriptComponent, SquareRenderComponent );
			return deps.concat(superDeps);
		}

		public override function awake():void
		{
			
			addComponent( _dependencies[SquareScriptComponent] );
			addComponent( _dependencies[SquareRenderComponent] );
			
			super.awake();
		}
		*/
	}
}