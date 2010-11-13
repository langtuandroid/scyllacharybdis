package 
{
	import TestMetaTags;
	import flash.utils.describeType;
	import core.BaseObject;
	import core.SceneGraph;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	import core.MemoryManager;
	import core.GameObject;
	
	import components.TransformComponent;
	
	import TestMaterialLoader;
	import TestSceneLoader;
	
	/**
	 */
	public class Main extends Sprite 
	{
		private var _memoryManager:MemoryManager;
		private var _sceneGraph:SceneGraph;
		
		private var _square:Square;
		private var _otherSquare:Square;
		
		public function Main():void 
		{
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);

			getMetaTag();
			
			//_memoryManager.instantiate(TestMaterialLoader);
			//_memoryManager.instantiate(TestSceneLoader);
			
			//var board:GameObject = _memoryManager.instantiate(GameObject);
			//board.addComponent(BoardRenderComponent);
			//board.addComponent(BoardScriptComponent);
			//board.addComponent(BoardNetworkComponent);
			
		}
		
		private function getMetaTag():void
		{
			var typeInfo:XML = describeType(TestMetaTags);
			trace(typeInfo);
			var xmlType:XMLList = typeInfo..metadata;
			trace("Starting Loop");
			for each ( var value:XML in xmlType )
			{
				if (value.attribute("name") == "Singleton" ) {
					trace("Singleton class");
				}
				if (value.attribute("name") == "Requires" ) 
				{
					for each ( var req:XML in value.arg ) {
						trace( req.attribute("value") );
					}
					
				}
			}
			trace("Stop Loop");
	
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_memoryManager = new MemoryManager();
			_sceneGraph = _memoryManager.instantiate(SceneGraph);
			
			_square = _memoryManager.instantiate( Square );
			
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function onEnterFrame( e:Event ):void
		{
			_sceneGraph.renderWorld(this);
		}
	}
}