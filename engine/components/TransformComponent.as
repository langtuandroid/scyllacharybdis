package components
{
	import adobe.utils.ProductManager;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.casalib.math.geom.Point3d;
	
	import core.BaseObject;	

	/**
	 */
	public class TransformComponent extends BaseObject 
	{
		/****************************************/
		// Type definition
		/****************************************/
		public override final function getType():String 
		{
			return TRANSFORM_COMPONENT; 
		}		
		
		/****************************************/
		// Overide function
		/****************************************/
		
		
		/****************************************/
		// Class specific
		/****************************************/
		protected var _position:Point3d = new Point3d();
		protected var _scale:Point3d = new Point3d();
		protected var _rotate:Number = 0;
		protected var _dimensions:Point = new Point();
		
		protected var _worldPosition:Point3d = new Point3d();
		protected var _worldScale:Point3d = new Point3d();
		protected var _worldRotate:Number = 0;
		
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
				var parentPos:Point3d = ( owner.parent.getComponent(TRANSFORM_COMPONENT) as TransformComponent).worldPosition;
				_worldPosition = _position.add(parentPos);
			}
			
			// Set the render component
			var renderComponent:RenderComponent = ( owner.getComponent(RENDER_COMPONENT) as RenderComponent);
			renderComponent.baseclip.x = _worldPosition.x;
			renderComponent.baseclip.y = _worldPosition.y;
			renderComponent.baseclip.z = _worldPosition.z;
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
				var parentScale:Point3d = ( owner.parent.getComponent(TRANSFORM_COMPONENT) as TransformComponent).scale;
				_worldScale.x = parentScale.x * _scale.x;
				_worldScale.y = parentScale.y * _scale.y;
				_worldScale.z = parentScale.z * _scale.z;
			}
			
			// Set the render component
			var renderComponent:RenderComponent = ( owner.getComponent(RENDER_COMPONENT) as RenderComponent);
			renderComponent.baseclip.scaleX = _worldScale.x;
			renderComponent.baseclip.scaleY = _worldScale.y;
			renderComponent.baseclip.scaleZ = _worldScale.z;
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
				var parentRotate:Number = ( owner.parent.getComponent(TRANSFORM_COMPONENT) as TransformComponent).rotate;
				_worldRotate = parentRotate + _rotate;
			}
			
			// Set the render component
			var renderComponent:RenderComponent = ( owner.getComponent(RENDER_COMPONENT) as RenderComponent);
			renderComponent.baseclip.rotation = _worldRotate;
		}
		
		public function get worldRotate():Number { return _worldRotate; }
		
		public function get dimensions():Point { return _dimensions; }
		public function set dimensions( value:Point ):void 
		{
			// Set the width and height
			_dimensions = value;
			
			// Set the render component
			var renderComponent:RenderComponent = ( owner.getComponent(RENDER_COMPONENT) as RenderComponent);
			renderComponent.baseclip.width = _dimensions.x;
			renderComponent.baseclip.height = _dimensions.y;
		}
	}
}