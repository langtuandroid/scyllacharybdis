package  
{
	import components.RenderComponent;
	/**
	 * ...
	 * @author ...
	 */
	public class BlackRenderComponent extends RenderComponent
	{
		public override function start():void
		{
			trace("BoardRenderComponent is starting!");
			_baseclip.graphics
			_baseclip.graphics.beginFill( 0x000000 );
			_baseclip.graphics.drawRect( 0, 0, 25, 25 );
			_baseclip.graphics.endFill();
		}
	}
}