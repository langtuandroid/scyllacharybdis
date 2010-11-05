package Engine 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	/**
	 */
	public class GameObject extends BaseObject
	{
		/** 
		 * Return the type of object
		 */
		public function get type():int { return GAME_OBJECT; }		
		
		protected var _parent:GameObject = null;
		protected var _children:Array = new Array();
		protected var _components:Array = new Array();
		protected var _disabled:Boolean = false;
		
		public function get parent():GameObject { return _parent; }
		public function set parent( value:GameObject ):void { _parent = value; }
		
		public function get disabled():Boolean { return _disabled; }
		public function set disabled( value:Boolean ):void 
		{
			_disabled = value;

			for each ( var obj:GameObject in _children )
			{
				obj.disabled = value;
			}			
		}

		/**
		 * Add a child game object.
		 * @param	child (GameObject)
		 */
		public function addChild( child:GameObject ):void
		{
			// Attach to the tree
			child.parent = this;
			_children.push( child );
			
			// Start the game object
			child.start();
		}

		/**
		 * Remove a child game object.
		 * @param	child (GameObject)
		 */
		public function removeChild( child:GameObject ):void
		{
			// Stop the child before removing it
			child.stop();
			
			// Remove the child from the list
			var index:int = _children.indexOf( child );
			
			if ( index >= 0 )
			{
				_children.splice( index, 1 );
			}
		}

		/**
		 * Add a component to the game object
		 * @param	component (Component)
		 */
		public function addComponent( component:Component ):void 
		{
			if (component == null)
			{
				return;
			}
			
			component.owner = this;
			
			_components.push( component );
			
			// Start the component
			component.start();
		}

		/**
		 * Get a component from the game object
		 * @param	type (int) The component id
		 */
		public function getComponent( type:int ):Component
		{
			for each ( var component:Component in _components ) 
			{
				if ( component.type == type)
				{
					return component;
				}
			}
			
			return null;
		}

		/**
		 * Remove a component from the game object
		 * @param	component (Component)
		 */
		public function removeComponent( component:Component ):void
		{
			if (component == null)
			{
				return;
			}
			
			component.stop();
			
			var index:int = _components.indexOf( component, 0 );
			if ( index >= 0 )
			{
				_components.splice(index, 1);
			}
		}

		/*
		 * Render to the screen
		 * @param surface (DisplayObjectContainer) The display.
		 */
		public function render( surface:DisplayObjectContainer ):void 
		{
			var renderComponent:RenderComponent = getComponent( Component.RENDER_COMPONENT ) as RenderComponent;
			
			if ( renderComponent != null )
			{
				renderComponent.render( surface );
			}
			
			for each ( var child:SceneObject in _children ) 
			{
				child.render( surface );
			}
		}
		
		/*
		 * Erasing from the screen
		 * @param surface (DisplayObjectContainer) The display.
		 */
		public function erase( surface:DisplayObjectContainer ):void
		{
			for each ( var child:GameObject in _children ) 
			{
				child.erase( surface );
			}
			
			var renderComponent:RenderComponent = getComponent( BaseObject.RENDER_COMPONENT ) as RenderComponent;
			
			if ( renderComponent != null )
			{
				renderComponent.erase( surface );
			}
		}
		
		/**
		* Destroy is called at the removal of the object
		*/
		public override function destroy():void		
		{
			// Destroy the children
			for each ( var gameObj:GameObject in _children )
			{
				MemoryManager.instance.destroy( gameObj );
			}
			
			// Destroy the components
			for each ( var component:Component in _components )
			{
				MemoryManager.instance.destroy( component );
			}
			
			super.destroy();
		}
	}
}