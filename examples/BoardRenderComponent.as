package   
{
	import components.RenderComponent;

	public class BoardRenderComponent extends RenderComponent
	{
		public override function start():void
		{
			trace("BoardRenderComponent is starting!");
			_baseclip.graphics
			_baseclip.graphics.beginFill( 0x0000FF );
			_baseclip.graphics.drawRect( 0, 0, 1000, 1000 );
			_baseclip.graphics.endFill();
		}
	}
}