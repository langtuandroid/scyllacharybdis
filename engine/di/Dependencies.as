package engine.di 
{
	/**
	 */
	public class Dependencies
	{
		private  var _dependencies:Dictionary = new Dictionary();
		public function Dependencies( deps:Class ... ) 
		{
			for each( var dep:Component in deps ) {
				_dependencies[dep] = dep;
			}
		}
	}
}