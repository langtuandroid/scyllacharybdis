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
	import components.Component;
	import di.Dependencies;
	import di.Description;
	
	/**
	 */
	public class SceneGraph extends EventDispatcher
	{
		/****************************************/
		// Dependency Injection calls
		/****************************************/

		/**
		 * Return the class description
		 */
		public static function get description():Description  
		{ 
			return new Description( SceneGraph, Description.SINGLETON_OBJECT );
		}

		/**
		 * Return the class dependencies
		 */
		public static function get dependencies():Dependencies  
		{  
			return null;
		}

		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 */
		public function set dependencies( dep:Dictionary ):void 
		{ 
		}
		
		/****************************************/
		// Overide function
		/****************************************/

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

		/****************************************/
		// Class specific
		/****************************************/

		// All the game object in the world
		protected var _gameObjects:Dictionary = new Dictionary(true);
		
		// Caches of all the components
		protected var _components:Dictionary = new Dictionary();
		
		// Extra array of just the renderables
		protected var _renderables:Array = new Array();
		
		private var _sortRequired = true;
		
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
		 * Add a scene object to the graph
		 */
		public function addGameObject( gameObj:GameObject ):void 
		{
			_sortRequired = true;
			_gameObjects[gameObj] = gameObj;
			gameObj.start();
		}
		
		/** 
		 * Remove a scene object to the graph
		 */
		public function removeGameObject( gameObj:GameObject ): void
		{
			_sortRequired = true;
			gameObj.stop();
			delete _gameObjects[gameObj];
		}

		/**
		 * Added a component to the game object
		 */
		public function addComponent( comp:Component ):void
		{
			if ( comp.type == BaseObject.RENDER_COMPONENT )
			{
				_renderables.push(comp);
			}
		
			_components[comp.type][comp] = comp;
			
			return;
		}
		
		/**
		 * Remove a component to the game object
		 */
		public function removeComponent( comp:Component ):void
		{
			if ( comp.type == BaseObject.RENDER_COMPONENT )
			{
				// Remove the child from the list
				var index:int = _renderables.indexOf( comp );
				
				if ( index >= 0 )
				{
					_renderables.splice( index, 1 );
				}
			}
			
			delete _components[comp.type][comp];
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
	}
}
