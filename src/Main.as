package 
{
	import com.scyllacharybdis.constants.NetworkEvents;
	import com.scyllacharybdis.core.memory.allocate;
	import com.scyllacharybdis.graphics.rendering.Backbuffer;
	import com.scyllacharybdis.graphics.rendering.Renderer;
	import com.scyllacharybdis.graphics.rendering.Window;
	import com.scyllacharybdis.graphics.scenegraph.SceneGraph;
	import com.scyllacharybdis.interfaces.IPhysicsComponent;
	import com.scyllacharybdis.networking.handlers.ChatMessageHandler;
	import com.scyllacharybdis.networking.handlers.ConnectionHandler;
	import com.scyllacharybdis.networking.handlers.LoginHandler;
	import com.scyllacharybdis.networking.handlers.RoomHandler;
	import com.scyllacharybdis.networking.NetworkEventHandler;
	import com.scyllacharybdis.physics.PhysicsSceneComponent;
	import com.scyllacharybdis.scenemanager.SceneManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import examples.physics.PhysicsScene;
	
	public class Main extends Sprite 
	{
		private var _renderer:Renderer;
		
		public function Main():void 
		{		
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			// Create the window
			var window:Window = allocate(Window);
			window.displayContext = this;

			// Create the scenegraph and add the physics component
			var sceneGraph:SceneGraph = allocate( SceneGraph );
			sceneGraph.addComponent( PhysicsSceneComponent, allocate(PhysicsSceneComponent) );
			
			// Create a rendering system and inject the graph and window
			_renderer = allocate(Renderer, sceneGraph, window);
			
			// Create a network layer
			var networkHandler:NetworkEventHandler = allocate(NetworkEventHandler);
			var connectionHandler:ConnectionHandler = allocate(ConnectionHandler, networkHandler);
			var loginHandler:LoginHandler = allocate(LoginHandler, networkHandler);
			var roomHandler:RoomHandler = allocate(RoomHandler, networkHandler);
			var chatMessageHandler:ChatMessageHandler = allocate(ChatMessageHandler, networkHandler);
			
			// Fire a network connection event
			networkHandler.fireEvent(NetworkEvents.CONNECT);

			// Create the scene manager
			var sceneManager:SceneManager = allocate(SceneManager, sceneGraph);

			// Display the intro scene
			sceneManager.PushScene(PhysicsScene);	

			addEventListener( Event.ENTER_FRAME, onEnterFrame );
			
		}

		private function onEnterFrame( e:Event ):void
		{
			_renderer.render();
		}
	}
}