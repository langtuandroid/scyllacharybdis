package  
{
	import core.GameObject;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Square 
	{
		public static function get dependencies():Array { return new Array( SquareScriptComponent, SquareRenderComponent ); }
		
		/*
		public function get dependencyClasses():Array	{ 
																	var superDeps:Array = super.dependencyClasses;
																	
																	var deps:Array = new Array( SquareScriptComponent, SquareRenderComponent );
																	
																	return deps.concat(superDeps);
																}
																
		public function awake():void
		{
			
			addComponent( _dependencies[SquareScriptComponent] );
			addComponent( _dependencies[SquareRenderComponent] );
			
			super.awake();
		}
		*/
	}
}