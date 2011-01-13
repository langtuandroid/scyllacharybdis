package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import core.memory.MemoryManager;
	import core.rendering.Window;
	import core.rendering.Renderer;
	import core.events.NetworkEvents;
	import core.events.NetworkEventHandler;
	import handlers.ConnectionHandler;
	import handlers.LoginHandler;
	import handlers.RoomHandler;
	import handlers.ChatMessageHandler;
	import core.scenes.SceneManager;
	import physics.PhysicsScene;
	
	public class Main extends Sprite 
	{
		private var _window:Window;
		private var _renderer:Renderer;
		private var _sceneManager:SceneManager;
		
		public function Main():void 
		{		
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Map the scene graph to use the physics graph
			MemoryManager.bind("core.scenegraph.SceneGraph", "core.scenegraph.PhysicsSceneGraph");
			
			_window = MemoryManager.instantiate(Window);
			_window.displayContext = this;
			
			// Create a rendering system
			_renderer = MemoryManager.instantiate(Renderer);
			
			// Create a network layer
			var _networkHandler:NetworkEventHandler = MemoryManager.instantiate(NetworkEventHandler);			
			var _connectionHandler:ConnectionHandler = MemoryManager.instantiate(ConnectionHandler);
			var _loginHandler:LoginHandler = MemoryManager.instantiate(LoginHandler);
			var _roomHandler:RoomHandler = MemoryManager.instantiate(RoomHandler);
			var _chatMessageHandler:ChatMessageHandler = MemoryManager.instantiate(ChatMessageHandler);
			
			// Fire a network connection event
			_networkHandler.fireEvent(NetworkEvents.CONNECT);

			// Create the scene manager
			_sceneManager = MemoryManager.instantiate(SceneManager);

			// Display the intro scene
			_sceneManager.PushScene(PhysicsScene);	

			addEventListener( Event.ENTER_FRAME, onEnterFrame );
			
		}

		private function onEnterFrame( e:Event ):void
		{
			_renderer.render();
		}
	}
}