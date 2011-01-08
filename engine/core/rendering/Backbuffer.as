package core.rendering 
{
	import components.RenderComponent;
	import core.objects.TextureObject;
	import core.objects.BaseObject;
	import core.objects.GameObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.Bitmap;	
	
	/**
	 */
	[Singleton]
	public class Backbuffer extends BaseObject
	{
		private var _width:int;
		private var _height:int;
		private var _frontBuffer:BitmapData
		private var _backBuffer:BitmapData
		private var _origin:Point = new Point(0, 0);
		private var _canvas:DisplayObjectContainer;

		/**
		 * The engine contructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			super.engine_awake();
		}

		/**
		 * The engine start method
		 * @private
		 */		
		public final override function engine_start():void
		{
			super.engine_start();
		}

		/**
		 * The engine stop function
		 * @private
		 */
		public final override function engine_stop():void
		{
			super.engine_stop();
		}

		/**
		 * Destroy is called at the removal of the object
		 * @private
		 */
		public final override function engine_destroy():void 
		{
			super.engine_destroy();
		}

		/**
		 * Set the screen size
		 * @param	var width width in pixels
		 * @param	var height height in pixels
		 */
		public function setCanvas( canvas:DisplayObjectContainer, width:int, height:int ):void
		{
			_canvas = canvas;
			_width = width;
			_height = height;

			// Create the buffers
			_frontBuffer = new BitmapData(width, height);
			_backBuffer = new BitmapData(width, height);
			
			var surface:Bitmap = new Bitmap(_frontBuffer);
			_canvas.addChild(surface);
		}		
		/**
		 * Clear the screen
		 */
		public function clear(color:uint):void 
		{
			_backBuffer.fillRect(_backBuffer.rect, color);			
		}
		
		/**
		 * Draw the clip
		 * @param	baseclip
		 */
		public function draw(gameObj:GameObject):void 
		{
			var bitmapData:BitmapData;
			if ( gameObj.getComponent(RenderComponent).texture )
			{
				var texture:TextureObject = gameObj.getComponent(RenderComponent).texture;
				if ( !texture.isLoaded() ) {
					return;
				}
				bitmapData = texture.getTextureData();
			} 
			else 
			{
				var clip:MovieClip = gameObj.getComponent(RenderComponent).baseclip;
				bitmapData = new BitmapData(clip.width, clip.height, true, 0x555555FF);
				bitmapData.draw(clip);
			}
			_backBuffer.copyPixels(bitmapData, bitmapData.rect, new Point(gameObj.position.x, gameObj.position.y), null, null, true)
		}
		
		public function lock():void
		{
			_backBuffer.lock();
		}
		
		/**
		 * Swap the backbuffer to the front buffer;
		 */
		public function swapBuffers():void
		{
			_frontBuffer.copyPixels(_backBuffer, _backBuffer.rect, _origin);
		}

		public function unlock():void
		{
			_backBuffer.unlock();
		}

	}
}