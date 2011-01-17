package com.scyllacharybdis.objects 
{
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import com.scyllacharybdis.core.memory.deallocate;
	import com.scyllacharybdis.interfaces.IBaseObject;
	import com.scyllacharybdis.interfaces.IComponent;
	import com.scyllacharybdis.interfaces.IRenderComponent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.casalib.math.geom.Point3d;
	import org.casalib.util.ArrayUtil;
	
	/**
	 */
	public final class GameObject implements IBaseObject
	{
		/****************************************/
		// Class Details
		/****************************************/
		
		private var _parent:GameObject = null;
		private var _children:Array = new Array();
		private var _enabled:Boolean = true;		
		private var _components:Dictionary = new Dictionary(true);
		
		protected var _position:Point3d = new Point3d();
		protected var _scale:Point3d = new Point3d();
		protected var _rotation:Number = 0;

		/**
		 * Constructor
		 */
		public function GameObject():void
		{
		}
		
		/**
		 * Destructor
		 */
		public function destroy():void
		{
		}
		
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
		
		
		/**
		 * Add a component to the container
		 * @param	component (Component)
		 */
		public final function addComponent( component:IComponent ):void 
		{
			_components[component] = component;
		}		

		/**
		 * Remove a component 
		 * @param	component (Component)
		 */
		public final function removeComponent( component:IComponent ):void 
		{
			_components[component] = null;
		}
		
		public function start():void 
		{
			for each ( var comp:IComponent in _components )
			{
				comp.awake(this);
			}			
		}
		
		public function updateComponents():void 
		{
			for each ( var comp:IComponent in _components )
			{
				comp.update();
			}
			
		}
		
		public function stop():void 
		{
			for each ( var comp:IComponent in _components )
			{
				comp.destroy();
			}			
		}
		
		public function getComponent( compType:Class ):Array 
		{
			var complist:Array = new Array();
			for each ( var comp:IComponent in _components )
			{
				if ( comp is compType )
				{
					complist.push( comp );
				}
			}			
			return complist;
		}

		/**
		 * Get all the components
		 * @return
		 */
		public final function getComponents():Dictionary
		{
			return _components;
		}
	}
}