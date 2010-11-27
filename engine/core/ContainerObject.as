package core 
{
	import flash.utils.Dictionary;
	/**
	 */
	public class ContainerObject extends BaseObject
	{

		/****************************************/
		// Class Details
		/****************************************/
		
		private var _components:Dictionary = new Dictionary(true);

		public override function engine_start():void
		{
			super.engine_start();
			
			for each ( var component:BaseObject in _components )
			{
				component.engine_start();
			}
		}

		public override function engine_stop():void
		{
			super.engine_stop();
			
			for each ( var component:BaseObject in _components )
			{
				component.engine_stop();
			}
		}
		
		/**
		 * Add a component to the game object
		 * @param	component (Component)
		 */
		public final function addComponent( componentType:Class, dependencies:Array = null ):void 
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
		}

		/**
		 * Get a component from the game object
		 * @param	type (int) The component id
		 */
		public final function getComponent( type:String ):*
		{
			return _components[type];
		}
		
		public final function removeComponentByType( type:String ):void
		{
			removeComponent( _components[type] );
		}

		/**
		 * Remove a component from the game object
		 * @param	component (Component)
		 */
		public final function removeComponent( component:* ):void
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