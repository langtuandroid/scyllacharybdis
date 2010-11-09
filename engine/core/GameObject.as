package engine.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import engine.components.Component;
	import engine.core.SceneGraph;
	
	/**
	 */
	public class GameObject extends BaseObject
	{
		
		/****************************************/
		// Type definition
		/****************************************/
		public override function get type():String 
		{
			return GAME_OBJECT;
		}
	
		/****************************************/
		// Dependency Injection calls
		/****************************************/
		
		/** 
		 * Return the type of object
		 */
		public static function get type():String { return BASE_OBJECT; }
		
		/**
		 * Return the class description
		 */
		public static function get description():Description  
		{ 
			return new Description( getQualifiedClassName(this), NEW_OBJECT );
		}

		/**
		 * Return the class dependencies
		 */
		public static function get dependencies():Dependencies  
		{
			return Dependencies(SceneGraph);
		}

		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 */
		private var _sceneGraph;
		public function set dependencies( dep:Dictionary ):void 
		{ 
			_sceneGraph = dep[SceneGraph];
		}
		

		/****************************************/
		// Overide function
		/****************************************/
		
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
		
		/****************************************/
		// Class specific
		/****************************************/
		protected var _parent:GameObject = null;
		protected var _children:Array = new Array();
		protected var _components:Dictionary = new Dictionary();
		protected var _disabled:Boolean = false;
		
		public function get parent():GameObject { return _parent; }
		public function set parent( value:GameObject ):void { _parent = value; }
		
		public function get disabled():Boolean { return _disabled; }
		public function set disabled( value:Boolean ):void 
		{
			_disabled = value;
			
			if ( _disabled )
			{
				stop();
			}
			else
			{
				start();
			}

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
			_components[component.type] =  component;

			// Add the component to the scene graph
			_sceneGraph.addComponent( component );
			
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
			
			// Remove the component from the scenegraph
			_sceneGraph.removeComponent( component );
			
			// Stop the component
			component.stop();
			
			// Remove it from the list
			var index:int = _components.indexOf( component, 0 );
			if ( index >= 0 )
			{
				_components.splice(index, 1);
			}

	}
}