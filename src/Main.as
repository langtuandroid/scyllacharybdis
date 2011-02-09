package 
{
	import com.scyllacharybdis.components.CollisionComponent;
	import com.scyllacharybdis.components.MovieClipComponent;
	import com.scyllacharybdis.components.RenderComponent;
	import com.scyllacharybdis.components.ScriptComponent;
	import com.scyllacharybdis.components.SoundComponent;
	import com.scyllacharybdis.components.XMLCollisionComponent;
	import com.scyllacharybdis.components.XMLRenderComponent;
	import com.scyllacharybdis.core.events.NetworkEventHandler;
	import com.scyllacharybdis.core.events.NetworkEvents;
	import com.scyllacharybdis.core.memory.allocate;
	import com.scyllacharybdis.core.memory.MemoryManager;
	import com.scyllacharybdis.core.objects.GameObject;
	import com.scyllacharybdis.core.rendering.Renderer;
	import com.scyllacharybdis.core.rendering.Window;
	import com.scyllacharybdis.core.scenegraph.SceneGraph;
	import com.scyllacharybdis.handlers.ChatMessageHandler;
	import com.scyllacharybdis.handlers.ConnectionHandler;
	import com.scyllacharybdis.handlers.LoginHandler;
	import com.scyllacharybdis.handlers.RoomHandler;
	import examples.di.CoreModule;
	import examples.di.TestClass;
	import examples.network.NetworkDriver;
	import examples.physics.PhysicsScene;
	import examples.scene.SceneManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Main extends Sprite 
	{
		private var _window:Window;
		private var _renderer:Renderer;
		private var _sceneManager:SceneManager;
		private var _sceneGraph:SceneGraph;
		
		public function Main():void 
		{		
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Create the injector
			//var injector:Injector = createInjector( new CoreModule(), this );
			//var test1:TestClass = injector.getInstance(TestClass);
			
			// Create a window
			_window = allocate(Window);
			_window.canvas = this;
			
			// Create a rendering system
			_renderer = allocate(Renderer);
			
			// Create a network layer
			var _networkHandler:NetworkEventHandler = allocate(NetworkEventHandler);	
			
			var _connectionHandler:ConnectionHandler = allocate(ConnectionHandler);
			var _loginHandler:LoginHandler = allocate(LoginHandler);
			var _roomHandler:RoomHandler = allocate(RoomHandler);
			var _chatMessageHandler:ChatMessageHandler = allocate(ChatMessageHandler);
			
			// Network driver test
			var networkDriver:NetworkDriver = allocate( NetworkDriver );
			
			// Create the scene manager
			_sceneManager = allocate(SceneManager);

			// Display the intro scene
			_sceneManager.PushScene(PhysicsScene);	
			
		}
		
	}
}