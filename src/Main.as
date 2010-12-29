package 
{
	import Box2D.Common.Math.b2Vec2;
	import core.materials.TextureManager;
	import core.physics.PhysicsWorld;
	import core.rendering.Backbuffer;
	import core.rendering.Window;
	import flash.display.Sprite;
	import flash.events.Event;
	import core.rendering.Renderer;
	import core.memory.MemoryManager;
	import core.managers.EventManager;
	import core.managers.SceneManager;
	import core.objects.NetworkObject;
	import handlers.ConnectionHandler;
	import handlers.LoginHandler;
	import handlers.RoomHandler;
	import handlers.MessageHandler;
	import handlers.ChatMessageHandler;
	import intro.IntroScene;
	import intro.NetworkDriver;
	import intro.ChatExample;
	import org.casalib.math.geom.Point3d;
	import core.materials.MaterialManager;
	import physics.PhysicsScene;

	
	
	public class Main extends Sprite 
	{
		private var _window:Window;
		private var _renderer:Renderer;
		private var _networkObject:NetworkObject;
		private var _eventManager:EventManager;
		private var _sceneManager:SceneManager;
		private var _networkDriver:NetworkDriver;
		private var _chatExample:ChatExample;
		private var _physicsWorld:PhysicsWorld;
		private var _materialManager:MaterialManager;
		private var _textureManager:TextureManager;
		
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
			_eventManager = MemoryManager.instantiate(EventManager);
			
			// Create the scene manager
			_sceneManager = MemoryManager.instantiate(SceneManager);
			
			// Create a network layer
			_networkObject = MemoryManager.instantiate(NetworkObject);			
			_networkObject.addComponent(ConnectionHandler);
			_networkObject.addComponent(LoginHandler);
			_networkObject.addComponent(RoomHandler);
			_networkObject.addComponent(ChatMessageHandler);
			_networkObject.addComponent(MessageHandler);

			// Create an example network driver
			_networkDriver = MemoryManager.instantiate( NetworkDriver);
			//_chatExample = MemoryManager.instantiate( ChatExample );

			// Fire a network connection event
			_eventManager.fireEvent("NETWORK_CONNECT");

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