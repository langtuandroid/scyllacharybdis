package 
{
	import Box2D.Common.Math.b2Vec2;
	import core.events.EventHandler;
	import core.events.NetworkEvents;
	import core.events.NetworkEventHandler;
	import core.physics.PhysicsWorld;
	import core.rendering.Backbuffer;
	import core.rendering.Window;
	import flash.display.Sprite;
	import flash.events.Event;
	import core.rendering.Renderer;
	import core.memory.MemoryManager;
	import core.scenes.SceneManager;
	import handlers.ConnectionHandler;
	import handlers.LoginHandler;
	import handlers.RoomHandler;
	import handlers.ChatMessageHandler;
	import intro.IntroScene;
	import intro.ChatExample;
	import org.casalib.math.geom.Point3d;
	import physics.PhysicsScene;

	
	
	public class Main extends Sprite 
	{
		private var _window:Window;
		private var _renderer:Renderer;
		private var _sceneManager:SceneManager;
		private var _chatExample:ChatExample;
		private var _physicsWorld:PhysicsWorld;
		private var _eventHandler:EventHandler;
		
		public function Main():void 
		{		
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_window = MemoryManager.instantiate(Window);
			_window.displayContext = this;
			
			// Create a rendering system
			_renderer = MemoryManager.instantiate(Renderer);
			
			// Create the event manager
			_eventHandler= MemoryManager.instantiate(EventHandler);
			
			// Create the scene manager
			_sceneManager = MemoryManager.instantiate(SceneManager);
			
			// Create a network layer
			var _networkHandler:NetworkEventHandler = MemoryManager.instantiate(NetworkEventHandler);			
			var _connectionHandler:ConnectionHandler = MemoryManager.instantiate(ConnectionHandler);
			var _loginHandler:LoginHandler = MemoryManager.instantiate(LoginHandler);
			var _roomHandler:RoomHandler = MemoryManager.instantiate(RoomHandler);
			var _chatMessageHandler:ChatMessageHandler = MemoryManager.instantiate(ChatMessageHandler);
			
			// Fire a network connection event
			_networkHandler.fireEvent(NetworkEvents.CONNECT);

			// Create a physics world
			_physicsWorld = MemoryManager.instantiate(PhysicsWorld);
			//_physicsWorld.gravity = new b2Vec2(0.0, 10.0);
			
			// Display the intro scene
			//_sceneManager.PushScene(IntroScene);			
			_sceneManager.PushScene(PhysicsScene);	
			

			addEventListener( Event.ENTER_FRAME, onEnterFrame );
			
		}

		private function onEnterFrame( e:Event ):void
		{
			_renderer.render();
		}
	}
}