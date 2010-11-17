package core
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	
	/**
	 * BaseObject is a base object for all game elements
	 */
	public class BaseObject extends EventDispatcher
	{
		/****************************************/
		// Constants
		/****************************************/		

		// These objects are base objects
		public static const BASE_OBJECT:String = "base_object";
		public static const GAME_OBJECT:String = "game_object";

		// Components
		public static const TRANSFORM_COMPONENT:String = "transform_component";
		public static const RENDER_COMPONENT:String = "render_component";
		public static const SCRIPT_COMPONENT:String = "script_component";
		public static const NETWORK_COMPONENT:String = "network_component";
		public static const STATE_COMPONENT:String = "state_component";
		
		// Handlers
		public static const CONNECTION_HANDLER:String = "connection_handler";
		public static const LOGIN_HANDLER:String = "login_handler";
		public static const ROOM_HANDLER:String = "room_handler";

		// Scopes
		public static const NEW_OBJECT:int = 1;
		public static const SINGLETON_OBJECT:int = 2;
		
		/****************************************/
		// Variables
		/****************************************/		
		private var _dependencies:Dictionary = new Dictionary(true);
		private var _owner:* = null;

		
		/****************************************/
		// Construtor and Destructor
		/****************************************/		

		public function awake():void {}
		public function start():void {}
		public function stop():void {}
		public function destroy():void {}
		
		/**
		* Awake is called at the construction of the object
		*/
		public function engine_awake( ):void 
		{ 
			awake();
		}
		
		/**
		* Start is called when the object is added to the scene
		*/
		public function engine_start():void  
		{ 
			start();
		}
		
		/**
		* Stop is called when the object is removed from the scene
		*/
		public function engine_stop():void 
		{ 
			// Let the users code 
			stop();
		}
		
		
		/**
		* Destroy is called at the removal of the object
		*/
		public function engine_destroy( ):void	 
		{ 
			// Let the users code destroy
			destroy();

			// Destroy the components
			for each ( var dependency:* in _dependencies )
			{
				MemoryManager.destroyObject( dependency );
			}
			
			_dependencies = null;
		} 

		
		/****************************************/
		// Dependency Methods
		/****************************************/
		
		/** 
		 * Get the object scope 
		 * Override if you want a singleton
		 */
		public static function get scope():int { return BaseObject.NEW_OBJECT };

		/**
		 * Get the type definition
		 */
		public function getType():String 
		{
			return BASE_OBJECT;
		}		
		
		/**
		 * Get the dependency
		 */
		public function getDependency( type:Class ):*
		{
			return _dependencies[type];
		}
		
		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 */
		public function setDependencies( value:Dictionary ):void 
		{ 
			_dependencies = value; 
		}
		
		/****************************************/
		// Owner Methods
		/****************************************/
		
		/**
		 * Get the ownering Game Object
		 */
		public function get owner():* { return _owner; }

		/**
		 * Set the ownering Game Object
		 */
		public function set owner( value:* ):void { _owner = value; }		
	}
}