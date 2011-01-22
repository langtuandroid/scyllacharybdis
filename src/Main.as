package 
{
	import com.scyllacharybdis.core.events.NetworkEventHandler;
	import com.scyllacharybdis.core.events.NetworkEvents;
	import com.scyllacharybdis.core.memory.MemoryManager;
	import com.scyllacharybdis.core.physics.PhysicsWorld;
	import com.scyllacharybdis.core.rendering.Renderer;
	import com.scyllacharybdis.core.rendering.Window;
	import com.scyllacharybdis.core.scenes.SceneManager;
	import com.scyllacharybdis.handlers.ChatMessageHandler;
	import com.scyllacharybdis.handlers.ConnectionHandler;
	import com.scyllacharybdis.handlers.LoginHandler;
	import com.scyllacharybdis.handlers.RoomHandler;
	import flash.display.Sprite;
	import flash.events.Event;
	import physics.PhysicsScene;
	
	public class Main extends Sprite 
	{
		private var _window:Window;
		private var _renderer:Renderer;
		private var _sceneManager:SceneManager;
		private var _physicsWorld:PhysicsWorld;
		
		public function Main():void 
		{		
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Create a window
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
			
			_physicsWorld = MemoryManager.instantiate(PhysicsWorld);
			
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