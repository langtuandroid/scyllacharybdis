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

			// Setup the component
			component.owner = this;
			_components.push( component );

			// Add the component to the scene graph
			SceneGraph.instance().addComponent( component );
			
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
			
			// Add the component to the scene graph
			removeComponent.instance().addComponent( component );
			
			// Stop the component
			component.stop();
			
			// Remove it from the list
			var index:int = _components.indexOf( component, 0 );
			if ( index >= 0 )
			{
				_components.splice(index, 1);
			}
		}
		/**
		* Awake is called at the construction of the object
		*/
		public function awake( ):void
		{
			addEventListener( Event.ENTER_FRAME, update );
		}

		/**
		* Start is called when the object is added to the scene
		*/
		public function start( ):void		
		{

		}

		/**
		* Stop is called when the object is removed from the scene
		*/
		public function stop():void
		{

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