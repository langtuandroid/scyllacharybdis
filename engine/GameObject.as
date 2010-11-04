package Engine 
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**
	 */
	public class GameObject extends BaseObject
	{
		/** 
		 * Return the type of object
		 */

		public function get type():Number { return GAME_OBJECT; }		
		
		private var _parent:GameObject = null;
		private var _children:Array = new Array();
		private var _components:Array = new Array();

		private var _position:Point = new Point( 0.0, 0.0 );
		private var _worldPosition:Point = new Point( 0.0, 0.0 );
		private var _disabled:Boolean = false;
		
		public function get parent():GameObject { return _parent; }
		public function set parent( value:GameObject ):void { _parent = value; }
		
		public function get postion():Point { return _position; }
		public function get worldPosition():Point { return _worldPosition; }
		public function set position ( value:Point ):void 
		{ 
			// Set the local position
			_position.x = value.x;
			_position.y = value.y;
			
			// Cache the world position
			_worldPosition.x = value.x;
			_worldPosition.y = value.y;
			
			// If the parent exists
			if ( _parent != null )
			{
				// Set world position from parent's world position
				var parentPos:Point = _parent.worldPosition;
				_worldPosition.x = _position.x + parentPos.x;
				_worldPosition.y = _position.y + parentPos.y;
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
		 * @param	type (Number) The component id
		 */
		public function getComponent( type:Number ):Component
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
		* Awake is called at the construction of the object
		*/
		public override function awake():void
		{
		}

		/**
		* Start is called when the object is added to the scene
		*/
		public override function start():void		
		{
		}

		/**
		* Stop is called when the object is removed from the scene
		*/
		public override function stop():void
		{
		}

		/**
		* Destroy is called at the removal of the object
		*/
		public override function destroy():void		
		{
			// Destroy the children
			// Destroy the components
		}
		
		/**
		 * Update each frame
		 */
		public override function update():void
		{
			updateChildren();
			updateComponents();
		}

		/**
		 * Helper function: Update all children ( should be an event )
		 */
		private function updateChildren():void 
		{
			for each ( var child:SceneObject in _children ) 
			{
				child.update();
			}
		}
		
		/**
		 * Helper function: Update all components ( should be an event )
		 */
		private function updateComponents( ):void 
		{
			for each ( var component:Component in _components ) 
			{
				if ( component.type != Component.RENDER_COMPONENT )
				{
					component.update();
				}
			}
			
			var renderComponent:RenderComponent = getComponent( Component.RENDER_COMPONENT ) as RenderComponent;
			
			if ( renderComponent != null ) 
			{
				renderComponent.update();
			}
		}
	}
}