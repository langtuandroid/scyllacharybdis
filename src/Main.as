package 
{
	import core.BaseObject;
	import core.SceneGraph;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.casalib.math.geom.Point3d;

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
		
		private var _square:GameObject;
		private var _otherSquare:GameObject;
		
		public function Main():void 
		{
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
			//_memoryManager.instantiate(TestMaterialLoader);
			//_memoryManager.instantiate(TestSceneLoader);
			
			//var board:GameObject = _memoryManager.instantiate(GameObject);
			//board.addComponent(BoardRenderComponent);
			//board.addComponent(BoardScriptComponent);
			//board.addComponent(BoardNetworkComponent);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_memoryManager = new MemoryManager();
			_sceneGraph = MemoryManager.instantiate(SceneGraph);
			
			_square = MemoryManager.instantiate( GameObject, Square.BLUE_SQUARE );
			
			_square.disabled = false;
			_square.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( 50, 50, 1 );
			_square.getComponent( BaseObject.TRANSFORM_COMPONENT ).rotate = 45;
			
			_otherSquare = MemoryManager.instantiate( GameObject, Square.OTHER_SQUARE );
			_otherSquare.disabled = false;
			_otherSquare.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( 100, 100, 0 );

			_sceneGraph.addGameObject( _square );
			_sceneGraph.addGameObject( _otherSquare );
			
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function onEnterFrame( e:Event ):void
		{
			_sceneGraph.renderWorld(this);
		}
	}
}