package components
{
	import adobe.utils.ProductManager;
	import core.ITransformable;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.casalib.math.geom.Point3d;
	
	import core.BaseObject;	

	/**
	 */
	public class TransformComponent extends BaseObject implements ITransformable
	{
		// Find a clever way to get this as some sort global property or something...
		// But it works for now.  
		// Determines 2d rendering with z as layers, or 3d rendering with z as a dimension and perspective applied
		private const MODE_3D:String = "3d";
		private const MODE_2D:String = "2d";
		
		/**
		 * Get the dependencies to instantiate the class
		 */
		public static function get dependencies():Array { return []; }
		
		/****************************************/
		// Type definition
		/****************************************/
		
		public override final function getType():String 
		{
			return TRANSFORM_COMPONENT; 
		}		
		
		/****************************************/
		// Class Details
		/****************************************/
		
		protected var _position:Point3d = new Point3d();
		protected var _scale:Point3d = new Point3d();
		protected var _rotate:Number = 0;
		protected var _dimensions:Point = new Point();
		
		protected var _worldPosition:Point3d = new Point3d();
		protected var _worldScale:Point3d = new Point3d();
		protected var _worldRotate:Number = 0;
		
		private var _mode:String = MODE_2D;		
		
		public final override function engine_awake():void
		{
			super.engine_awake();
		}
		
		public final override function engine_start():void
		{
			super.engine_start();
		}

		public final override function engine_stop():void
		{
			super.engine_stop();
		}

		public final override function engine_destroy():void
		{
			super.engine_destroy();
		}
		
		public function get position():Point3d { return _position; }
		
		public function set position ( value:Point3d ):void 
		{ 
			// Set the local position
			_position = value;
			
			// Cache the global position
			_worldPosition = _position;
			
			// If the parent exists
			if ( owner.parent != null )
			{
				// Set world position from parent's world position
				var parentTransform:TransformComponent = owner.parent.getComponent(TRANSFORM_COMPONENT);
				if ( parentTransform != null )
				{
					_worldPosition = _position.add(parentTransform.position);
				}
			}
			
			// Set the render component
			var renderComponent:RenderComponent = owner.getComponent(RENDER_COMPONENT);
			if ( renderComponent != null )
			{
				renderComponent.baseclip.x = _worldPosition.x;
				renderComponent.baseclip.y = _worldPosition.y;
				if ( _mode == MODE_3D )
				{
					renderComponent.baseclip.z = _worldPosition.z;
				}
			}
		}
		
		public function get worldPosition():Point3d { return _worldPosition; }
		
		public function get scale():Point3d { return _scale; }
		public function set scale ( value:Point3d ):void 
		{ 
			// Set the local scale
			_scale = value;
			
			// Cache the world scale
			_worldScale = _scale;
			
			// If the parent exists
			if (  owner.parent != null )
			{
				// Set world scale from parent's world scale
				var parentTransform:TransformComponent = owner.parent.getComponent(TRANSFORM_COMPONENT);
				if ( parentTransform != null )
				{
					_worldScale.x = parentTransform.scale.x * _scale.x;
					_worldScale.y = parentTransform.scale.y * _scale.y;
					_worldScale.z = parentTransform.scale.z * _scale.z;
				}		
			}
			
			// Set the render component
			var renderComponent:RenderComponent = owner.getComponent(RENDER_COMPONENT);
			if ( renderComponent != null )
			{
				renderComponent.baseclip.scaleX = _worldScale.x;
				renderComponent.baseclip.scaleY = _worldScale.y;
				
				if ( _mode == MODE_3D )
				{
					renderComponent.baseclip.scaleZ = _worldScale.z;
				}
			}
		}
		
		public function get worldScale():Point3d { return _worldScale; }		
	
		public function get rotate():Number { return _rotate; }
		public function set rotate ( value:Number ):void 
		{ 
			// Set the local rotation
			_rotate = value;
			
			// Cache the world rotation
			_worldRotate = _rotate;
			
			// If the parent exists
			if (  owner.parent != null )
			{
				// Set world rotation from parent's world rotation
				var parentTransform:TransformComponent = owner.parent.getComponent(TRANSFORM_COMPONENT);
				if ( parentTransform != null )
				{
					_worldRotate = _rotate + parentTransform.rotate;
				}
			}
			
			// Set the render component
			var renderComponent:RenderComponent = owner.getComponent(RENDER_COMPONENT);
			if ( renderComponent != null )
			{
				renderComponent.baseclip.rotation = _worldRotate;
			}
		}
		
		public function get worldRotate():Number { return _worldRotate; }
		
		public function get dimensions():Point { return _dimensions; }
		public function set dimensions( value:Point ):void 
		{
			// Set the width and height
			_dimensions = value;
			
			// Set the render component
			var renderComponent:RenderComponent = owner.getComponent(RENDER_COMPONENT);
			if ( renderComponent != null )
			{
				renderComponent.baseclip.width = _dimensions.x;
				renderComponent.baseclip.height = _dimensions.y;
			}
		}
	}
}