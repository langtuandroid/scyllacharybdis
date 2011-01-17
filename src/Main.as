package 
{
	import com.scyllacharybdis.core.memory.allocate;
	import com.scyllacharybdis.graphics.rendering.Backbuffer;
	import com.scyllacharybdis.graphics.rendering.Renderer;
	import com.scyllacharybdis.graphics.rendering.Window;
	import com.scyllacharybdis.graphics.scenegraph.SceneGraph;
	import com.scyllacharybdis.networking.handlers.ChatMessageHandler;
	import com.scyllacharybdis.networking.handlers.ConnectionHandler;
	import com.scyllacharybdis.networking.handlers.LoginHandler;
	import com.scyllacharybdis.networking.handlers.RoomHandler;
	import com.scyllacharybdis.networking.NetworkEventHandler;
	import com.scyllacharybdis.physics.PhysicsSceneComponent;
	import com.scyllacharybdis.scenemanager.SceneManager;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Main extends Sprite 
	{
		private var _window:Window;
		private var _renderer:Renderer;
		private var _sceneManager:SceneManager;
		private var _physicsComponent:PhysicsSceneComponent;
		
		public function Main():void 
		{		
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			// Create the window
			_window = allocate(Window);
			_window.displayContext = this;

			// Create a physics component
			_physicsComponent = allocate(PhysicsSceneComponent);
			
			// Create the scenegraph and add the physics component
			_sceneGraph = allocate( SceneGraph, _physicsComponent );
			
			// Create a rendering system and inject the graph and window
			_renderer = allocate(Renderer, _sceneGraph, _window);
			
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