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
		
		public function SceneGraph() 
		{
			
		}

		private var _gameObjects:Dictionary = new Dictionary(true);
		
		public function addGameObject( gameObj:GameObject ):void 
		{
			_gameObjects[gameObj] = gameObj;
			dispatchEvent( new EngineEvent( EngineEvent.DIRTY ) );
		}
		
		public function removeGameObject( gameObj:GameObject ):void
		{
			dispatchEvent( new EngineEvent( EngineEvent.DIRTY ) );
			delete _gameObjects[gameObj];
		}
		
		public function get renderables():Array
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