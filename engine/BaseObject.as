package Engine 
{
	import flash.events.EventDispatcher;
	import Engine.EngineEvent;
	
	/**
	 * BaseObject is a base object for all game elements
	 */
	class BaseObject extends EventDispatcher
	{
		public static const GAME_OBJECT:Number = 1;
		public static const RENDER_COMPONENT:Number = 2;
		public static const SCRIPT_COMPONENT:Number = 3;	
		
		public function BaseObject()
		{
			trace("To create an object use Instantiate(Class)");
			
			addEventListener( EngineEvent.AWAKE, onAwake );
		}
		
		/**
		* Awake is called at the construction of the object
		*/
		public function onAwake( e:EngineEvent ):void
		{
			removeEventListener( EngineEvent.AWAKE, onAwake );
			
			addEventListener( EngineEvent.DESTROY, onDestroy );
			addEventListener( EngineEvent.START, onStart );
			addEventListener( EngineEvent.STOP, onStop );
			addEventListener( EngineEvent.UPDATE, onUpdate );
		}

		/**
		* Start is called when the object is added to the scene
		*/
		public function onStart( e:EngineEvent ):void		
		{
			
		}

		/**
		* Stop is called when the object is removed from the scene
		*/
		public function onStop( e:EngineEvent ):void
		{
			
		}

		/**
		* Destroy is called at the removal of the object
		*/
		public function onDestroy( e:EngineEvent ):void		
		{
			removeEventListener( EngineEvent.DESTROY, onDestroy );
			removeEventListener( EngineEvent.START, onStart );
			removeEventListener( EngineEvent.STOP, onStop );
			removeEventListener( EngineEvent.UPDATE, onUpdate );
			
			// Delete the object ( should be replaced with a cache )
			delete this;
		} 
		
		/**
		 * Update each frame
		 */
		public function onUpdate( e:EngineEvent ):void
		{
			
		}
		
		/** 
		 * Return the type of object
		 */
		public function get type():Number { return 0; }
	}
}