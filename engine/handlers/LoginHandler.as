package engine.handlers 
{
	/**
	 */
	public class LoginHandler extends Handler
	{
		
		/****************************************/
		// Dependency Injection calls
		/****************************************/
		
		/** 
		 * Return the type of object
		 */
		public static function get type():String { return BASE_OBJECT; }
		
		/**
		 * Return the class description
		 */
		public static function get description():Description  { return null; }

		/**
		 * Return the class dependencies
		 */
		public static function get dependencies():Dependencies  { return null; }

		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 */
		public function set dependencies( dep:Dictionary ):void { return null; }
		
		/****************************************/
		// Overide function
		/****************************************/
		
		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public override function awake():void
		{
			NetworkManager.sfs.addEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
			NetworkManager.sfs.addEventListener(SFSEvent.LOGIN, onLogin);
		}
		
		/**
		* Destroy is called at the removal of the object
		* Unregister listeners
		*/
		public override function destroy():void
		{
			NetworkManager.sfs.removeEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
			NetworkManager.sfs.removeEventListener(SFSEvent.LOGIN, onLogin);
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
			NetworkManager.sfs.send(request);
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