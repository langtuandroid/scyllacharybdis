package engine.di 
{
	/**
	 */
	public class Dependencies
	{
		private  var _dependencies:Dictionary = new Dictionary();
		
		/**
		 * Constructor
		 * @param	types (Class) A comman delimited list of depencencies
		 */
		public function Dependencies( types:Class ... ) 
		{
			for each( var type:Class in types ) 
			{
				_dependencies[type] = type;
			}
		}
		
		/** 
		 * Return the dependencies
		 */
		public function get dependencies():Dictionary 
		{
			return _dependencies;
		}
	}
}