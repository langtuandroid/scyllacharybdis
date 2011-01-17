package com.scyllacharybdis.graphics.scenegraph 
{
	import com.scyllacharybdis.interfaces.IBaseObject;
	import com.scyllacharybdis.interfaces.IComponent;
	import com.scyllacharybdis.interfaces.IRenderComponent;
	import com.scyllacharybdis.objects.GameObject;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ...
	 */
	[Singleton]
	public class SceneGraph implements IBaseObject 
	{
		private var _componentList:Array;
		private var _updateTimer:Timer = new Timer(1/30 * 1000, 0); 
		private var _gameObjects:Dictionary = new Dictionary(true);
		
		/**
		 * Constructor
		 */
		public function SceneGraph( ... compList:Array  )
		{
			for each ( var comp:IComponent in _componentList )
			{
				comp.awake(this);
			}

			// setup the timer
			_updateTimer.addEventListener(TimerEvent.TIMER, update);
			_updateTimer.start();			
		}
		
		/**
		 * Destructor
		 */
		public function destroy():void
		{
			for each ( var comp:IComponent in _componentList )
			{
				comp.destroy();
			}
			
			_updateTimer.stop();
			_updateTimer.removeEventListener(TimerEvent.TIMER, update);			
		}	
		

		/**
		 * Update the scene graph
		 * @param	event
		 * @private
		 */
		public final function update(event:TimerEvent):void
		{
			for each ( var comp:IComponent in _componentList )
			{
				comp.update();
			}
			
			for each ( var gameObj:GameObject in _gameObjects )
			{
				if ( gameObj.enabled == true )
				{
					gameObj.updateComponents();
				}
			}
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
			gameObj.start();
			addGameObject(gameObj);
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
			gameObj.stop();
			removeGameObject(gameObj);
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
					var renderable:IRenderComponent = gameObj.getComponent(IRenderComponent);
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