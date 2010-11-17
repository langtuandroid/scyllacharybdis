package 
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getQualifiedSuperclassName;
	import org.casalib.math.geom.Point3d;
	import core.BaseObject;
	import core.GameObject;
	import core.Renderer;
	import core.Scene;
	import core.MemoryManager;
	import core.NetworkManager;
	import components.TransformComponent;
	
	import BoardRenderComponent;
	import BoardScriptComponent;
	import PieceScriptComponent;
	import WhiteRenderComponent;
	import BlackRenderComponent;
	
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
		private var _board:GameObject;
		
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
			setup(e);
			setupTestSquares(e);
			setupChessBoard(e);
		}
		
		private function setup(e:Event = null):void
		{
			_memoryManager = new MemoryManager();
			_scene = MemoryManager.instantiate(Scene);
			_renderer = MemoryManager.instantiate(Renderer);
		}
		
		private function setupTestSquares(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//_camera = MemoryManager.instantiate( GameObject, [CameraScriptComponent, TransformComponent] );
			//_camera.enabled = false;
			
			// Set the square
			_square = MemoryManager.instantiate( GameObject );
			_square.addComponent(SquareScriptComponent);
			_square.addComponent(SquareRenderComponent);
			_square.addComponent(TransformComponent);
			
			trace(getQualifiedSuperclassName(_square))

			// Set the square
			_otherSquare = MemoryManager.instantiate( GameObject );
			_otherSquare.addComponent(SquareScriptComponent);
			_otherSquare.addComponent(OtherSquareRenderComponent);
			_otherSquare.addComponent(TransformComponent);

			// Disable the sqares
			_square.enabled = false;
			_otherSquare.enabled = false;

			// Update the components
			_square.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( 50, 50, 11 );
			_square.getComponent( BaseObject.TRANSFORM_COMPONENT ).rotate = 45;
			_otherSquare.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( 100, 100, 10 );

			//_scene.addCamera( _camera );
			_scene.addGameObject( _square );
			_scene.addGameObject( _otherSquare );
			
			// Add the to the renderer
			_renderer.addScene( _scene );
			_renderer.currentScene = _scene;
			
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function setupChessBoard(e:Event = null):void
		{
			// Set the square
			_board = MemoryManager.instantiate( GameObject );
			_board.addComponent(BoardScriptComponent);
			_board.addComponent(BoardRenderComponent);
			_board.addComponent(TransformComponent);			

			_board.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( 200, 200, 0 );
			_board.getComponent( BaseObject.TRANSFORM_COMPONENT ).rotate = 45;
		}
		
		
		private function onEnterFrame( e:Event ):void
		{
			_renderer.render(this);
		}
	}
}