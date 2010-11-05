package engine.components
{
	import adobe.utils.ProductManager;
	import org.casalib.math.geom;

	/**
	 */
	public function TransformComponent extends Component {
	
		public override function get type():int { return TRANSFORM_COMPONENT; }
		
		private var _position:Point3d = new Point3d( 0.0, 0.0 );
		private var _scale:Point3d = new Point3d( 0.0, 0.0 );
		private var _rotate:Number = new Point3d(0);
		
		private var _worldPosition:Point3d = new Point3d( 0.0, 0.0 );
		private var _worldScale:Point3d = new ( 0.0, 0.0 );
		private var _worldRotate:Point3d = new Point3d( 0.0, 0.0 );
		
		public function get postion():Point3d { return _position; }
		public function set position ( value:Point3d ):void 
		{ 
			// Set the local position
			_position.x = value.x;
			_position.y = value.y;
			
			// If the parent exists
			if ( _parent != null )
			{
				// Set world position from parent's world position
				var parentPos:Point3d = owner()._parent.getComponent(TRANSFORM_COMPONENT).worldPosition();
				_worldPosition.x = _position.x + parentPos.x;
				_worldPosition.y = _position.y + parentPos.y;
			}
		}
		
		public function get worldPosition():Point3d { return _worldPosition; }
		
		public function get scale():Point3d { return _scale; }
		public function set scale ( value:Point3d ):void 
		{ 
			// Set the local scale
			_scale.x = value.x;
			_scale.y = value.y;
			
			// If the parent exists
			if ( _parent != null )
			{
				// Set world scale from parent's world scale
				var parentScale:Point3d = owner()._parent.getComponent(TRANSFORM_COMPONENT).worldScale();
				_worldScale.x = _position.x + parentScale.x;
				_worldScale.y = _position.y + parentScale.y;
			}
		}
		
		public function get worldScale():Point3d { return _worldScale; }		
	}

		public function get rotate():Number { return _rotate; }
		public function set rotate ( value:Number ):void 
		{ 
			// Set the local rotation
			_rotate = value;
			
			// If the parent exists
			if ( _parent != null )
			{
				// Set world rotation from parent's world rotation
				var parentRotate:Number = owner()._parent.getComponent(TRANSFORM_COMPONENT).rotate();
				_worldRotate = _rotate + parentRotate;
			}
		}
		
		public function get worldScale():Point3d { return _worldRotate; }		
	}
	
}