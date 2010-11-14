package core
{
	import components.Component;
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
		// Variables
		/****************************************/		
		private var _components:Dictionary = new Dictionary(true);
		private var _dependencies:Dictionary = new Dictionary(true);
		private var _type:Class;

		/****************************************/
		// Construtor and Destructor
		/****************************************/		
		
		/**
		* Awake is called at the construction of the object
		*/
		public function awake( ):void 	{ 	
											for each ( var dependency:* in _dependencies )
											{
												if ( dependency is Component )
												{
													addComponent( dependency );
												}
											}
										}
		
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
		// Dependency Methods ( should be all final )
		/****************************************/
		
		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 */
		public function setDependencies( value:Dictionary ):void 
		{ 
			_dependencies = value; 
		}

		/**
		 * Get the dependency helper function
		 */
		public function getDependency( type:Class ):*
		{
			return _dependencies[type];
		}
		
		public function get type():Class
		{
			return _type;
		}
		
		public function set type( value:Class ):void 
		{
			_type = value;
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
		public function getComponent( type:Class ):*
		{
			return _components[type];
		}
		
		public function removeComponentByType( type:Class ):void
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
			delete _components[component.getType()];
		}
		
		public function get components():Dictionary
		{
			return _components;
		}
	}
}