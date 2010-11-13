package core 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import core.SceneGraph;
	import core.MemoryManager;
	import core.BaseObject;
	
	[Requirements (MemoryManager, SceneGraph)]
	public class GameObject extends BaseObject
	{

		/****************************************/
		// Constructors and Allocation 
		/****************************************/
		private var _memoryManager:MemoryManager;
		private var _sceneGraph:SceneGraph;
		
		protected var _parent:GameObject = null;
		protected var _children:Array = new Array();
		protected var _disabled:Boolean = false;				
		
		/**
		* Awake is called at the construction of the object
		*/
		public override function awake( ):void
		{
			super.awake();
			
			_memoryManager = getDependency(MemoryManager);
			_sceneGraph = getDependency(SceneGraph);
			
		}

		/**
		* Start is called when the object is added to the scene
		*/
		public override function start( ):void		
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
			_sceneGraph.removeGameObject( this );
			
			// Destroy the children
			for each ( var gameObj:GameObject in _children )
			{
				_memoryManager.destroyObject( gameObj );
			}
			
			// Destroy the components
			for each ( var component:BaseObject in components )
			{
				_memoryManager.destroyObject( component );
			}
			
			_memoryManager = null;
			_sceneGraph = null;
			
			super.destroy();
		}
		
		/****************************************/
		// Trees
		/****************************************/
		
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
	}
}