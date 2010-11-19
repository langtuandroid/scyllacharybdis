package core 
{
	import flash.utils.Dictionary;
	/**
	 */
	public class ContainerObject extends BaseObject
	{

		private var _components:Dictionary = new Dictionary(true);

		/**
		 * Add a component to the game object
		 * @param	component (Component)
		 */
		public function addComponent( componentType:Class, dependencies:Array = null  ):void 
		{
			// Create the new component
			var component:* = MemoryManager.instantiate(componentType, dependencies, this);

			// Check to see if there is an old one
			if ( _components[ component.getType() ] != null )
			{
				// Remove the old component 
				removeComponentByType( component.getType() );
			}

			_components[component.getType()] =  component;

			// Setup the component
			component.engine_start();
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

			// Remove reference from the dictionary
			delete _components[component.getType()];
			
			MemoryManager.destroy(component);
		}
	}
}