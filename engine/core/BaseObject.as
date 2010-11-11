package core
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	
	/**
	 * BaseObject is a base object for all game elements
	 */
	public class BaseObject
	{
		/****************************************/
		// Constants
		/****************************************/		

		// These objects are base objects
		public static const BASE_OBJECT:String = "base_object";
		public static const GAME_OBJECT:String = "game_object";

		// Components
		public static const COMPONENT:String = "component";
		public static const TRANSFORM_COMPONENT:String = "transform_component";
		public static const RENDER_COMPONENT:String = "render_component";
		public static const SCRIPT_COMPONENT:String = "script_component";
		public static const NETWORK_COMPONENT:String = "network_component";
		public static const CONNECTION_COMPONENT:String = "connection_component";
		public static const STATE_COMPONENT:String = "state_component";

		// Scopes
		public static const NEW_OBJECT:int = 1;
		public static const SINGLETON_OBJECT:int = 2;
		
		/****************************************/
		// Variables
		/****************************************/		
		protected var _owner:* = null;
		protected var _components:Dictionary = new Dictionary();
		protected var _dependencies:Dictionary;

		/****************************************/
		// Construtor and Destructor
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
		public static function get dependencies():Array  { return null; }

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
		
		/****************************************/
		// Component Methods
		/****************************************/
		
		/**
		 * Add a component to the game object
		 * @param	component (Component)
		 */
		public function addComponent( component:Class ):void 
		{
			if (component == null)
			{
				return;
			}

			// Check to see if there is an old one
			if ( _components.contains[component.type] ) 
			{
				// Remove the old component 
				removeComponent( Class(getDefinitionByName(getQualifiedClassName( _components.contains[component.type] ))));
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
		public function getComponent( type:Class ):*
		{
			return _components[type];
		}

		/**
		 * Remove a component from the game object
		 * @param	component (Component)
		 */
		public function removeComponent( component:Class ):void
		{
			if (component == null)
			{
				return;
			}
			
			// Stop the component
			component.stop();
			
			delete _components[component.type];
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