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
		protected var _components:Dictionary = new Dictionary(true);
		protected var _dependencies:Dictionary = new Dictionary(true);

		/****************************************/
		// Construtor and Destructor
		/****************************************/		
		
		/**
		* Awake is called at the construction of the object
		*/
		public function awake( ):void { }
		
		/**
		* Start is called when the object is added to the scene
		*/
		public function start( ):void  { }
		
		/**
		 * Update is called every frame
		 */
		public function update():void { }
		
		/**
		* Stop is called when the object is removed from the scene
		*/
		public function stop( ):void { }
		
		/**
		* Destroy is called at the removal of the object
		*/
		public function destroy( ):void	 { } 

		
		/****************************************/
		// Dependency Methods
		/****************************************/
		
		/** 
		 * Get the object scope 
		 * Override if you want a singleton
		 */
		public static function get scope():int { return BaseObject.NEW_OBJECT };
		
		/**
		 * Return the class dependencies
		 * @returns [dep1, dep2];
		 */
		public static function get dependencies():Array  { return null }

		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 */
		public function set dependencies( value:Dictionary ):void 
		{ 
			_dependencies = value; 
		}

		/**
		 * Get the dependency
		 */
		public function getDependency( type:Class ):*
		{
			return _dependencies[type];
		}
		
		/****************************************/
		// Component Methods
		/****************************************/
		
		/**
		 * Add a component to the game object
		 * @param	component (Component)
		 */
		public function addComponent( component:* ):void 
		{
			if (component == null)
			{
				return;
			}
			
			// Check to see if there is an old one
			if ( _components[component.type] != null )
			{
				// Remove the old component 
				removeComponentByType( component.type );
			}
			
			// Setup the component
			component.owner = this;
			_components[component.type] =  component;

			// Start the component
			component.start();
		}

		/**
		 * Get a component from the game object
		 * @param	type (int) The component id
		 */
		public function getComponent( type:String ):*
		{
			return _components[type];
		}
		
		public function removeComponentByType( type:String ):void
		{
			removeComponent( _components[type] );
		}

		/**
		 * Remove a component from the game object
		 * @param	component (Component)
		 */
		public function removeComponent( component:* ):void
		{
			if (component == null)
			{
				return;
			}
			
			// Stop the component
			component.stop();
			
			// Remove reference from the dictionary
			delete _components[component.type];
		}
		
		public function get type():String 
		{
			return BASE_OBJECT;
		}				
		
	}
}