package core.objects
{
	import core.memory.MemoryManager;
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
		public static const STATE_COMPONENT:String = "state_component";
		public static const SOUND_COMPONENT:String = "sound_component";
		public static const PHYSICS_COMPONENT:String = "physics_component";
		
		
		// Handlers
		public static const CONNECTION_HANDLER:String = "connection_handler";
		public static const LOGIN_HANDLER:String = "login_handler";
		public static const ROOM_HANDLER:String = "room_handler";
		public static const MESSAGE_HANDLER:String = "message_handler";
		public static const CHATMESSAGE_HANDLER:String = "chatmessage_handler";

		// Scopes
		public static const NEW_OBJECT:int = 1;
		public static const SINGLETON_OBJECT:int = 2;
		
		/****************************************/
		// Variables
		/****************************************/		
		private var _dependencies:Dictionary = new Dictionary(true);
		private var _owner:* = null;

		private var _awake:Boolean = false;
		private var _started:Boolean = false;

		/****************************************/
		// Construtor and Destructor
		/****************************************/		

		public function awake():void {}
		public function start():void {}
		public function stop():void {}
		public function destroy():void {}
		
		/**
		 * Awake is called at the construction of the object
		 * @private
		 */
		public function engine_awake():void 
		{ 
			if ( awaked == true ) {
				return;
			}
			awaked = true;
			
			// Call the users awake
			awake();
		}
		
		/**
		 * Start is called when the object is added to the scene
		 * @private
		 */
		public function engine_start():void  
		{ 
			if ( started == true ) {
				return;
			}
			started = true;
			
			// Call the users start
			start();
		}
		
		/**
		 * Stop is called when the object is removed from the scene
		 * @private
		 */
		public function engine_stop():void 
		{ 
			started = false;
			
			// Call the users stop
			stop();
		}
		
		
		/**
		 * Destroy is called at the removal of the object
		 * @private
		 */
		public function engine_destroy():void	 
		{ 
			awaked = false;
			
			// Call the users destroy
			destroy();

			// Destroy the components
			for each ( var dependency:* in _dependencies )
			{
				MemoryManager.destroy( dependency );
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
		public final function getDependency( type:Class ):*
		{
			return _dependencies[type];
		}
		
		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 * @private
		 */
		public final function setDependencies( value:Dictionary ):void 
		{ 
			_dependencies = value; 
		}

		/**
		 * Has the object been awaken
		 * @private
		 */
		public function get awaked():Boolean { return _awake; }
		
		/**
		 * Set if the object has been awakened
		 * @private
		 */
		public function set awaked(value:Boolean):void  {	_awake = value;	}

		/**
		 * Has the object been started
		 * @private
		 */
		public function get started():Boolean { return _started; }
		
		/**
		 * Set if the object has been started
		 * @private
		 */
		public function set started(value:Boolean):void  {_started = value;}
		
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