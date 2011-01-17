package com.scyllacharybdis.objects 
{
	import components.RenderComponent;
	import components.ScriptComponent;
	import components.SoundComponent;
	import core.memory.MemoryManager;
	import flash.utils.Dictionary;
	/**
	 */
	public class ContainerObject extends BaseObject
	{

		/****************************************/
		// Class Details
		/****************************************/
		
		private var _components:Dictionary = new Dictionary(true);

		/**
		 * The engine contructor
		 * @private
		 */
		public override function engine_awake():void
		{
			super.engine_awake();
		}
		
		/**
		 * The engine start method
		 * @private
		 */
		public override function engine_start():void
		{
			// Start up anything that has requirements
			if ( getComponent(SoundComponent) ) {
				getComponent(SoundComponent).engine_start();
			}
			if ( getComponent(ScriptComponent) ) {
				getComponent(ScriptComponent).engine_start();
			}
			if ( getComponent(RenderComponent) ) {
				getComponent(RenderComponent).engine_start();
			}

			// Start everything else
			for each ( var component:BaseObject in _components )
			{
				component.engine_start();
			}
			
			super.engine_start();
		}

		/**
		 * The engine stop function
		 * @private
		 */
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
		 * @private
		 */
		public override function engine_destroy():void		
		{
			super.engine_destroy();
		}		
		
		/**
		 * Add a component to the game object
		 * @param	component (Component)
		 */
		public final function addComponent( componentType:Class ):void 
		{
			// Create the new component
			var component:* = MemoryManager.instantiate(componentType, this);
			
			// Check to see if there is an old one
			if ( _components[ component.getComponentType() ] != null )
			{
				// Remove the old component 
				removeComponentByType( component.getComponentType() );
			}

			_components[component.getComponentType()] =  component;

			// Setup the component
			//component.engine_start();
		}

		/**
		 * Get a component from the game object
		 * @param	type (int) The component id
		 */
		public final function getComponent( type:Class ):*
		{
			return _components[type];
		}
		
		public final function removeComponentByType( type:Class ):void
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
			delete _components[component.getComponentType()];
			
			MemoryManager.destroy(component);
		}
	}
}