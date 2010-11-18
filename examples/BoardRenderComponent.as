package   
{
	import components.RenderComponent;

	public class BoardRenderComponent extends RenderComponent
	{
		public override function start():void
		{
			trace("BoardRenderComponent is starting!");
			_baseclip.graphics
			_baseclip.graphics.beginFill( 0xCCCCCC );
			_baseclip.graphics.drawRect( 0, 0, 800, 600 );
			_baseclip.graphics.endFill();
		}
	}
}