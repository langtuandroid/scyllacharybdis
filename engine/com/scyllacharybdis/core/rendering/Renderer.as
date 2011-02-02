package com.scyllacharybdis.core.rendering 
{
	import com.scyllacharybdis.core.objects.BaseObject;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	
	/**
	 */
	[Singleton]
	[Requires ("com.scyllacharybdis.core.rendering.Window")]
	public final class Renderer extends BaseObject
	{
		private var _window:Window = null;
		private var _dirty:Boolean = true;
		
		/**
		 * The engine contructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			_window = getDependency(Window);

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

			_window = null;
		}
		
		/**
		 * Render the frame
		 */
		public final function render(renderables:Array):void
		{
			// Sort the renderables array (bigger numbers are closer to the screen) 
			renderables.sortOn( "comparator", Array.NUMERIC );
			
			_window.beginRendering();
			_window.surface.clear(0x000000FF);
			
			// Render children in order
			for ( var i:int = 0; i < renderables.length; i++ )
			{
				renderables[i].render(_window.surface);
			}
			
			_window.endRendering();
		}
	}
}