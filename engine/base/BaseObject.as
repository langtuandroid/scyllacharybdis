package core
{
	import flash.utils.Dictionary;
	import di.Description;
	import di.Dependencies;
	
	/**
	 * BaseObject is a base object for all game elements
	 */
	public class BaseObject
	{
		// These objects are base objects
		public static const BASE_OBJECT:String = "base_object";
		public static const COMPONENT:String = "component";

		// Usable types
		public static const GAME_OBJECT:String = "game_object";
		public static const TRANSFORM_COMPONENT:String = "transform_component";
		public static const RENDER_COMPONENT:String = "render_component";
		public static const SCRIPT_COMPONENT:String = "script_component";
		public static const NETWORK_COMPONENT:String = "network_component";
		public static const CONNECTION_COMPONENT:String = "connection_component";
		public static const STATE_COMPONENT:String = "state_component";

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