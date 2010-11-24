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
		// Constructors and Allocation 
		/****************************************/
		private var _sceneGraph:SceneGraph = null;
		private var _dirty:Boolean = true;
		
		public function Renderer()
		{
			
		}
		
		public override function engine_awake():void
		{
			super.engine_awake();
			
			_sceneGraph = getDependency(SceneGraph);
			_sceneGraph.addEventListener( EngineEvent.DIRTY, onDirty, false, 0, true );
		}
		
		public override function engine_destroy():void 
		{
			super.engine_destroy();

			_sceneGraph.removeEventListener( EngineEvent.DIRTY, onDirty, false );
			_sceneGraph = null;
			
		}
		
		public function render( surface:DisplayObjectContainer ):void
		{
			if ( _dirty == true )
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
				
				_dirty = false;
			}
		}
		
		private function onDirty( e:EngineEvent ):void
		{
			_dirty = true;
		}
	}
}