package  
{
	import components.RenderComponent;

	public class WhiteRenderComponent  extends RenderComponent
	{
		public override function start():void
		{
			trace("WhiteRenderComponent is starting!");
			_baseclip.graphics
			_baseclip.graphics.beginFill( 0xFFFFFF );
			_baseclip.graphics.drawRect( 0, 0, 25, 25 );
			_baseclip.graphics.endFill();
		}
	}
}
