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
	import handlers.ConnectionHandler;
	import handlers.LoginHandler;
	import handlers.RoomHandler;
	import handlers.MessageHandler;
	
	import core.SceneManager;
	import core.SceneObject;
	import IntroScene;
	
	/**
	 */
	public class Main extends Sprite 
	{
		private var _renderer:Renderer;
		private var _networkManager:NetworkManager;
		
		private var _square:GameObject;
		private var _otherSquare:GameObject;
		private var _board:GameObject;
		
		private var _eventManager:EventManager;
		private var _testlisterner:TestEventListener;
		private var _networkmanager:NetworkManager;
		
		private var _sceneManager:SceneManager;
		
		public function Main():void 
		{		
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			setup(e);
			setupTestSquares(e);
			
			testEvent();
			
			setupTestScene();
			
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function setup(e:Event = null):void
		{
			_renderer = MemoryManager.instantiate(Renderer, Renderer.dependencies);
			
			// Create the event manager
			_eventManager = MemoryManager.instantiate(EventManager);
			
			_testlisterner = MemoryManager.instantiate( TestEventListener, [EventManager] );			

			// Create a network layer
			_networkmanager = MemoryManager.instantiate(NetworkManager, [EventManager]);			
			_networkmanager.addComponent(ConnectionHandler);
			_networkmanager.addComponent(LoginHandler);
			_networkmanager.addComponent(RoomHandler);
			_networkmanager.addComponent(MessageHandler);
			
			// Connect to the server
			_networkmanager.connect();
		}
		
		private function setupTestSquares(e:Event = null):void
		{
		
			// Set the square
			_square = MemoryManager.instantiate( GameObject, GameObject.dependencies);
			_square.addComponent(SquareScriptComponent, [EventManager]);
			_square.addComponent(SquareRenderComponent);
			_square.addComponent(TransformComponent);
			
			// Set the square
			_otherSquare = MemoryManager.instantiate( GameObject, GameObject.dependencies );
			_otherSquare.addComponent(SquareScriptComponent, [EventManager]);
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
		
		private function testEvent():void
		{
			trace("testEvent");
			_eventManager.fireEvent("myevent", null);
			
		}
		
		private function setupTestScene():void
		{
			_sceneManager = new SceneManager();
			trace("-----------------");
			trace("Part 1 scene test");
			trace("-----------------");
			trace("-Pushing introscene");
			_sceneManager.PushScene(IntroScene);
			trace("-Pop intro scene");
			_sceneManager.PopScene();
			trace("-----------------");
			trace("Part 2 scene test");
			trace("-----------------");
			trace("-Pushing introscene");
			_sceneManager.PushScene(IntroScene);
			trace("-Pushing SecondScene - Should see intro leave first");
			_sceneManager.PushScene(SecondScene);
			trace("-----------------");
			trace("Part 3 scene test");
			trace("-----------------");
			trace("-Poping secondscene - Show see show intro after this");
			_sceneManager.PopScene();
			trace("-Poping intro scene");
			_sceneManager.PopScene();
			trace("-----------------");
			trace("Part 4 scene test");
			trace("-----------------");
			trace("pushing 4 scenes, intro, second, intro, intro");
			_sceneManager.PushScene(IntroScene);
			_sceneManager.PushScene(SecondScene);
			_sceneManager.PushScene(IntroScene);
			_sceneManager.PushScene(IntroScene);
			trace("popto intro - should do nothing");
			_sceneManager.PopToScene(IntroScene);
			trace("popto second - should remove 2 intro");
			_sceneManager.PopToScene(SecondScene);
		}

		private function onEnterFrame( e:Event ):void
		{
			_renderer.render(this);
		}
	}
}