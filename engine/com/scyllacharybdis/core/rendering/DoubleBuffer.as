package com.scyllacharybdis.core.rendering 
{
	import com.scyllacharybdis.core.objects.BaseObject;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 */
	[Singleton]
	public class DoubleBuffer extends BaseObject
	{
		private var _width:int;
		private var _height:int;
		private var _frontBuffer:BitmapData;
		private var _DoubleBuffer:BitmapData;
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
		}		
		/**
		 * Clear the screen
		 */
		public function clear(color:uint):void 
		{
			_DoubleBuffer.fillRect(_DoubleBuffer.rect, color);			
		}
		
		/**
		 * Copy the pixels to the DoubleBuffer
		 * @param	bitmapData
		 * @param	bitmapRect
		 * @param	destPoint
		 * @param	alphaBitmapData
		 * @param	alphaPoint
		 * @param	mergeAlpha
		 */
		public function copyPixels( bitmapData:BitmapData, bitmapRect:Rectangle, destPoint:Point, alphaBitmapData:BitmapData = null, alphaPoint:Point = null, mergeAlpha:Boolean = false ):void
		{
			_DoubleBuffer.copyPixels(bitmapData, bitmapRect, destPoint, alphaBitmapData, alphaPoint, mergeAlpha)
		}
		
		/**
		 * Lock the DoubleBuffer for write
		 */
		public function lock():void
		{
			_DoubleBuffer.lock();
		}
		
		/**
		 * Swap the DoubleBuffer to the front buffer;
		 */
		public function swapBuffers():void
		{
			_frontBuffer.copyPixels(_DoubleBuffer, _DoubleBuffer.rect, _origin);
		}

		/**
		 * Unlock the DoubleBuffer after completing the write
		 */
		public function unlock():void
		{
			_DoubleBuffer.unlock();
		}
		
		/**
		 * Get the draw canvas
		 */
		public function get canvas():DisplayObjectContainer { return _canvas; }
		
		/**
		 * Set the draw canvas
		 */
		public function set canvas(value:DisplayObjectContainer):void 
		{
			_canvas = value;
			_width = value.stage.stageWidth;
			_height = value.stage.stageHeight;

			// Create the buffers
			_frontBuffer = new BitmapData(_width, _height);
			_DoubleBuffer = new BitmapData(_width, _height);
			
			var surface:Bitmap = new Bitmap(_frontBuffer);
			_canvas.addChild(surface);
		}
	}
}