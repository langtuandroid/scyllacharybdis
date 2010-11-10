package base 
{
	import flash.utils.Dictionary;
	/**
	 */
	public class DIObject
	{
		protected var _dependencies:Dictionary;
		
		/** 
		 * Get the object scope 
		 * Override if you want a singleton
		 */
		public static function get scope():int { base.NEW_OBJECT };
		
		/**
		 * Return the class dependencies
		 * @returns [dep1, dep2];
		 */
		public static function get dependencies():Array  { return; }

		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 */
		public function set dependencies( dep:Dictionary ):void 
		{ 
			_dependencies = dep; 
		}

		/**
		 * Get the dependency
		 */
		public function getDepencency( type:Class ):*
		{
			return _dependencies[type];
		}
	}
}