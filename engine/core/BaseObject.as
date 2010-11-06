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
		public static const BASE_OBJECT:int = 0;
		public static const COMPONENT:int = 0;

		// Usable types
		public static const GAME_OBJECT:int = 1;
		public static const TRANSFORM_COMPONENT:int = 2;
		public static const RENDER_COMPONENT:int = 3;
		public static const SCRIPT_COMPONENT:int = 4;
		public static const NETWORK_COMPONENT:int = 5;
		
		public function BaseObject()
		{
			trace("To create an object use Instantiate(Class)");
		}
		
		/**
		* Awake is called at the construction of the object
		*/
		public function awake( ):void
		{
			addEventListener( Event.ENTER_FRAME, update );
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
			removeEventListener( Event.ENTER_FRAME, update );
		} 
		
		/**
		 * Update each frame
		 */
		public function update( e:Event ):void
		{
			
		}
		
		/** 
		 * Return the type of object
		 */
		public function get type():int { return BASE_OBJECT; }
	}
}