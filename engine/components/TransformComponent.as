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
		protected var _worldRotation:Number = 0;
		
		private var _mode:String = MODE_2D;		
		
		/** 
		 * Engine constructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			super.engine_awake();
		}
		
		/** 
		 * Engine start
		 * @private
		 */
		public final override function engine_start():void
		{
			super.engine_start();
		}

		/** 
		 * Engine stop
		 * @private
		 */
		public final override function engine_stop():void
		{
			super.engine_stop();
		}
		
		/** 
		 * Engine destructor
		 * @private
		 */
		public final override function engine_destroy():void
		{
			super.engine_destroy();
		}
		
		/**
		 * The users constructor. 
		 * Override awake and create any variables and listeners.
		 */
		public override function awake():void
		{
		}
		
		/**
		 * The users start method. 
		 * Start runs when the game object is added to the scene.
		 */
		public override function start():void
		{
		}

		/**
		 * The users stop method.
		 * Stop runs when the game object is added to the scene.
		 */
		public override function stop():void
		{
		}

		/**
		 * The users destructor. 
		 * Override destroy to clean up any variables or listeners.
		 */
		public override function destroy():void
		{
		}		
		
		/**
		 * Get the local coordinates position.
		 */
		public function get position():Point3d { return _position; }

		/**
		 * Set the local coordinates position
		 * @param position (Point3d) The position to set the game object
		 */
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
		
		/**
		 * Get the renderobjects local coordinates scale.
		 */
		public function get scale():Point3d { return _scale; }
		
		/**
		 * Set the renderobjects local coordinates scale.
		 */
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
		
		/**
		 * Get the local coordinates rotation
		 */
		public function get rotate():Number { return _rotate; }

		/**
		 * Set the local coordinates rotation
		 */
		public function set rotate ( value:Number ):void 
		{ 
			// Set the local rotation
			_rotate = value;
			
			// Cache the world rotation
			_worldRotation = _rotate;
			
			// If the parent exists
			if (  owner.parent != null )
			{
				// Set world rotation from parent's world rotation
				var parentTransform:TransformComponent = owner.parent.getComponent(TRANSFORM_COMPONENT);
				if ( parentTransform != null )
				{
					_worldRotation = _rotate + parentTransform.rotate;
				}
			}
			
			// Set the render component
			var renderComponent:RenderComponent = owner.getComponent(RENDER_COMPONENT);
			if ( renderComponent != null )
			{
				renderComponent.baseclip.rotation = _worldRotation;
			}
		}

		/**
		 * Get the dimentions ( what is this )
		 */
		public function get dimensions():Point { return _dimensions; }

		/**
		 * Set the dimentions ( what is this )
		 */
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
		
		/**
		 * Get the world position
		 * @private
		 */
		public function get worldPosition():Point3d { return _worldPosition; }

		/**
		 * Set the world position
		 * @private
		 */
		public function set worldPosition(value:Point3d):void 
		{
			_worldPosition = value; 
		}
		
		/**
		 * Get the world scale
		 * @private
		 */
		public function get worldScale():Point3d { return _worldScale; }		

		/**
		 * Set the world scale
		 * @private
		 */
		public function set worldScale(value:Point3d):void 
		{
			_worldScale = value; 
		}
		
		/**
		 * Get the world rotation
		 * @private
		 */
		public function get worldRotation():Number { return _worldRotation; }

		/**
		 * Set the world rotation
		 * @private
		 */
		public function set worldRotation(value:Number):void 
		{
			_worldRotation = value; 
		}
		
	}
}