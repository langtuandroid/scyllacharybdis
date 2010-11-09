package engine.di 
{
	/**
	 */
	public class Dependencies
	{
		private  var _dependencies:Dictionary = new Dictionary();
		
		public function Dependencies( deps:Class ... ) 
		{
			for each( var dep:BaseObject in deps ) 
			{
				_dependencies[dep] = dep;
			}
		}
		
		public function get dependencies()
		{
			return _dependencies;
		}
	}
}