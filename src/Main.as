package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import core.Renderer;
	import core.MemoryManager;
	import core.EventManager;
	import core.SceneManager;
	import core.NetworkObject;
	import handlers.ConnectionHandler;
	import handlers.LoginHandler;
	import handlers.RoomHandler;
	import handlers.MessageHandler;
	import handlers.ChatMessageHandler;
	import IntroScene;
	import NetworkDriver;
	import ChatExample;
	
	
	public class Main extends Sprite 
	{
		private var _renderer:Renderer;
		private var _networkObject:NetworkObject;
		private var _eventManager:EventManager;
		private var _sceneManager:SceneManager;
		private var _networkDriver:NetworkDriver;
		private var _chatExample:ChatExample;
		
		public function Main():void 
		{		
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Create a rendering system
			_renderer = MemoryManager.instantiate(Renderer, Renderer.dependencies);
			
			// Create the event manager
			_eventManager = MemoryManager.instantiate(EventManager);
			
			// Create the scene manager
			_sceneManager = new SceneManager();

			// Create a network layer
			_networkObject = MemoryManager.instantiate(NetworkObject);			
			_networkObject.addComponent(ConnectionHandler, [EventManager]);
			_networkObject.addComponent(LoginHandler, [EventManager]);
			_networkObject.addComponent(RoomHandler, [EventManager]);
			_networkObject.addComponent(ChatMessageHandler, [EventManager]);
			_networkObject.addComponent(MessageHandler, [EventManager]);

			// Create an example network driver
			_networkDriver = MemoryManager.instantiate( NetworkDriver, [EventManager] );
			_chatExample = MemoryManager.instantiate( ChatExample, [EventManager] );

			// Fire a network connection event
			_eventManager.fireEvent("NETWORK_CONNECT");
			
			// Display the intro scene
			_sceneManager.PushScene(IntroScene);			

			addEventListener( Event.ENTER_FRAME, onEnterFrame );
			
		}

		private function onEnterFrame( e:Event ):void
		{
			_renderer.render(this);
		}
	}
}