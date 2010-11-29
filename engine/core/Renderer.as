package core 
{
	import components.RenderComponent;
	import events.EngineEvent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;

	import core.BaseObject;	
	
	/**
	 */
	public class Renderer extends BaseObject
	{
		/**
		 * Return the class scope
		 */
		public static function get scope():int { return SINGLETON_OBJECT };
		
		/**
		 * Get the dependencies to instantiate the class
		 */
		public static function get dependencies():Array { return [SceneGraph]; }
		
		/****************************************/
		// Class Details
		/****************************************/
		
		private var _sceneGraph:SceneGraph = null;
		private var _dirty:Boolean = true;
		
		public final override function engine_awake():void
		{
			_sceneGraph = getDependency(SceneGraph);

			super.engine_awake();
		}

		
		public final override function engine_start():void
		{
			super.engine_start();
		}

		public final override function engine_stop():void
		{
			super.engine_stop();
		}

		public final override function engine_destroy():void 
		{
			super.engine_destroy();

			_sceneGraph = null;
		}
		
		public final function render( surface:DisplayObjectContainer ):void
		{
			// Erase the world
			for ( var i:int = surface.numChildren - 1; i >= 0; i-- )
			{
				surface.removeChildAt(i);
			}
			
			// Get the renderables array
			var renderables:Array = _sceneGraph.renderables;
			
			// Sort the renderables array (bigger numbers are closer to the screen) 
			renderables.sortOn( "comparator", Array.NUMERIC );
			
			// Render children in order
			for ( i = 0; i < renderables.length; i++ )
			{
				renderables[i].render(surface);
			}
		}
	}
}