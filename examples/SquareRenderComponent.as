package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Daniel Lamb
	 */
	public class SquareRenderComponent extends RenderComponent
	{
		public function SquareRenderComponent( size:int, color:uint ) 
		{
			super();
			
			_baseclip = new MovieClip();
			_baseclip.graphics.beginFill( color );
			_baseclip.graphics.drawRect( 0, 0, size, size );
			_baseclip.graphics.endFill();
		}
		
		public override function initUIScripts( scriptComponent:ScriptComponent ):void
		{
			_baseclip.addEventListener( MouseEvent.MOUSE_DOWN, (scriptComponent as SquareScriptComponent).onMouseDown ); 
		}
	}

}