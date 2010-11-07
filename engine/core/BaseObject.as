package engine.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * BaseObject is a base object for all game elements
	 */
	class BaseObject extends EventDispatcher
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
		
		public function BaseObject()
		{
			trace("To create an object use Instantiate(Class)");
		}
		
		/**
		* Awake is called at the construction of the object
		*/
		public function awake( ):void
		{
		
		}
		
		/**
		* Start is called when the object is added to the scene
		*/
		public function start( ):void		
		{
		
		}
		
		/**
		* Stop is called when the object is removed from the scene
		*/
		public function stop( ):void
		{
		
		}
		
		/**
		* Destroy is called at the removal of the object
		*/
		public function destroy( ):void		
		{
			
		} 
		
		/**
		 * Update each frame
		 */
		public function update( e:Event = null ):void
		{
			
		}
		
		/** 
		 * Return the type of object
		 */
		public function get type():String { return BASE_OBJECT; }
	}
}