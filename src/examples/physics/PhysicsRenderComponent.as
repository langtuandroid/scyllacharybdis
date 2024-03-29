package examples.physics
{
	import com.scyllacharybdis.components.TextureRenderComponent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 */
	[Component (type="RenderComponent")]
	public class PhysicsRenderComponent extends TextureRenderComponent
	{
		
		override public function awake():void 
		{
		//	_textureManager = allocate(TextureManager);
		//	_circle = _textureManager.loadTexture("circle.png");
		//	_square = _textureManager.loadTexture("square.png");
		}
		
		public function createBox( x:int, y:int, color:Number = 0x123456):void
		{
			loadTexture("square.png");
			//texture = _square;
			//baseclip.graphics
			//baseclip.graphics.beginFill( color );
			//baseclip.graphics.drawRect( 0, 0, x, y );
			//baseclip.graphics.endFill();
		}

		public function createCircle( radius:int, color:Number = 0x123456):void
		{
			loadTexture("circle.png");
			//texture = _circle;
			//baseclip.graphics
			//baseclip.graphics.beginFill( color );
			//baseclip.graphics.drawCircle(0, 0, radius);
			//baseclip.graphics.endFill();
		}
	}
}
