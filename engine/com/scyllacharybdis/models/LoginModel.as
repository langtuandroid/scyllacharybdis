package com.scyllacharybdis.models 
{
	/**
	 */
	public class LoginModel 
	{
		public static const USER_LOGIN:int = 1;
		public static const FACEBOOK_LOGIN:int = 2;
		
		private var _name:String;
		private var _password:String;
		private var _type:int;
		
		/**
		 * Login Model constructor
		 * @param	name (String) The players name
		 * @param	pass (String) The players password in clear text
		 * @param	type (int) 
		 */
		public function LoginModel( name:String, pass:String, type:int ) 
		{
			_name = name;
			_password = pass;
			_type = type;
		}
		
		/**
		 * Get the players name
		 */
		public function get name():String { return _name; };
		
		/**
		 * Get the password
		 */
		public function get password():String { return _password; };
		
		/**
		 * Get the type
		 */
		public function get type():int { return _type; };
	}
}