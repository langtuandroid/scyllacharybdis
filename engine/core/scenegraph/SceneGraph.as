package core.scenegraph 
{
	import components.RenderComponent;
	import core.objects.BaseObject;
	import core.objects.GameObject;
	import events.EngineEvent;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ...
	 */
	[Singleton]
	public class SceneGraph extends BaseObject 
	{
		private var _updateTimer:Timer = new Timer(1/30 * 1000, 0); 
		private var _gameObjects:Dictionary = new Dictionary(true);
		
		/**
		 * The engine contructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			// setup the timer
			_updateTimer.addEventListener(TimerEvent.TIMER, engine_update);
			_updateTimer.start();
			
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
		 * Update the physics model
		 * @param	event
		 * @private
		 */
		public final function engine_update(event:TimerEvent):void
		{
			
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
			
			_updateTimer.stop();
			_updateTimer.removeEventListener(TimerEvent.TIMER, engine_update);
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
					var renderable:RenderComponent = gameObj.getComponent(RenderComponent);
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