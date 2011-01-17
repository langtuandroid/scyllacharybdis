package com.scyllacharybdis.networking.handlers 
{
	import com.scyllacharybdis.constants.NetworkEvents;
	import com.scyllacharybdis.interfaces.IBaseObject;
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.LoginRequest;
	
	/**
	 */
	[Singleton]
	[Requires ("core.events.NetworkEventHandler")]
	public class LoginHandler implements IBaseObject
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
			_networkEventHandler.addEventListener(NetworkEvents.LOGIN, this, requestLogin );
			_networkEventHandler.addEventListener(NetworkEvents.LOGOUT, this, requestLogout );
			
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
			_networkEventHandler.removeEventListener(NetworkEvents.LOGIN, this, requestLogin );
			_networkEventHandler.removeEventListener(NetworkEvents.LOGOUT, this, requestLogout );
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
			_networkEventHandler.sendServerMessage(new LoginRequest(userName, password));
		}

		/**
		 * On login sucess
		 */
		private function onLogin(evt:SFSEvent):void
		{
			_networkEventHandler.fireEvent(NetworkEvents.LOGIN_SUCCESS);
			trace("onLogin sucessful");
		}
		
		/**
		 * An error occurred during login; go back to login panel and display error message.
		 */
		private function onLoginError(evt:SFSEvent):void
		{
			_networkEventHandler.fireEvent(NetworkEvents.LOGIN_FAILED);
			trace("onLoginError");
		}
	}
}