package components
{
	import flash.utils.Dictionary;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import org.casalib.math.geom.Point3d;
	
	import core.objects.BaseObject;
	
	/**
	 * 
	 */
	public class RenderComponent extends BaseObject
	{
		/**
		 * Get the dependencies to instantiate the class
		 */
		public static function get dependencies():Array { return []; }
		
		/****************************************/
		// Type definition
		/****************************************/
		public override final function getType():String 
		{
			return RENDER_COMPONENT;
		}				
		
		/****************************************/
		// Class Details
		/****************************************/
		
		protected var _baseclip:MovieClip = null;
		
		/** 
		 * Engine constructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			_baseclip = new MovieClip();
			
			super.engine_awake();
		}
	
		/** 
		 * Engine start
		 * @private
		 */
		public final override function engine_start(): void 
		{
			addListeners();
			
			super.engine_start();
		}
		
		/** 
		 * Engine stop
		 * @private
		 */
		public final override function engine_stop():void
		{
			super.engine_stop();
			removeListeners();
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
		
		public function set baseclip( value:MovieClip ):void { _baseclip = value; }
		public function get baseclip():MovieClip { return _baseclip; }
		
		// For sorting
		public function get comparator():Number { return owner.getComponent( TRANSFORM_COMPONENT ).worldPosition.z }

		/**
		 * Add the renderable to the surface
		 * @param	surface (DisplayObjectContainer) 
		 */
		public function render( surface:DisplayObjectContainer ):void
		{
			surface.addChild( _baseclip );
		}
		
		/**
		 * Erace this from the surface
		 * @param	surface (DisplayObjectContainer) 
		 */
		public function erase( surface:DisplayObjectContainer ):void
		{
			surface.removeChild( _baseclip );
		}

		
		private final function addListeners():void
		{
			var scriptComponent:ScriptComponent = owner.getComponent(SCRIPT_COMPONENT);
			
			if ( scriptComponent != null )
			{
				_baseclip.addEventListener( MouseEvent.CLICK, scriptComponent.onClick, false, 0, true);
				_baseclip.addEventListener( MouseEvent.DOUBLE_CLICK, scriptComponent.onDoubleClick, false, 0, true );
				_baseclip.addEventListener( MouseEvent.MOUSE_DOWN, scriptComponent.onMouseDown, false, 0, true );
				_baseclip.addEventListener( MouseEvent.MOUSE_MOVE, scriptComponent.onMouseMove, false, 0, true );
				_baseclip.addEventListener( MouseEvent.MOUSE_OUT, scriptComponent.onMouseOut, false, 0, true );
				_baseclip.addEventListener( MouseEvent.MOUSE_OVER, scriptComponent.onMouseOver, false, 0, true );
				_baseclip.addEventListener( MouseEvent.MOUSE_UP, scriptComponent.onMouseUp, false, 0, true );
				_baseclip.addEventListener( MouseEvent.MOUSE_WHEEL, scriptComponent.onMouseWheel, false, 0, true );
				_baseclip.addEventListener( MouseEvent.ROLL_OUT, scriptComponent.onRollOut, false, 0, true );
				_baseclip.addEventListener( MouseEvent.ROLL_OVER, scriptComponent.onRollOver, false, 0, true );
				_baseclip.addEventListener( KeyboardEvent.KEY_DOWN, scriptComponent.onKeyDown, false, 0, true );
				_baseclip.addEventListener( KeyboardEvent.KEY_UP, scriptComponent.onKeyUp, false, 0, true );
			}			
		}

		private final function removeListeners():void
		{
			var scriptComponent:ScriptComponent = owner.getComponent(SCRIPT_COMPONENT);
			
			if ( scriptComponent != null )
			{
				if ( _baseclip.hasEventListener(MouseEvent.CLICK) )
				{
					_baseclip.removeEventListener( MouseEvent.CLICK, scriptComponent.onClick );
				}
				
				if ( _baseclip.hasEventListener(MouseEvent.DOUBLE_CLICK) )
				{
					_baseclip.removeEventListener( MouseEvent.DOUBLE_CLICK, scriptComponent.onDoubleClick );
				}
				
				if ( _baseclip.hasEventListener(MouseEvent.MOUSE_DOWN) )
				{
					_baseclip.removeEventListener( MouseEvent.MOUSE_DOWN, scriptComponent.onMouseDown );
				}
				
				if ( _baseclip.hasEventListener(MouseEvent.MOUSE_MOVE) )
				{
					_baseclip.removeEventListener( MouseEvent.MOUSE_MOVE, scriptComponent.onMouseMove );
				}
				
				if ( _baseclip.hasEventListener(MouseEvent.MOUSE_OUT) )
				{
					_baseclip.removeEventListener( MouseEvent.MOUSE_OUT, scriptComponent.onMouseOut );
				}
				
				if ( _baseclip.hasEventListener(MouseEvent.MOUSE_OVER) )
				{
					_baseclip.removeEventListener( MouseEvent.MOUSE_OVER, scriptComponent.onMouseOver );
				}
				
				if ( _baseclip.hasEventListener(MouseEvent.MOUSE_UP) )
				{
					_baseclip.removeEventListener( MouseEvent.MOUSE_UP, scriptComponent.onMouseUp );
				}
				
				if ( _baseclip.hasEventListener(MouseEvent.MOUSE_WHEEL) )
				{
					_baseclip.removeEventListener( MouseEvent.MOUSE_WHEEL, scriptComponent.onMouseWheel );
				}
				
				if ( _baseclip.hasEventListener(MouseEvent.ROLL_OUT) )
				{
					removeEventListener( MouseEvent.ROLL_OUT, scriptComponent.onRollOut );
				}
				
				if ( _baseclip.hasEventListener(MouseEvent.ROLL_OVER) )
				{
					_baseclip.removeEventListener( MouseEvent.ROLL_OVER, scriptComponent.onRollOver );
				}
				
				if ( _baseclip.hasEventListener(KeyboardEvent.KEY_DOWN) )
				{
					_baseclip.removeEventListener( KeyboardEvent.KEY_DOWN, scriptComponent.onKeyDown );
				}
				
				if ( _baseclip.hasEventListener(KeyboardEvent.KEY_UP) )
				{
					_baseclip.removeEventListener( KeyboardEvent.KEY_UP, scriptComponent.onKeyUp );
				}
			}
		}
		
	}
}