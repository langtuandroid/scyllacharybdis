package engine.components
{
	import adobe.utils.ProductManager;
	import org.casalib.math.geom.Point3d;

	/**
	 */
	public class TransformComponent extends Component 
	{
		public override function get type():int { return TRANSFORM_COMPONENT; }
		
		private var _position:Point3d = new Point3d();
		private var _scale:Point3d = new Point3d();
		private var _rotate:Number = new Point3d();
		
		private var _worldPosition:Point3d = new Point3d();
		private var _worldScale:Point3d = new Point3d();
		private var _worldRotate:Point3d = new Point3d();
		
		public function get position():Point3d { return _position; }
		public function set position ( value:Point3d ):void 
		{ 
			// Set the local position
			_position = value;
			
			// If the parent exists
			if ( _owner.parent != null )
			{
				// Set world position from parent's world position
				var parentPos:Point3d = (_owner.parent.getComponent(TRANSFORM_COMPONENT) as TransformComponent).worldPosition;
				_worldPosition = _position.add(parentPos);
			}
		}
		
		public function get worldPosition():Point3d { return _worldPosition; }
		
		public function get scale():Point3d { return _scale; }
		public function set scale ( value:Point3d ):void 
		{ 
			// Set the local scale
			_scale = value;
			
			// If the parent exists
			if ( _owner.parent != null )
			{
				// Set world scale from parent's world scale
				var parentScale:Point3d = (_owner.parent.getComponent(TRANSFORM_COMPONENT) as TransformComponent).scale;
				_worldScale = _scale.add(parentScale); 
			}
		}
		
		public function get worldScale():Point3d { return _worldScale; }		
	
		public function get rotate():Number { return _rotate; }
		public function set rotate ( value:Number ):void 
		{ 
			// Set the local rotation
			_rotate = value;
			
			// If the parent exists
			if ( _owner.parent != null )
			{
				// Set world rotation from parent's world rotation
				var parentRotate:Number = (_owner.parent.getComponent(TRANSFORM_COMPONENT) as TransformComponent).rotate;
				_worldRotate = _rotate.add(parentRotate);
			}
		}
		
		public function get worldScale():Point3d { return _worldRotate; }		
	}
}