package  
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Daniel Lamb
	 */
	public class SquareSceneObject extends SceneObject
	{
		public function SquareSceneObject( size:int, color:uint, name:String = null ) 
		{
			super( name );
			
			var render:SquareRenderComponent = new SquareRenderComponent( size, color );
			var script:SquareScriptComponent = new SquareScriptComponent();
			
			render.initUIScripts( script );
			
			addComponent( render );
			addComponent( script );
		}	
	}
}