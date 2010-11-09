package engine.components
{

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import org.casalib.math.geom.Point3d;
	
	/**
	 * 
	 */
	public class RenderComponent extends Component
	{
		/****************************************/
		// Type definition
		/****************************************/
		public override function get type():String 
		{
			return RENDER_COMPONENT;
		}				
		
		/****************************************/
		// Dependency Injection calls
		/****************************************/
		
		/**
		 * Return the class description
		 */
		public static function get description():Description  
		{ 
			return new Description( getQualifiedClassName(this), false );
		}

		/**
		 * Return the class dependencies
		 */
		public static function get dependencies():Dependencies  
		{
		}

		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 */
		private var _sceneGraph;
		public function set dependencies( dep:Dictionary ):void 
		{ 
		}
		
		/****************************************/
		// Overide function
		/****************************************/
		
		
		/****************************************/
		// Class specific
		/****************************************/
		protected var _baseclip:MovieClip = null;
		
		public function set baseclip( value:MovieClip ):void { _baseclip = value; }
		public function get baseclip():MovieClip { return _baseclip; }
		
		// For z-sorting
		public function get z():Number { return _baseclip.z; }

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
		
		/**
		 * Init listeners on start
		 */ 
		public override function start(): void 
		{
			var scriptComponent:ScriptComponent = _owner.getComponent(SCRIPT_COMPONENT);
			
			if ( scriptComponent != null )
			{
				_baseclip.onMouseDown = function( e:MouseEvent ):void 
				{	
					scriptComponent.onMouseDown();
				}
				
				_baseclip.onMouseUp = function( e:MouseEvent ):void 
				{
					scriptComponentoOnMouseUp();
				}
				
				_baseclip.onClick = function( e:MouseEvent ):void 
				{
						scriptComponent.onClick();
				}
				
				_baseclip.onDoubleClick = function( e:MouseEvent ):void 
				{
					scriptComponent.onDoubleClick();
				}
				
				_baseclip.onMouseOver = function( e:MouseEvent ):void 
				{
					scriptComponent.onMouseOver();
				}
				
				_baseclip.onMouseOut = function( e:MouseEvent ):void 
				{
					scriptComponent.onMouseOut();
				}
				
				_baseclip.onMouseMove = function( e:MouseEvent ):void 
				{
					scriptComponent.onMouseMove();
				}
				
				_baseclip.onMouseWheel = function( e:MouseEvent ):void 
				{
					scriptComponent.onMouseWheel();
				}
				
				_baseclip.onRollOver = function( e:MouseEvent ):void 
				{
					scriptComponent.onRollOver();
				}
				
				_baseclip.onRollOut = function( e:MouseEvent ):void 
				{
					scriptComponent.onRollOut();
				}
				
				_baseclip.onKeyDown = function( e:MouseEvent ):void 
				{
					scriptComponent.onKeyDown();
				}
				
				_baseclip.onKeyUp = function( e:MouseEvent ):void 
				{
					scriptComponent.onKeyUp();
				}
				
				addEventListener( MouseEvent.CLICK, onClick );
				addEventListener( MouseEvent.DOUBLE_CLICK, onDoubleClick );
				addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
				addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
				addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
				addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
				addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
				addEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
				addEventListener( MouseEvent.ROLL_OUT, onRollOut );
				addEventListener( MouseEvent.ROLL_OVER, onRollOver );
				addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
				addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			}
		}
		
		public override function stop():void
		{
			if ( hasEventListener(MouseEvent.CLICK) )
			{
				removeEventListener( MouseEvent.CLICK, onClick );
			}
			
			if ( hasEventListener(MouseEvent.DOUBLE_CLICK) )
			{
				removeEventListener( MouseEvent.DOUBLE_CLICK, onDoubleClick );
			}
			
			if ( hasEventListener(MouseEvent.MOUSE_DOWN) )
			{
				removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			}
			
			if ( hasEventListener(MouseEvent.MOUSE_MOVE) )
			{
				removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			}
			
			if ( hasEventListener(MouseEvent.MOUSE_OUT) )
			{
				removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			}
			
			if ( hasEventListener(MouseEvent.MOUSE_OVER) )
			{
				removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			}
			
			if ( hasEventListener(MouseEvent.MOUSE_UP) )
			{
				removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			}
			
			if ( hasEventListener(MouseEvent.MOUSE_WHEEL) )
			{
				removeEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
			}
			
			if ( hasEventListener(MouseEvent.ROLL_OUT) )
			{
				removeEventListener( MouseEvent.ROLL_OUT, onRollOut );
			}
			
			if ( hasEventListener(MouseEvent.ROLL_OVER) )
			{
				removeEventListener( MouseEvent.ROLL_OVER, onRollOver );
			}
			
			if ( hasEventListener(KeyboardEvent.KEY_DOWN) )
			{
				removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			}
			
			if ( hasEventListener(KeyboardEvent.KEY_UP) )
			{
				removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			}
			
			super.stop();
		}
	}
}