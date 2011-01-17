package com.scyllacharybdis.networking.handlers 
{
	import com.scyllacharybdis.constants.NetworkEvents;
	import com.scyllacharybdis.interfaces.IBaseObject;
	import com.scyllacharybdis.networking.models.LoginModel;
	import com.scyllacharybdis.networking.NetworkEventHandler;
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.LoginRequest;
	
	/**
	 */
	[Singleton]
	public class LoginHandler implements IBaseObject
	{
		private var _networkEventHandler:NetworkEventHandler;

		/**
		 * Awake is called at the construction of the object
		 * Register all the listeners
		 * @private
		 */
		public function LoginHandler(networkEventHandler:NetworkEventHandler):void
		{
			// Get the event manager
			_networkEventHandler = networkEventHandler;
		
			_networkEventHandler.addEventListener(SFSEvent.LOGIN_ERROR, this, onLoginError);
			_networkEventHandler.addEventListener(SFSEvent.LOGIN, this, onLogin);
			_networkEventHandler.addEventListener(NetworkEvents.LOGIN, this, requestLogin );
			_networkEventHandler.addEventListener(NetworkEvents.LOGOUT, this, requestLogout );
		}
		
		/**
		 * Destroy is called at the removal of the object
		 * Unregister listeners
		 * @private
		 */
		public function destroy():void
		{
			_networkEventHandler.removeEventListener(SFSEvent.LOGIN_ERROR, this, onLoginError);
			_networkEventHandler.removeEventListener(SFSEvent.LOGIN, this, onLogin);
			_networkEventHandler.removeEventListener(NetworkEvents.LOGIN, this, requestLogin );
			_networkEventHandler.removeEventListener(NetworkEvents.LOGOUT, this, requestLogout );
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