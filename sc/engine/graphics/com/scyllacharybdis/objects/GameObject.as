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