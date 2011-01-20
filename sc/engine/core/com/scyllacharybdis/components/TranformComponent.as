package com.scyllacharybdis.components 
{
	import com.scyllacharybdis.interfaces.ITranformComponent;
	import org.casalib.math.geom.Point3d;
	
	/**
	 * ...
	 * @author 
	 */
	[Component type="TranformComponent"]
	public class TranformComponent implements ITranformComponent
	{
		protected var _position:Point3d = new Point3d();
		protected var _scale:Point3d = new Point3d();
		protected var _rotation:Number = 0;
		
		public function awake( owner:* ):void
		{
		}
		
		public function update():void 
		{
		}
		
		public function destroy():void 
		{
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