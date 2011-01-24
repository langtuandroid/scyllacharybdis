package physics
{
	import com.scyllacharybdis.components.MovieClipComponent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 */
	//[Requires ("com.scyllacharybdis.core.loaders.TextureManager")]
	public class PhysicsRenderComponent extends MovieClipComponent
	{
	//	private var _textureManager:TextureManager;
	//	private var _circle:TextureObject;
	//	private var _square:TextureObject;
		
		override public function awake():void 
		{
		//	_textureManager = MemoryManager.instantiate(TextureManager);
		//	_circle = _textureManager.loadTexture("circle.png");
		//	_square = _textureManager.loadTexture("square.png");
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
