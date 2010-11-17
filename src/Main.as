package 
{
	import core.BaseObject;
	import core.Renderer;
	import core.Scene;
	import core.NetworkManager;
	
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
		private var _scene:Scene;
		private var _renderer:Renderer;
		private var _networkManager:NetworkManager;
		
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
			
			_scene = MemoryManager.instantiate(Scene);
			_renderer = MemoryManager.instantiate(Renderer);

			//_camera = MemoryManager.instantiate( GameObject, [CameraScriptComponent, TransformComponent] );
			//_camera.enabled = false;
			
			// Set the square
			_square = MemoryManager.instantiate( GameObject );
			_square.addComponent(SquareScriptComponent);
			_square.addComponent(SquareRenderComponent);
			_square.addComponent(BoardNetworkComponent);
			_square.addComponent(TransformComponent);

			// Set the square
			_otherSquare = MemoryManager.instantiate( GameObject );
			_otherSquare.addComponent(SquareScriptComponent);
			_otherSquare.addComponent(OtherSquareRenderComponent);
			_otherSquare.addComponent(TransformComponent);

			// Disable the sqares
			_square.enabled = false;
			_otherSquare.enabled = false;

			// Update the components
			_square.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( 50, 50, 1 );
			_square.getComponent( BaseObject.TRANSFORM_COMPONENT ).rotate = 45;
			_otherSquare.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( 100, 100, 0 );

			//_scene.addCamera( _camera );
			_scene.addGameObject( _square );
			_scene.addGameObject( _otherSquare );
			
			// Add the to the renderer
			_renderer.addScene( _scene );
			_renderer.currentScene = _scene;
			
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function onEnterFrame( e:Event ):void
		{
			_renderer.render(this);
		}
	}
}