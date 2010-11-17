package core 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import org.casalib.util.ArrayUtil;
	
	import core.BaseObject;
	
	/**
	 */
	public final class GameObject extends BaseObject
	{
		/**
		 * Get the dependencies to instantiate the class
		 */
		public static function get dependencies():Array { return []; }
		
		/****************************************/
		// Constructors and Allocation 
		/****************************************/		
		private var _parent:GameObject = null;
		private var _children:Array = new Array();
		private var _enabled:Boolean = false;
		
		public override function destroy():void		
		{
			// Destroy the children
			for each ( var child:GameObject in _children )
			{
				delete _children[child];
				
				MemoryManager.destroyObject( child );
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
		
		public function get children():Array { return _children; }
		
		public function get enabled():Boolean { return _enabled; }
		public function set enabled( value:Boolean ):void 
		{
			for each ( var child:GameObject in _children )
			{
				child.enabled = value;
			}
			
			var prevEnabled:Boolean = _enabled;
			_enabled = value;
			
			if ( _enabled && !prevEnabled )
			{
				start();
			}
			else if ( !_enabled && prevEnabled ) 
			{
				stop();
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
			
			child.enabled = _enabled;
		}

		/**
		 * Remove a child game object.
		 * @param	child (GameObject)
		 */
		public function removeChild( child:GameObject ):void
		{
			// Stop the child before removing it
			if ( child.enabled )
			{
				child.enabled = false;
			}
			
			// Remove the child from the list
			ArrayUtil.removeItem( _children, child );
		}
	}
}