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
		
		/**
		* Awake is called at the construction of the object
		*/
		public final override function engine_awake():void
		{
			super.engine_awake();
		}
		
		public final override function engine_start():void
		{
			super.engine_start();
		}

		public final override function engine_stop():void
		{
			super.engine_stop();
		}
		
		/**
		* Destroy is called at the removal of the object
		*/	
		public final override function engine_destroy():void
		{
			super.engine_destroy();
		}
		
		private var _gameObjects:Dictionary = new Dictionary(true);
		
		public final function addGameObject( gameObj:GameObject ):void 
		{
			_gameObjects[gameObj] = gameObj;
		}
		
		public final function removeGameObject( gameObj:GameObject ):void
		{
			delete _gameObjects[gameObj];
		}
		
		public final function get renderables():Array
		{
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