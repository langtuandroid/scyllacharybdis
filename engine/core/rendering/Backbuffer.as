package core.rendering 
{
	import core.objects.BaseObject;
	import core.objects.GameObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.Bitmap;	
	
	/**
	 */
	public class Backbuffer extends BaseObject
	{
		private var _width:int;
		private var _height:int;
		private var _frontBuffer:BitmapData
		private var _backBuffer:BitmapData
		private var _origin:Point = new Point(0, 0);

		/**
		 * Return the class scope
		 */
		public static function get scope():int { return SINGLETON_OBJECT };
		
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
			var bitmap:Bitmap = Bitmap( gameObj.getComponent(RENDER_COMPONENT) );
			_backBuffer.copyPixels(bitmap.bitmapData, bitmap.bitmapData.rect, new Point(gameObj.position.x, gameObj.position.y), null, null, true)
		}
		
		/**
		 * Set the screen size
		 * @param	var width width in pixels
		 * @param	var height height in pixels
		 */
		public function setSize( width:int, height:int ):void
		{
			// Store the width and height
			_width = width;
			_height = height;

			trace( "Size: " + width + " " + height );
			// Create the buffers
			_frontBuffer = new BitmapData(width, height);
			_backBuffer = new BitmapData(width, height);
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