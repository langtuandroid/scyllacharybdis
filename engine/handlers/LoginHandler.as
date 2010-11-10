package handlers 
{
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import di.Dependencies;
	import di.Description;
	
	/**
	 */
	public class LoginHandler extends Component
	{
		/****************************************/
		// Overide function
		/****************************************/
		
		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public override function awake():void
		{
			_networkManager.addEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
			_networkManager.addEventListener(SFSEvent.LOGIN, onLogin);
		}
		
		/**
		* Destroy is called at the removal of the object
		* Unregister listeners
		*/
		public override function destroy():void
		{
			_networkManager.removeEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
			_networkManager.removeEventListener(SFSEvent.LOGIN, onLogin);
		}

		/****************************************/
		// Class specific
		/****************************************/
		
		/**
		 * Login to the server
		 * @param	userName (String) Users name
		 * @param	password (String) Users password
		 */
		public function login(userName:String, password:String):void
		{
			var request:LoginRequest = new LoginRequest(username, password);
			_networkManager.send(request);
		}
		
		/****************************************/
		// Event Handlers
		/****************************************/
		
		/**
		 * An error occurred during login; go back to login panel and display error message.
		 */
		private function onLoginError(evt:SFSEvent):void
		{
		}

		/**
		 * On login, show the chat view.
		 */
		private function onLogin(evt:SFSEvent):void
		{
			// Pass this off to the room handler
			owner.joinRoom();
		}
	}
}