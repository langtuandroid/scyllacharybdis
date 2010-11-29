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
		
		
		public final override function engine_awake():void
		{
			super.engine_awake();
			addComponent( TransformComponent );
		}
		
		public final override function engine_start():void
		{
			super.engine_start();
		}

		public final override function engine_stop():void
		{
			super.engine_stop();
		}
		
		/**
		* Destroy is called at the removal of the object
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
		
		public function get parent():GameObject { return _parent; }
		public function set parent( value:GameObject ):void { _parent = value; }
		
		public function get children():Array { return _children; }
		
		public function get enabled():Boolean { return _enabled; }
		public function set enabled( value:Boolean ):void 
		{
			//for each ( var child:GameObject in _children )
			//{
			//	child.enabled = value;
			//}
			
			//var prevEnabled:Boolean = _enabled;
			_enabled = value;
			
			//if ( _enabled && !prevEnabled )
			//{
			//	engine_start();
			//}
			//else if ( !_enabled && prevEnabled ) 
			//{
			//	engine_stop();
			//}			
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
		public function get position():Point3d { return getComponent( TRANSFORM_COMPONENT).position; }
		public function set position( value:Point3d ):void { getComponent( TRANSFORM_COMPONENT).position = value; }
		
		public function get scale():Point3d { return getComponent( TRANSFORM_COMPONENT).scale; }
		public function set scale( value:Point3d ):void { getComponent( TRANSFORM_COMPONENT).scale = value; }
		
		public function get rotate():Number { return getComponent( TRANSFORM_COMPONENT).rotate; }
		public function set rotate( value:Number):void { getComponent( TRANSFORM_COMPONENT).rotate = value; }
		
		public function get dimensions():Point { return getComponent( TRANSFORM_COMPONENT).dimensions; }
		public function set dimensions( value:Point ):void { getComponent( TRANSFORM_COMPONENT).dimensions = value; }
		
		public function get worldPosition():Point3d { return getComponent( TRANSFORM_COMPONENT).worldPosition; }
		public function get worldScale():Point3d { return getComponent( TRANSFORM_COMPONENT).worldScale; }
		public function get worldRotate():Number { return getComponent( TRANSFORM_COMPONENT).worldRotate; }
		
	}
}