package engine.di 
{
	/**
	 */
	public class Description
	{
		public static const NEW_OBJECT:int = 1;
		public static const SINGLETON_OBJECT:int = 2;
		
		private final var _type:Class;
		private final var _scope:int;
		
		public function Description(type:Class, scope:int) 
		{
			_type = type;
			_scope = scope;
		}
		
		public function get type():Class
		{
			return _type;
		}

		public function get scope():int
		{
			return _scope;
		}
	}
}