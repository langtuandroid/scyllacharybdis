package core.objects 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.casalib.math.geom.Point3d;
	import org.casalib.util.ArrayUtil;
	
	import core.memory.MemoryManager;
	import core.objects.ContainerObject;
	
	/**
	 */
	public final class GameObject extends ContainerObject
	{
		
		/****************************************/
		// Class Details
		/****************************************/
		
		private var _parent:GameObject = null;
		private var _children:Array = new Array();
		private var _enabled:Boolean = true;				
		
		protected var _position:Point3d = new Point3d();
		protected var _scale:Point3d = new Point3d();
		protected var _rotation:Number = 0;
		
		/**
		 * The engine contructor
		 * @private
		 */		
		public final override function engine_awake():void
		{
			super.engine_awake();
		}
		
		/**
		 * The engine start method
		 * @private
		 */
		public final override function engine_start():void
		{
			super.engine_start();
		}

		/**
		 * The engine stop function
		 * @private
		 */
		public final override function engine_stop():void
		{
			super.engine_stop();
		}
		
		/**
		 * Destroy is called at the removal of the object
		 * @private
		 */
		public final override function engine_destroy():void		
		{
			super.engine_destroy();

			// Destroy the children
			for each ( var gameObj:GameObject in _children )
			{
				delete _children[gameObj];
				
				MemoryManager.destroy( gameObj );
			}
			
			_children = null;
			_parent = null;
			
		}
		
		/**
		 * Get the parent game object
		 */
		public function get parent():GameObject { return _parent; }
		
		/**
		 * Set the parent game object
		 * @param gameObj (GameObject) The parent game object
		 */
		public function set parent( value:GameObject ):void { _parent = value; }
		
		/**
		 * Get the children game objects
		 */
		public function get children():Array { return _children; }
		
		/**
		 * Is the object enabled
		 */
		public function get enabled():Boolean { return _enabled; }
		
		/**
		 * Set if the object is enabled or not
		 * @param value (Boolean) Enabled
		 */
		public function set enabled( value:Boolean ):void 
		{
			_enabled = value;
		}

		/**
		 * Add a child game object.
		 * @param	child (GameObject)
		 */
		public final function addChild( child:GameObject ):void
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
		public final function removeChild( child:GameObject ):void
		{
			// Stop the child before removing it
			if ( child.enabled )
			{
				child.enabled = false;
			}
			
			// Remove the child from the list
			ArrayUtil.removeItem( _children, child );
		}
		
		/**
		 * Get the local coordinates position.
		 */
		public function get position():Point3d 
		{ 
			return _position;
		}

		/**
		 * Set the local coordinates position
		 * @param position (Point3d) The position to set the game object
		 */
		public function set position( value:Point3d ):void 
		{ 
			_position = value; 
		}
		
		/**
		 * Get the renderobjects local coordinates scale.
		 */
		public function get scale():Point3d 
		{ 
			return _scale;
		}

		/**
		 * Set the renderobjects local coordinates scale.
		 */
		public function set scale( value:Point3d ):void 
		{ 
			_scale = value; 
		}
		
		/**
		 * Get the local coordinates rotation
		 */		
		public function get rotation():Number 
		{ 
			return _rotation;
		}
		
		/**
		 * Set the local coordinates rotation
		 */
		public function set rotation( value:Number):void 
		{ 
			_rotation = value; 
		}
	}
}