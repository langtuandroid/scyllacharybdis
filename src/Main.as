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
	import core.MemoryManager;
	import core.EventManager;
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
		private var _renderer:Renderer;
		private var _networkManager:NetworkManager;
		
		private var _square:GameObject;
		private var _otherSquare:GameObject;
		private var _board:GameObject;
		
		public function Main():void 
		{		
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			setup(e);
			//setupTestSquares(e);
			setupChessBoard(e);
			testEvent();
			
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function setup(e:Event = null):void
		{
			_renderer = MemoryManager.instantiate(Renderer, Renderer.dependencies);
		}
		
		private function setupTestSquares(e:Event = null):void
		{
			// entry point
			//_camera = MemoryManager.instantiate( GameObject, [CameraScriptComponent, TransformComponent] );
			//_camera.enabled = false;
			
			// Set the square
			_square = MemoryManager.instantiate( GameObject, GameObject.dependencies);
			_square.addComponent(SquareScriptComponent);
			_square.addComponent(SquareRenderComponent);
			_square.addComponent(TransformComponent);
			
			// Set the square
			_otherSquare = MemoryManager.instantiate( GameObject, GameObject.dependencies );
			_otherSquare.addComponent(SquareScriptComponent);
			_otherSquare.addComponent(OtherSquareRenderComponent);
			_otherSquare.addComponent(TransformComponent);

			// Disable the sqares
			_square.enabled = true;
			_otherSquare.enabled = true;

			// Update the components
			_square.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( 50, 50, 11 );
			_square.getComponent( BaseObject.TRANSFORM_COMPONENT ).rotate = 45;
			_otherSquare.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( 100, 100, 10 );

			
		}
		
		private function setupChessBoard(e:Event = null):void
		{
			// Set the square
			_board = MemoryManager.instantiate( GameObject, GameObject.dependencies );
			_board.addComponent(BoardScriptComponent);
			_board.addComponent(BoardRenderComponent);
			_board.addComponent(TransformComponent);			

			//_board.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d(0, 0, 0);
			//_board.getComponent( BaseObject.TRANSFORM_COMPONENT ).rotate = 0;
			
			_board.enabled = true;
		}
		
		private function testEvent():void
		{
			// Create the event manager
			var eventManager:EventManager = MemoryManager.instantiate(EventManager);
			
			// Create a listener
			var listerner:EventListener = MemoryManager.instantiate( EventListener, [EventManager] );
			
			eventManager.fireEvent("myevent", null);
			
		}
		
		private function onEnterFrame( e:Event ):void
		{
			_renderer.render(this);
		}
	}
}