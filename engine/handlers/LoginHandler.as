package handlers 
{
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.LoginRequest;
	
	import core.BaseObject;	
	
	/**
	 */
	public class LoginHandler extends BaseObject
	{
		
		/****************************************/
		// Type definition
		/****************************************/
		public override function getType():String 
		{
			return LOGIN_HANDLER;
		}
		
		/****************************************/
		// Overide function
		/****************************************/
		
		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public override function engine_awake():void
		{
			owner.sfs.addEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
			owner.sfs.addEventListener(SFSEvent.LOGIN, onLogin);
		}
		
		/**
		* Destroy is called at the removal of the object
		* Unregister listeners
		*/
		public override function engine_destroy():void
		{
			owner.sfs.removeEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
			owner.sfs.removeEventListener(SFSEvent.LOGIN, onLogin);
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
			var request:LoginRequest = new LoginRequest(userName, password);
			owner.sfs.send(request);
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