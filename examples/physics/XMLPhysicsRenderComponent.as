package physics
{
	import com.scyllacharybdis.components.XMLRenderComponent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 */
	public class XMLPhysicsRenderComponent extends XMLRenderComponent
	{
		
		override public function awake():void 
		{
			loadMaterial("test.xml", "blackpawn");
		}
		
		public function createBox( x:int, y:int, color:Number = 0x123456):void
		{
			//texture = _square;
			baseclip.graphics
			baseclip.graphics.beginFill( color );
			baseclip.graphics.drawRect( 0, 0, x, y );
			baseclip.graphics.endFill();
		}

		public function createCircle( radius:int, color:Number = 0x123456):void
		{
			//texture = _circle;
			baseclip.graphics
			baseclip.graphics.beginFill( color );
			baseclip.graphics.drawCircle(0, 0, radius);
			baseclip.graphics.endFill();
		}
	}
}
