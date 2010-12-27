package core.rendering 
{
	import core.objects.BaseObject;
	import flash.display.DisplayObjectContainer;

	/**
	 */
	[Singleton]
	public class Window extends BaseObject
	{
		/**
		 * Return the class scope
		 */
		public static function get scope():int { return SINGLETON_OBJECT };
		
		private var _displayContext:DisplayObjectContainer;
		private var _backBuffer:Backbuffer;
		
		/**
		 * The engine contructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			_backBuffer = getDependency(Backbuffer);
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
		}
		
		/**
		 * Get the display context
		 */
		public function get displayContext():DisplayObjectContainer { return _displayContext; }
		
		/**
		 * Set the display context
		 */
		public function set displayContext(value:DisplayObjectContainer):void 
		{
			_displayContext = value;
			_backBuffer.setCanvas(_displayContext, _displayContext.stage.stageWidth, _displayContext.stage.stageHeight);
		}
		
		/**
		 * Get the rendering surface
		 */
		public function get surface():Backbuffer { return _backBuffer; }
		
		/**
		 * Set the rendering surface
		 */
		public function set surface(value:Backbuffer):void 
		{
			_backBuffer = value;
		}
	
		/**
		 * Get the screen width
		 * @return (int) Screen width in pixels
		 */
		public function getScreenWidth():int
		{
			return _displayContext.stage.width;
		}
		
		/**
		 * Get the screen height
		 * @return (int) Screen height in pixels
		 */
		public function getScreenHeight():int
		{
			return _displayContext.stage.height;
		}
		
		/**
		 * Begin the rendering phase
		 * Lock the back buffer for rendering
		 */
		public function beginRendering():void 
		{
			_backBuffer.lock();
		}
		
		/**
		 * End the rendering phase
		 * Unlocks the back buffer and swaps the double buffer
		 */
		public function endRendering():void 
		{
			_backBuffer.swapBuffers();
			_backBuffer.unlock();
		}
	}
}