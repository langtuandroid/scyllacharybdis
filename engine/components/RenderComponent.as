package components
{
	import flash.utils.Dictionary;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import org.casalib.math.geom.Point3d;
	
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
		
		// For sorting
		public function get comparator():Number { return _baseclip.z; }

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
				_baseclip.addEventListener( MouseEvent.CLICK, scriptComponent.onClick);
				_baseclip.addEventListener( MouseEvent.DOUBLE_CLICK, scriptComponent.onDoubleClick );
				_baseclip.addEventListener( MouseEvent.MOUSE_DOWN, scriptComponent.onMouseDown );
				_baseclip.addEventListener( MouseEvent.MOUSE_MOVE, scriptComponent.onMouseMove );
				_baseclip.addEventListener( MouseEvent.MOUSE_OUT, scriptComponent.onMouseOut );
				_baseclip.addEventListener( MouseEvent.MOUSE_OVER, scriptComponent.onMouseOver );
				_baseclip.addEventListener( MouseEvent.MOUSE_UP, scriptComponent.onMouseUp );
				_baseclip.addEventListener( MouseEvent.MOUSE_WHEEL, scriptComponent.onMouseWheel );
				_baseclip.addEventListener( MouseEvent.ROLL_OUT, scriptComponent.onRollOut );
				_baseclip.addEventListener( MouseEvent.ROLL_OVER, scriptComponent.onRollOver );
				_baseclip.addEventListener( KeyboardEvent.KEY_DOWN, scriptComponent.onKeyDown );
				_baseclip.addEventListener( KeyboardEvent.KEY_UP, scriptComponent.onKeyUp );
			}
		}
		
		public override function stop():void
		{
			var scriptComponent:ScriptComponent = _owner.getComponent(SCRIPT_COMPONENT);

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
			
			super.stop();
		}
	}
}