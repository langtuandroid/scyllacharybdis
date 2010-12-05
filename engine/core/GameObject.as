package core 
{
	import components.TransformComponent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.casalib.math.geom.Point3d;
	import org.casalib.util.ArrayUtil;
	
	import core.MemoryManager;
	import core.ContainerObject;
	
	/**
	 */
	public final class GameObject extends ContainerObject implements ITransformable
	{
		
		/****************************************/
		// Class Details
		/****************************************/
		
		private var _parent:GameObject = null;
		private var _children:Array = new Array();
		private var _enabled:Boolean = true;				
		
		/**
		 * The engine contructor
		 * @private
		 */		
		public final override function engine_awake():void
		{
			super.engine_awake();
			addComponent( TransformComponent );
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
		
		//====================================================
		//	For ITransformable Interface
		//
		// 	Just relegate everything back to the transform
		//	component.
		//
		//  Saves the hassle of having to get the transform
		// 	component each and every time you want to 
		//	something...
		//====================================================
		/**
		 * Get the local coordinates position.
		 */
		public function get position():Point3d 
		{ 
			if ( getComponent( TRANSFORM_COMPONENT) == null ) 
			{
				return null;
			}
			return getComponent( TRANSFORM_COMPONENT).position; 
		}

		/**
		 * Set the local coordinates position
		 * @param position (Point3d) The position to set the game object
		 */
		public function set position( value:Point3d ):void 
		{ 
			if ( getComponent( TRANSFORM_COMPONENT) == null ) 
			{
				return;
			}
			getComponent( TRANSFORM_COMPONENT).position = value; 
		}
		
		/**
		 * Get the renderobjects local coordinates scale.
		 */
		public function get scale():Point3d 
		{ 
			if ( getComponent( TRANSFORM_COMPONENT) == null ) 
			{
				return null;
			}
			return getComponent( TRANSFORM_COMPONENT).scale; 
		}

		/**
		 * Set the renderobjects local coordinates scale.
		 */
		public function set scale( value:Point3d ):void 
		{ 
			if ( getComponent( TRANSFORM_COMPONENT) == null ) 
			{
				return;
			}
			getComponent( TRANSFORM_COMPONENT).scale = value; 
		}
		
		/**
		 * Get the local coordinates rotation
		 */		
		public function get rotate():Number 
		{ 
			if ( getComponent( TRANSFORM_COMPONENT) == null ) 
			{
				return -1;
			}
			return getComponent( TRANSFORM_COMPONENT).rotate; 
		}
		
		/**
		 * Set the local coordinates rotation
		 */
		public function set rotate( value:Number):void 
		{ 
			if ( getComponent( TRANSFORM_COMPONENT) == null ) 
			{
				return;
			}
			getComponent( TRANSFORM_COMPONENT).rotate = value; 
		}
		
		/**
		 * Get the dimentions ( what is this )
		 */
		public function get dimensions():Point 
		{ 
			if ( getComponent( TRANSFORM_COMPONENT) == null ) 
			{
				return null;
			}
			return getComponent( TRANSFORM_COMPONENT).dimensions; 
		}
		
		/**
		 * Set the dimentions ( what is this )
		 */
		public function set dimensions( value:Point ):void 
		{ 
			if ( getComponent( TRANSFORM_COMPONENT) == null ) 
			{
				return;
			}
			getComponent( TRANSFORM_COMPONENT).dimensions = value; 
		}
		
		/**
		 * Get the world position
		 * @private
		 */		
		public function get worldPosition():Point3d 
		{ 
			if ( getComponent( TRANSFORM_COMPONENT) == null ) 
			{
				return null;
			}
			return getComponent( TRANSFORM_COMPONENT).worldPosition; 
		}
		
		/**
		 * Get the world scale
		 * @private
		 */		
		public function get worldScale():Point3d 
		{ 
			if ( getComponent( TRANSFORM_COMPONENT) == null ) 
			{
				return null;
			}
			return getComponent( TRANSFORM_COMPONENT).worldScale; 
		}
		
		/**
		 * Get the world rotation
		 * @private
		 */
		public function get worldRotate():Number 
		{ 
			if ( getComponent( TRANSFORM_COMPONENT) == null ) 
			{
				return -1;
			}
			return getComponent( TRANSFORM_COMPONENT).worldRotate; 
		}
		
	}
}