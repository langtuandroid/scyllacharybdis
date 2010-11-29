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

		public override function engine_awake():void
		{
			super.engine_awake();
		}
		
		public override function engine_start():void
		{
			// Start up anything that has requirements
			if ( _components[SOUND_COMPONENT] ) {
				_components[SOUND_COMPONENT].engine_start();
			}
			if ( _components[SCRIPT_COMPONENT] ) {
				_components[SCRIPT_COMPONENT].engine_start();
			}
			if ( _components[RENDER_COMPONENT] ) {
				_components[RENDER_COMPONENT].engine_start();
			}

			// Start everything else
			for each ( var component:BaseObject in _components )
			{
				component.engine_start();
			}
			
			super.engine_start();
		}

		public override function engine_stop():void
		{
			for each ( var component:BaseObject in _components )
			{
				component.engine_stop();
			}
			super.engine_stop();
		}
		
		/**
		* Destroy is called at the removal of the object
		*/
		public override function engine_destroy():void		
		{
			super.engine_destroy();
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

			// Setup the component
			//component.engine_start();
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