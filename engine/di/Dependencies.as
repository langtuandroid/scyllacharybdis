package di 
{
	import flash.utils.Dictionary;
	
	/**
	 */
	public class Dependencies
	{
		private  var _dependencies:Dictionary = new Dictionary();
		
		/**
		 * Constructor
		 * @param	types (Class) A comman delimited list of depencencies
		 */
		public function Dependencies( ... types:Array ):void
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