package  
{
	import components.RenderComponent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 */
	public class PhysicsRenderComponent extends RenderComponent
	{
		public function createBox( x:int, y:int, color:Number = 0x123456):void
		{
			_baseclip.graphics
			_baseclip.graphics.beginFill( color );
			_baseclip.graphics.drawRect( 0, 0, x, y );
			_baseclip.graphics.endFill();
		}

		public function createCircle( radius:int, color:Number = 0x123456):void
		{
			_baseclip.graphics
			_baseclip.graphics.beginFill( color );
			_baseclip.graphics.drawCircle(0, 0, radius);
			_baseclip.graphics.endFill();
		}
	}
}
