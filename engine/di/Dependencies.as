package engine.di 
{
	/**
	 */
	public class Dependencies
	{
		private  var _dependencies:Dictionary = new Dictionary();
		
		public function Dependencies( types:Class ... ) 
		{
			for each( var type:Class in types ) 
			{
				_dependencies[type] = type;
			}
		}
		
		public function get dependencies()
		{
			return _dependencies;
		}
	}
}