package core 
{
	import org.casalib.util.ArrayUtil;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Dictionary;
	
	import core.GameObject;
	import components.RenderComponent
	
	/**
	 */
	public class SceneGraph extends BaseObject
	{
		/****************************************/
		// Dependency Information
		/****************************************/

		/**
		 * Return the class scope
		 */
		public static function get scope():int { return SINGLETON_OBJECT };		

		
		/****************************************/
		// Constructors and Allocation 
		/****************************************/

		// All the game object in the world
		protected var _gameObjects:Dictionary = new Dictionary(true);
		
		// Extra array of just the renderables
		protected var _renderables:Array = new Array();

		// Does the scene need to be sorted
		private var _sortRequired:Boolean = true;

		/** 
		 * Add a scene object to the graph
		 */
		public function addGameObject( gameObj:GameObject ):void 
		{
			// Tell the scene its dirty
			_sortRequired = true;
			
			// Add the object to the list
			_gameObjects[gameObj] = gameObj;
			
			// Get renderables from the gameobject
			addRenderable( gameObj );
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
			gameObj.stop();

			delete _gameObjects[gameObj];
		}

		
		/**
		 * Updates all the components in the world
		 */
		public function updateWorld(): void 
		{
			for each ( var component:BaseObject in _components[BaseObject.NETWORK_COMPONENT] ) 
			{
				component.update();
			}
			
			for each ( component in _components[BaseObject.STATE_COMPONENT] ) 
			{
				component.update();
			}
			
			//renderWorld();
		}
		
		/**
		 * Get Renderables 
		 */
		public function renderWorld( surface:DisplayObjectContainer ):void
		{
			// Erase the world
			for each ( var renderable:RenderComponent in _renderables )
			{
				if ( surface.contains( renderable.baseclip ) )
				{
					renderable.erase(surface);
				}
			}
			
			// Sort the renderables array (bigger numbers are closer to the screen) 
			_renderables.sortOn( "comparator", Array.NUMERIC | Array.DESCENDING );
			
			// Render children in order
			for ( var i:int = 0; i < _renderables.length; i++ )
			{
				_renderables[i].render(surface);
			}
		}
		
		/** 
		 * Helper function to get the components off the scripts
		 */
		private function addRenderable( obj:GameObject ):void 
		{
			// Tell the scene its dirty
			_sortRequired = true;
			
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
				_sortRequired = true;
			
				// Get the render component
				var renderable:RenderComponent = ArrayUtil.getItemByKeys( _renderables, { owner:obj } );
				
				// Remove the render component from the array
				ArrayUtil.removeItem( _renderables, renderable );
			}
		}
	}
}
