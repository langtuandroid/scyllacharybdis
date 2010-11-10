package di 
{
	/**
	 */
	public class Description
	{
		public static const NEW_OBJECT:int = 1;
		public static const SINGLETON_OBJECT:int = 2;
		
		private var _type:Class;
		private var _scope:int;
		
		/**
		 * The construtor
		 * @param	type (Class) The type of class that is being described
		 * @param	scope (int) NEW_OBJECT or SINGLETON_OBJECT
		 */
		public function Description(type:Class, scope:int) 
		{
			_type = type;
			_scope = scope;
		}
		
		/**
		 * Get the class type
		 */
		public function get type():Class
		{
			return _type;
		}

		/**
		 * Get the scope
		 */
		public function get scope():int
		{
			return _scope;
		}
	}
}