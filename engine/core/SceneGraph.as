package core 
{
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
		private var _sortRequired = true;

		/**
		* Awake is called at the construction of the object
		*/
		public function Awake():void
		{
		}
		
		/**
		* Destroy is called at the removal of the object
		*/	
		public function Destroy():void
		{
		}
		
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
			AddRenderables( gameObj );
			
			// Start the game object
			gameObj.start();
		}
		
		public function updateGameObject( gameObj:GameObject ):void
		{
			// Tell the scene its dirty
			_sortRequired = true;
			
			// Get renderables from the gameobject
			AddRenderables( gameObj );
		}
		
		/** 
		 * Remove a scene object to the graph
		 */
		public function removeGameObject( gameObj:GameObject ): void
		{
			_sortRequired = true;
			
			// Get renderables from the gameobject
			RemoveRenderables( gameObj );

			// Stop the game object
			gameObj.stop();

			delete _gameObjects[gameObj];
		}

		
		/**
		 * Updates all the components in the world
		 */
		public function updateWorld(): void 
		{
			for each ( var component:Component in _components[BaseObject.NETWORK_COMPONENT] ) 
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
			_renderables.sortOn( "z", Array.NUMERIC | Array.DESCENDING );
			
			// Render children in order
			for ( var i:int = 0; i < _renderables.length; i++ )
			{
				_renderables[i].render(surface);
			}
		}
		
		/** 
		 * Helper function to get the components off the scripts
		 */
		private function AddRenderables( obj:GameObject ) 
		{
			// Get the render component
			var renderable:Component = gameObj.getComponent( BaseObject.RENDER_COMPONENT );
			_renderables[renderable] = renderable;
		}
		
		private function RemoveRenderables( obj:GameObject ) 
		{
			// Get the render component
			var renderable:Component = gameObj.getComponent( BaseObject.RENDER_COMPONENT );
			delete _renderables[renderable];
		}
	}
}
