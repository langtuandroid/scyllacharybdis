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
		
		/****************************************/
		// Constructors and Allocation 
		/****************************************/
		private var _currentScene:Scene = null;
		private var _dirty:Boolean = true;
		
		public function Renderer()
		{
			
		}
		
		public override function destroy():void 
		{
			if ( _currentScene )
			{
				if ( _currentScene.hasEventListener(EngineEvent.DIRTY) )
				{
					_currentScene.removeEventListener(EngineEvent.DIRTY, onDirty);
				}
			}
			
			_currentScene = null;
			
			super.destroy();
		}
		
		public function set currentScene( value:Scene ):void
		{
			_dirty = true;
			
			if ( _currentScene )
			{
				if ( _currentScene.hasEventListener(EngineEvent.DIRTY) )
				{
					_currentScene.removeEventListener(EngineEvent.DIRTY, onDirty);
				}
			}
					
			_currentScene = value;
			
			_currentScene.addEventListener(EngineEvent.DIRTY, onDirty, false, 0, true);
		}
		
		public function render( surface:DisplayObjectContainer ):void
		{
			if ( _dirty )
			{
				// Erase the world
				for ( var i:int = surface.numChildren - 1; i >= 0; i-- )
				{
					surface.removeChildAt(i);
				}
				
				// Sort the renderables array (bigger numbers are closer to the screen) 
				_currentScene.renderables.sortOn( "comparator", Array.NUMERIC );
				
				// Render children in order
				for ( i = 0; i < _currentScene.renderables.length; i++ )
				{
					_currentScene.renderables[i].render(surface);
				}
				
				_dirty = false;
			}
		}
		
		private function onDirty(e:EngineEvent):void
		{
			_dirty = true;
		}
	}
}