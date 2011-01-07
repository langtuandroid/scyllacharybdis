package handlers 
{
	import core.events.NetworkEvent;
	import core.events.NetworkEventHandler;
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.LoginRequest;
	import models.LoginModel;
	import core.objects.BaseObject;	
	
	/**
	 */
	[Singleton]
	[Requires ("core.events.NetworkEventHandler")]
	public class LoginHandler extends BaseObject
	{
		private var _networkEventHandler:NetworkEventHandler;

		/**
		 * Awake is called at the construction of the object
		 * Register all the listeners
		 * @private
		 */
		public final override function engine_awake():void
		{
			// Get the event manager
			_networkEventHandler = getDependency(NetworkEventHandler);
		
			_networkEventHandler.addEventListener(SFSEvent.LOGIN_ERROR, this, onLoginError);
			_networkEventHandler.addEventListener(SFSEvent.LOGIN, this, onLogin);
			_networkEventHandler.addEventListener(NetworkEvent.NETWORK_LOGIN, this, requestLogin );
			_networkEventHandler.addEventListener(NetworkEvent.NETWORK_LOGOUT, this, requestLogout );
			
			super.engine_start();
			
		}
		
		/**
		 * Engine start should handle engine related start. 
		 * @private
		 */
		public final override function engine_start():void 
		{
			super.engine_start();
		}
		
		/**
		 * Engine stop should handle engine related stop. 
		 * @private
		 */
		public final override function engine_stop():void 
		{
			super.engine_stop();
		}
		
		/**
		 * Destroy is called at the removal of the object
		 * Unregister listeners
		 * @private
		 */
		public final override function engine_destroy():void
		{
			super.engine_destroy();

			_networkEventHandler.removeEventListener(SFSEvent.LOGIN_ERROR, this, onLoginError);
			_networkEventHandler.removeEventListener(SFSEvent.LOGIN, this, onLogin);
			_networkEventHandler.removeEventListener(NetworkEvent.NETWORK_LOGIN, this, requestLogin );
			_networkEventHandler.removeEventListener(NetworkEvent.NETWORK_LOGOUT, this, requestLogout );
		}
		/**
		 * The users constructor. 
		 * Override awake and create any variables and listeners.
		 */
		public override function awake():void
		{
		}
		
		/**
		 * The users start method. 
		 * Start runs when the game object is added to the scene.
		 */
		public override function start():void
		{
		}

		/**
		 * The users stop method.
		 * Stop runs when the game object is added to the scene.
		 */
		public override function stop():void
		{
		}

		/**
		 * The users destructor. 
		 * Override destroy to clean up any variables or listeners.
		 */
		public override function destroy():void
		{
		}
		
		/**
		 * Request login handler
		 * @param	login
		 */
		public function requestLogin( login:LoginModel ):void
		{
			if ( login.type == LoginModel.USER_LOGIN ) 
			{
				this.login(login.name, login.password);
			}
		}
		
		/**
		 * Request logout handler
		 */
		public function requestLogout():void
		{
			trace("logout");
		}
		
		/**
		 * Login to the server
		 * @param	userName (String) Users name
		 * @param	password (String) Users password
		 */
		private function login(userName:String, password:String):void
		{
			var request:LoginRequest = new LoginRequest(userName, password);
			owner.sfs.send(request);
		}

		/**
		 * On login sucess
		 */
		private function onLogin(evt:SFSEvent):void
		{
			_eventHandler.fireEvent("LOGIN_SUCCESS");
			trace("onLogin sucessful");
		}
		
		/**
		 * An error occurred during login; go back to login panel and display error message.
		 */
		private function onLoginError(evt:SFSEvent):void
		{
			_eventHandler.fireEvent("LOGIN_FAILED");
			trace("onLoginError");
		}
	}
}