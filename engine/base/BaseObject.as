package base
{
	import flash.utils.Dictionary;
	
	/**
	 * BaseObject is a base object for all game elements
	 */
	public class BaseObject
	{
		/****************************************/
		// Type definition
		/****************************************/
		public function get type():String 
		{
			return BASE_OBJECT;
		}
	
		/****************************************/
		// Dependency Injection calls
		/****************************************/
		
		/**
		 * Return the class description
		 */
		public static function get description():Description  { return null; }

		/**
		 * Return the class dependencies
		 */
		public static function get dependencies():Dependencies  { return null; }

		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 */
		public function set dependencies( dep:Dictionary ):void { return; }
	
		
		/****************************************/
		// Public virtual methods
		/****************************************/
		
		/**
		* Awake is called at the construction of the object
		*/
		public function awake( ):void { return; }
		
		/**
		* Start is called when the object is added to the scene
		*/
		public function start( ):void  { return; }
		
		/**
		* Stop is called when the object is removed from the scene
		*/
		public function stop( ):void { return; }
		
		/**
		* Destroy is called at the removal of the object
		*/
		public function destroy( ):void	 { return; } 
	}
}