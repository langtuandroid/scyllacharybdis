package  
{
	import components.RenderComponent;
	
	/**
	 */
	public class OtherSquareRenderComponent extends RenderComponent 
	{
		
		public function OtherSquareRenderComponent() 
		{
			
		}

		public override function start():void
		{
			_baseclip.graphics
			_baseclip.graphics.beginFill( 0x654321 );
			_baseclip.graphics.drawRect( 0, 0, 100, 100 );
			_baseclip.graphics.endFill();
		}
	}

}