package physics
{
	import components.RenderComponent;
	import core.materials.Texture;
	import core.materials.TextureManager;
	import core.memory.MemoryManager;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 */
	[Requires ("core.materials.TextureManager")]
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
			_texture = _square;
			_baseclip.graphics
			_baseclip.graphics.beginFill( color );
			_baseclip.graphics.drawRect( 0, 0, x, y );
			_baseclip.graphics.endFill();
		}

		public function createCircle( radius:int, color:Number = 0x123456):void
		{
			_texture = _circle;
			_baseclip.graphics
			_baseclip.graphics.beginFill( color );
			_baseclip.graphics.drawCircle(0, 0, radius);
			_baseclip.graphics.endFill();
		}
	}
}
