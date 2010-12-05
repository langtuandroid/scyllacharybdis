package core 
{
	import components.RenderComponent;
	import events.EngineEvent;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class SceneGraph extends BaseObject 
	{
		public static function get scope():int { return SINGLETON_OBJECT; }
		
		/****************************************/
		// Class Details
		/****************************************/

		private var _gameObjects:Dictionary = new Dictionary(true);
		
		/**
		 * The engine contructor
		 * @private
		 */
		public final override function engine_awake():void
		{
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
		}
		
		/**
		 * Add the game object and its children to the scene
		 */
		public final function addGameObjectToScene(gameObj:GameObject):void
		{
			if ( gameObj == null )
			{
				return;
			}
			gameObj.engine_start();
			addGameObject(gameObj);
			addChildrenToScene(gameObj);
		}
		
		/**
		 * Remove the game objects and its children from the scene
		 */
		public final function removeGameObjectToScene(gameObj:GameObject):void
		{
			if ( gameObj == null )
			{
				return;
			}
			gameObj.engine_stop();
			removeChildrenFromScene(gameObj);
			removeGameObject(gameObj);
		}
		
		/**
		 * Add all its children to the scene
		 * @param	gameObj
		 */
		private final function addChildrenToScene(gameObj:GameObject):void
		{
			for each ( var child:GameObject in gameObj.children )
			{
				addGameObjectToScene(child);
			}			
		}

		/**
		 * Remove all its children from the scene
		 * @param	gameObj
		 */
		private final function removeChildrenFromScene(gameObj:GameObject):void
		{
			for each ( var child:GameObject in gameObj.children )
			{
				removeGameObjectToScene(child);
			}				
		}

		/**
		 * Add a gameobject to the scene
		 * @param	gameObj
		 */
		private final function addGameObject( gameObj:GameObject ):void 
		{
			_gameObjects[gameObj] = gameObj;
		}

		/**
		 * Remove a game object from the scene
		 * @param	gameObj
		 */
		private final function removeGameObject( gameObj:GameObject ):void
		{
			delete _gameObjects[gameObj];
		}
		
		/**
		 * Get all the renderables for the scene.
		 * Used by the renderer to display the scene.
		 */
		public final function get renderables():Array
		{
			//trace("SceneGraph: renderables");
			var renderables:Array = new Array();
			
			// Apply frustrum-ish algorithm here
			for each ( var gameObj:GameObject in _gameObjects )
			{
				if ( gameObj.enabled == true )
				{
					var renderable:RenderComponent = gameObj.getComponent(RENDER_COMPONENT);
					if ( renderable != null )
					{
						renderables.push(renderable);
					}
				}
			}
			return renderables;
		}
	}
}