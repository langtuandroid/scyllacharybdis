package square
{
	import components.RenderComponent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	[Component ("components.RenderComponent")]
	public class SquareRenderComponent extends RenderComponent
	{
		public function SquareRenderComponent( ) 
		{
			
		}
		
		public override function awake():void
		{
			super.awake();
		}
		
		public override function start():void
		{
			super.start();
			
			trace("SquareRenderComponent is starting!");
			
			_baseclip.graphics
			_baseclip.graphics.beginFill( 0x123456 );
			_baseclip.graphics.drawRect( 0, 0, 200, 200 );
			_baseclip.graphics.endFill();
			
			_baseclip.z = 0;
		}
	}

}