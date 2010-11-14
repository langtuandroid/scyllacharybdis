package core 
{
	import components.RenderComponent;
	import events.EngineEvent;
	import flash.utils.Dictionary;
	import org.casalib.util.ArrayUtil;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Scene extends BaseObject 
	{
		
		public function Scene() 
		{
			
		}
		
		/****************************************/
		// Constructors and Allocation 
		/****************************************/

		// All the game object in the world
		protected var _gameObjects:Dictionary = new Dictionary(true);
		
		// Extra array of just the renderables
		private var _renderables:Array = new Array();
		public function get renderables():Array { return _renderables; }

		/** 
		 * Add a scene object to the graph
		 */
		public function addGameObject( gameObj:GameObject ):void 
		{
			for each ( var child:GameObject in gameObj.children )
			{
				addGameObject( child );
			}
			
			// Add the object to the list
			_gameObjects[gameObj] = gameObj;
			
			// Get renderables from the gameobject
			addRenderable( gameObj );
			
			gameObj.enabled = true;

		}
		
		public function updateGameObject( gameObj:GameObject ):void
		{
			// Remove the old renderable
			removeRenderable( gameObj );
			
			// Get renderables from the gameobject
			addRenderable( gameObj );
		}
		
		/** 
		 * Remove a scene object to the graph
		 */
		public function removeGameObject( gameObj:GameObject ): void
		{
			// Get renderables from the gameobject
			removeRenderable( gameObj );

			// Stop the game object
			gameObj.enabled = false;

			delete _gameObjects[gameObj];
		}
		
		/** 
		 * Helper function to get the components off the scripts
		 */
		private function addRenderable( obj:GameObject ):void 
		{
			// Tell the scene its dirty
			dispatchEvent(new EngineEvent(EngineEvent.DIRTY));
			
			// Get the render component
			var renderable:RenderComponent = obj.getComponent( BaseObject.RENDER_COMPONENT );
			
			if ( renderable != null )
			{
				_renderables.push(renderable);
			}
			
		}
		
		private function removeRenderable( obj:GameObject ):void 
		{
			if ( _renderables.length > 0 )
			{
				// Tell the scene its dirty
				dispatchEvent(new EngineEvent(EngineEvent.DIRTY));
			
				// Get the render component
				var renderable:RenderComponent = ArrayUtil.getItemByKeys( _renderables, { owner:obj } );
				
				// Remove the render component from the array
				ArrayUtil.removeItem( _renderables, renderable );
			}
		}
		
		public override function destroy():void
		{
			for each ( var gameObj:GameObject in _gameObjects )
			{
				delete _gameObjects[gameObj]
			}
			
			_gameObjects = null;
			
			for each ( var renderable:RenderComponent in _renderables )
			{
				_renderables = null;
			}
			
			_renderables = null;
			
			super.destroy();
		}
		
	}

}