package examples
{
	/**
	 */
	public function Login extends NetworkComponent 
	{
		_roomName:String = "The Lobby";
		
		/**
		 * Login user.
		 */
		private function login():void
		{
			var username:String = loginPanel.ti_username.text;
			var request:LoginRequest = new LoginRequest(username);
			NetworkLayer.sfs.send(request);
		}
	}
}