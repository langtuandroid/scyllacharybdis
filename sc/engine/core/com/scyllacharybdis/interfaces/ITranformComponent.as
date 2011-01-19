package com.scyllacharybdis.interfaces 
{
	import org.casalib.math.geom.Point3d;
	
	/**
	 * ...
	 * @author 
	 */
	public interface ITranformComponent extends IBaseComponent
	{
		/**
		 * Get the local coordinates position.
		 */
		function get position():Point3d;

		/**
		 * Set the local coordinates position
		 * @param position (Point3d) The position to set the game object
		 */
		function set position( value:Point3d ):void;

		/**
		 * Get the renderobjects local coordinates scale.
		 */
		function get scale():Point3d;

		/**
		 * Set the renderobjects local coordinates scale.
		 */
		function set scale( value:Point3d ):void;
		
		/**
		 * Get the local coordinates rotation
		 */		
		function get rotation():Number;
		
		/**
		 * Set the local coordinates rotation
		 */
		function set rotation( value:Number):void;
	}
}