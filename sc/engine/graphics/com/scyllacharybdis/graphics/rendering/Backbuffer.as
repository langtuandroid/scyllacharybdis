package com.scyllacharybdis.graphics.rendering 
{
	import com.scyllacharybdis.interfaces.IBaseObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.Bitmap;	
	import flash.geom.Rectangle;
	
	/**
	 */
	[Singleton]
	public class Backbuffer implements IBaseObject
	{
		private var _width:int;
		private var _height:int;
		private var _frontBuffer:BitmapData
		private var _backBuffer:BitmapData
		private var _origin:Point = new Point(0, 0);
		private var _canvas:DisplayObjectContainer;

		/**
		 * Constructor
		 */
		public function Backbuffer()
		{
		}
		

		public function awake():void
		{
			
		}
		
		/**
		 * Destructor
		 */
		public function destroy():void
		{
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
		 * Copy the pixels to the backbuffer
		 * @param	bitmapData
		 * @param	bitmapRect
		 * @param	destPoint
		 * @param	alphaBitmapData
		 * @param	alphaPoint
		 * @param	mergeAlpha
		 */
		public function copyPixels( bitmapData:BitmapData, bitmapRect:Rectangle, destPoint:Point, alphaBitmapData:BitmapData = null, alphaPoint:Point = null, mergeAlpha:Boolean = false ):void
		{
			_backBuffer.copyPixels(bitmapData, bitmapRect, destPoint, alphaBitmapData, alphaPoint, mergeAlpha)
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