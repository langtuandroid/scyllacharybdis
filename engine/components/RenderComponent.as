package components
{
	import flash.utils.Dictionary;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import casalib.math.geom.Point3d;
	
	import core.BaseObject;	
	
	
	/**
	 * 
	 */
	public class RenderComponent extends BaseObject
	{
		/****************************************/
		// Type definition
		/****************************************/
		public override function get type():String 
		{
			return RENDER_COMPONENT;
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
			super.start();
			
			var scriptComponent:ScriptComponent = _owner.getComponent(SCRIPT_COMPONENT);
			
			if ( scriptComponent != null )
			{
				addEventListener( MouseEvent.CLICK, scriptComponent.onClick);
				addEventListener( MouseEvent.DOUBLE_CLICK, scriptComponent.onDoubleClick );
				addEventListener( MouseEvent.MOUSE_DOWN, scriptComponent.onMouseDown );
				addEventListener( MouseEvent.MOUSE_MOVE, scriptComponent.onMouseMove );
				addEventListener( MouseEvent.MOUSE_OUT, scriptComponent.onMouseOut );
				addEventListener( MouseEvent.MOUSE_OVER, scriptComponent.onMouseOver );
				addEventListener( MouseEvent.MOUSE_UP, scriptComponent.onMouseUp );
				addEventListener( MouseEvent.MOUSE_WHEEL, scriptComponent.onMouseWheel );
				addEventListener( MouseEvent.ROLL_OUT, scriptComponent.onRollOut );
				addEventListener( MouseEvent.ROLL_OVER, scriptComponent.onRollOver );
				addEventListener( KeyboardEvent.KEY_DOWN, scriptComponent.onKeyDown );
				addEventListener( KeyboardEvent.KEY_UP, scriptComponent.onKeyUp );
			}
		}
		
		public override function stop():void
		{
			var scriptComponent:ScriptComponent = _owner.getComponent(SCRIPT_COMPONENT);

			if ( hasEventListener(MouseEvent.CLICK) )
			{
				removeEventListener( MouseEvent.CLICK, scriptComponent.onClick );
			}
			
			if ( hasEventListener(MouseEvent.DOUBLE_CLICK) )
			{
				removeEventListener( MouseEvent.DOUBLE_CLICK, scriptComponent.onDoubleClick );
			}
			
			if ( hasEventListener(MouseEvent.MOUSE_DOWN) )
			{
				removeEventListener( MouseEvent.MOUSE_DOWN, scriptComponent.onMouseDown );
			}
			
			if ( hasEventListener(MouseEvent.MOUSE_MOVE) )
			{
				removeEventListener( MouseEvent.MOUSE_MOVE, scriptComponent.onMouseMove );
			}
			
			if ( hasEventListener(MouseEvent.MOUSE_OUT) )
			{
				removeEventListener( MouseEvent.MOUSE_OUT, scriptComponent.onMouseOut );
			}
			
			if ( hasEventListener(MouseEvent.MOUSE_OVER) )
			{
				removeEventListener( MouseEvent.MOUSE_OVER, scriptComponent.onMouseOver );
			}
			
			if ( hasEventListener(MouseEvent.MOUSE_UP) )
			{
				removeEventListener( MouseEvent.MOUSE_UP, scriptComponent.onMouseUp );
			}
			
			if ( hasEventListener(MouseEvent.MOUSE_WHEEL) )
			{
				removeEventListener( MouseEvent.MOUSE_WHEEL, scriptComponent.onMouseWheel );
			}
			
			if ( hasEventListener(MouseEvent.ROLL_OUT) )
			{
				removeEventListener( MouseEvent.ROLL_OUT, scriptComponent.onRollOut );
			}
			
			if ( hasEventListener(MouseEvent.ROLL_OVER) )
			{
				removeEventListener( MouseEvent.ROLL_OVER, scriptComponent.onRollOver );
			}
			
			if ( hasEventListener(KeyboardEvent.KEY_DOWN) )
			{
				removeEventListener( KeyboardEvent.KEY_DOWN, scriptComponent.onKeyDown );
			}
			
			if ( hasEventListener(KeyboardEvent.KEY_UP) )
			{
				removeEventListener( KeyboardEvent.KEY_UP, scriptComponent.onKeyUp );
			}
			
			super.stop();
		}
	}
}