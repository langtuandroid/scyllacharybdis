package engine.handlers 
{
	/**
	 */
	public class LoginHandler extends Handler
	{
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