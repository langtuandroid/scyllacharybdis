package com.scyllacharybdis.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface ITranformComponent extends IBaseComponent
	{
		/**
		 * Get the local coordinates position.
		 */
		public function get position():Point3d;

		/**
		 * Set the local coordinates position
		 * @param position (Point3d) The position to set the game object
		 */
		public function set position( value:Point3d ):void;

		/**
		 * Get the renderobjects local coordinates scale.
		 */
		public function get scale():Point3d;

		/**
		 * Set the renderobjects local coordinates scale.
		 */
		public function set scale( value:Point3d ):void;
		
		/**
		 * Get the local coordinates rotation
		 */		
		public function get rotation():Number;
		
		/**
		 * Set the local coordinates rotation
		 */
		public function set rotation( value:Number):void;
	}
}