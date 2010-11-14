package engine.core 
{
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Dictionary;
	import engine.components.Component;
	import Engine.GameObject;
	
	/**
	 */
	public class SceneGraph
	{

		/***********************************/
		// Singleton boilerplate
		/***********************************/
		public function SceneGraph( se:SingletonEnforcer ) 
		{
			// Allocate the individual component dictionaries within the _components dictionary 
			_components[BaseObject.NETWORK_COMPONENT] = new Dictionary();
			_components[BaseObject.RENDER_COMPONENT] = new Dictionary();
			_components[BaseObject.SCRIPT_COMPONENT] = new Dictionary();
			_components[BaseObject.TRANSFORM_COMPONENT] = new Dictionary();
		}
		
		private static var _sInstance:SceneGraph = null;
		
		public static function get instance():SceneGraph 
		{
			if (_sInstance == null) 
			{
				_sInstance = new SceneGraph( new SingletonEnforcer() );
			}
			
			return _sInstance;
		}		
		/***********************************/

		// All the game object in the world
		protected var _gameObjects:Dictionary = new Dictionary(true);
		
		// MAY NOT BE REQUIRED AFTER ALL IF YOU ACUTALLY USE Z PROPERTY AND ALL RENDERABLES ARE RENDERED ONTO THE SAME SURFACE
		//protected var _sortRequired:Boolean = true;
		
		// Caches of all the components
		protected var _components:Dictionary = new Dictionary(true);
		
		/**
		 * Updates all the components in the world
		 */
		public function updateWorld( e:Event ): void 
		{
			for each ( var component:Component in _components[BaseObject.NETWORK_COMPONENT] ) 
			{
				component.update();
			}
			
			for each ( component in _scriptComponents[BaseObject.SCRIPT_COMPONENT] ) 
			{
				component.update();
			}
			
			// ALSO MAY NOT BE REQUIRED
			// THE SCRIPT COMPONENT'S UPDATE WILL HANDLE IT THROUGH IT'S USE OF THE TRANSFORM COMPONENT
			//for each ( component in _renderComponents ) 
			//{
				//component.update();
			//}
		}
		
		/** 
		 * Add a scene object to the graph
		 */
		public function addSceneObject( gameObj:GameObject ):void 
		{
			//_sortRequired = true;
			_gameObjects[gameObj] = gameObj;
			gameObj.start();
		}
		
		/** 
		 * Remove a scene object to the graph
		 */
		public function removeSceneObject( gameObj:GameObject ): void
		{
			//_sortRequired = true;
			gameObj.stop();
			delete _gameObjects[gameObj];
			
		}

		/**
		 * Added a component to the game object
		 */
		public function addComponent( comp:Component ):void
		{
			//_sortRequired = true;
			
			_components[comp.type][comp] = comp;
			
			return;
		}
		
		/**
		 * Remove a component to the game object
		 */
		public function removeComponent( comp:Component ):void
		{
			//_sortRequired = true;
			
			delete _components[comp.type][comp];
		}
		
		/**
		 * Get Renderables 
		 */
		public function get renderables():Dictionary
		{
			// Check to see if anything has changed
			//if ( _sortRequired == true ) {
				// Sort back to front ( bigger numbers are closer to the screen );
				//sortRenderables(  );
				//_sortRequired = false;
			//}
			return _components[BaseObject.RENDER_COMPONENT];
		}
		
		//protected function sortRenderables( comparator:Object, options:Object = null ):Dictionary
		//{
			//
		//}
	}
}
