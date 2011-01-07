package physics
{
	import components.RenderComponent;
	import core.sprites.Texture;
	import core.sprites.TextureManager;
	import core.memory.MemoryManager;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 */
	[Requires ("core.sprites.TextureManager")]
	public class PhysicsRenderComponent extends RenderComponent
	{
		private var _textureManager:TextureManager;
		private var _circle:Texture;
		private var _square:Texture;
		
		override public function awake():void 
		{
			_textureManager = MemoryManager.instantiate(TextureManager);
			_circle = _textureManager.loadTexture("circle.png");
			_square = _textureManager.loadTexture("square.png");
			super.awake();
		}
		
		public function createBox( x:int, y:int, color:Number = 0x123456):void
		{
			texture = _square;
			baseclip.graphics
			baseclip.graphics.beginFill( color );
			baseclip.graphics.drawRect( 0, 0, x, y );
			baseclip.graphics.endFill();
		}

		public function createCircle( radius:int, color:Number = 0x123456):void
		{
			texture = _circle;
			baseclip.graphics
			baseclip.graphics.beginFill( color );
			baseclip.graphics.drawCircle(0, 0, radius);
			baseclip.graphics.endFill();
		}
	}
}