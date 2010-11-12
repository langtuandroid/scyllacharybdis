package  
{
	import components.RenderComponent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class OtherSquareRenderComponent extends RenderComponent 
	{
		
		public function OtherSquareRenderComponent() 
		{
			
		}

		public override function awake():void
		{
			super.awake();
		}
		
		public override function start():void
		{
			super.start();
			
			trace("OtherSquareRenderComponent is starting!");
			
			_baseclip.graphics
			_baseclip.graphics.beginFill( 0x654321 );
			_baseclip.graphics.drawRect( 0, 0, 100, 100 );
			_baseclip.graphics.endFill();
			
			_baseclip.z = 5;
		}
	}

}