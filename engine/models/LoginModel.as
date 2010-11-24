package models 
{
	/**
	 */
	public class LoginModel 
	{
		public const var USER_LOGIN = 1;
		public const var FACEBOOK_LOGIN = 2;
		
		private var _name:String;
		private var _password:String;
		private var _type:int;
		
		public function LoginModel( name:String, pass:String, type:int ) 
		{
			_name = name;
			_password = pass;
			_type = type;
		}
		
		public function get name():String { return _name; };
		public function get password():String { return _password; };
		public function get type():int { return _type; };
	}
}