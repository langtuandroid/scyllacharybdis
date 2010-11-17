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
		
		public function Renderer()
		{
			
		}
		
		public override function awake():void
		{
			super.awake();
			
			_sceneGraph = getDependency(SceneGraph);
		}
		
		public override function destroy():void 
		{
			_sceneGraph = null;
			
			super.destroy();
		}
		
		public function render( surface:DisplayObjectContainer ):void
		{
			// Erase the world
			for ( var i:int = surface.numChildren - 1; i >= 0; i-- )
			{
				surface.removeChildAt(i);
			}
			
			// Get the renderables from the scene graph
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