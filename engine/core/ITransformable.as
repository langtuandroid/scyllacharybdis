package core 
{
	import flash.geom.Point;
	import org.casalib.math.geom.Point3d;
	
	/**
	 * Interface for a transform component or anything that has a transform component
	 * 
	 * @author 
	 */
	public interface ITransformable 
	{
		// Position relative to parent
		function get position():Point3d;
		function set position( value:Point3d ):void;
		
		// Scale relative to parent
		function get scale():Point3d;
		function set scale( value:Point3d ):void;
		
		// Rotation relative to parent
		function get rotation():Number;
		function set rotation( value:Number ):void;
		
		// Dimensions
		function get dimensions():Point;
		function set dimensions( value:Point ):void;
		
		// World (absolute) position
		function get worldPosition():Point3d;

		// World (absolute) scale
		function get worldScale():Point3d;
		
		// World (absolute) rotate
		function get worldRotation():Number;
	}
	
}