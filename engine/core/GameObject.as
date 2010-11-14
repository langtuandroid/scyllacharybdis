package core 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import core.SceneGraph;
	import core.MemoryManager;
	import core.BaseObject;
	
	/**
	 */
	public final class GameObject extends BaseObject
	{
		/****************************************/
		// Constructors and Allocation 
		/****************************************/		
		protected var _parent:GameObject = null;
		protected var _children:Array = new Array();
		protected var _disabled:Boolean = false;				
		
		/**
		* Destroy is called at the removal of the object
		*/
		public override function destroy():void		
		{
			// Destroy the children
			for each ( var gameObj:GameObject in _children )
			{
				delete _children[gameObj];
				
				MemoryManager.destroyObject( gameObj );
			}
			
			_children = null;
			_parent = null;
			
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