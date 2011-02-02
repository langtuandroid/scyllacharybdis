package com.scyllacharybdis.core.scenegraph 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import com.scyllacharybdis.components.RenderComponent;
	import com.scyllacharybdis.components.ScriptComponent;
	import com.scyllacharybdis.core.objects.BaseObject;
	import com.scyllacharybdis.core.objects.GameObject;
	import com.scyllacharybdis.core.physics.PhysicsContactListener;
	import com.scyllacharybdis.core.rendering.Renderer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import org.casalib.math.geom.Point3d;
	/**
	 * ...
	 * @author ...
	 */
	[Singleton]
	[Requires ("com.scyllacharybdis.core.rendering.Renderer", "com.scyllacharybdis.core.physics.PhysicsContactListener")]
	public class SceneGraph extends BaseObject 
	{
		private var _updateTimer:Timer = new Timer(1/30 * 1000, 0); 
		private var _gameObjects:Dictionary = new Dictionary(true);
		private var _renderer:Renderer;
		
		private var _world:b2World;
		private var _contactListener:PhysicsContactListener;
		
		// map pixels to meters ( 30 pixels = 1 meter );
		private var _drawScale:int = 30;
		
		private var _velocityIterations:int = 10;
		private var _positionIterations:int = 10;
		
		/**
		 * The engine contructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			// Get the dependencies
			_contactListener = getDependency(PhysicsContactListener);
			_renderer = getDependency(Renderer);
			
			_renderer.window.clickHandler = this;

			// Allow bodies to sleep
			var doSleep:Boolean = true;
			
			// Define the gravity vector
			var gravity:b2Vec2 = new b2Vec2(0.0, 10.0);
			
			// Construct a world object
			_world = new b2World(gravity, doSleep);
			
			// Set the contact listener for the world
			_world.SetContactListener(_contactListener);	
			
			super.engine_awake();

			// setup the timer
			_updateTimer.addEventListener(TimerEvent.TIMER, engine_update);
			_updateTimer.start();
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
			for each ( var gameObj:GameObject in _gameObjects )
			{
				gameObj.engine_update(event);
			}
			
			_world.Step( 1 / 30, _velocityIterations, _positionIterations );
			
			var counter:int = 0;
			// Update all the game object positions
			for (var bb:b2Body = _world.GetBodyList(); bb; bb = bb.GetNext())
			{
				if (bb.GetUserData() is GameObject)
				{
					gameObj = bb.GetUserData() as GameObject;
					if ( gameObj == null ) {
						continue;
					}
					gameObj.position = new Point3d( bb.GetPosition().x * drawScale, bb.GetPosition().y * drawScale, gameObj.position.z );
					gameObj.rotation = bb.GetAngle() * (180/Math.PI);
					counter++;
				}
			}
			
			//trace("SceneGraph: renderables");
			var renderables:Array = new Array();
			// Apply frustrum-ish algorithm here
			for each ( gameObj in _gameObjects )
			{
				if ( gameObj.enabled == true )
				{
					var renderable:RenderComponent = gameObj.getComponent(RenderComponent) as RenderComponent;
					if ( renderable != null )
					{
						renderables.push(renderable);
					}
				}
			}	
			_renderer.render( renderables );
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
		 * Get the world 
		 */
		public function get world():b2World { return _world; }
		
		/**
		 * Get the draw scale that maps pixels to meters.
		 */
		public function get drawScale():int { return _drawScale; }

		/**
		 * Set the draw scale that maps pixels to meters.
		 * @param scale (int) The number of pixels to make up a meter. Default = 30
		 */
		public function set drawScale(value:int):void 
		{
			_drawScale = value;
		}
		
		/**
		 * Set the world gravity
		 * @param gravity (beVec2) The gravity in a vector
		 */
		public function set gravity(value:b2Vec2):void 
		{
			_world.SetGravity(value);
		}

		/**
		 * Get Number of iterations before its finished trying to solve a collision
		 */
		public function get velocityIterations():int { return _velocityIterations; }
		
		/**
		 * Set Number of iterations before its finished trying to solve a collision
		 * The recommended number is 10
		 */
		public function set velocityIterations(value:int):void 
		{
			_velocityIterations = value;
		}
		
		/**
		 * Get Number of iterations before its finished trying to solve a collision
		 */
		public function get positionIterations():int { return _positionIterations; }
		
		/**
		 * Set Number of iterations before its finished trying to solve a collision
		 * The recommended number is 10
		 */
		public function set positionIterations(value:int):void 
		{
			_positionIterations = value;
		}		

		private function getObjectsAt(x:Number, y:Number):Array 
		{
			trace("getObjectsAt");
			var list:Array = new Array();
			for each ( var gameObj:GameObject in _gameObjects )
			{
				var renderComponent:RenderComponent = gameObj.getComponent(RenderComponent);
				if ( renderComponent != null )
				{
					var rect:Rectangle = renderComponent.getWorldRectange();
					if ( rect != null )
					{
						if ( rect.contains( x, y ) ) 
						{
							list.push( gameObj );
							trace( gameObj );
						}
					}
				}
			}
			return list;
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onClick(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onClick(e);
				}
			}
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onDoubleClick(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onDoubleClick(e);
				}
			}
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onMouseDown(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onMouseDown(e);
				}
			}
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onMouseMove(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onMouseMove(e);
				}
			}
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onMouseOut(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onMouseOut(e);
				}
			}
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onMouseOver(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onMouseOver(e);
				}
			}
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onMouseUp(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onMouseUp(e);
				}
			}
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onMouseWheel(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onMouseWheel(e);
				}
			}
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onRollOver(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onRollOver(e);
				}
			}
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onRollOut(e:MouseEvent):void 
		{
			var objects:Array = getObjectsAt( e.stageX, e.stageY );
			for each ( var object:GameObject in objects ) 
			{
				var scriptComponent:ScriptComponent = object.getComponent(ScriptComponent);
				if ( scriptComponent != null )
				{
					scriptComponent.onRollOut(e);
				}
			}
		}		
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onKeyDown(e:KeyboardEvent):void 
		{
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		public final function onKeyUp(e:KeyboardEvent):void 
		{
		}
		
	}
}