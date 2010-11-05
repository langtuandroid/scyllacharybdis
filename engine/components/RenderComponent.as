package engine.components
{

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * 
	 */
	public class RenderComponent extends Component
	{
		public override function get type():Number { return RENDER_COMPONENT; }

		protected var _baseclip:MovieClip = null;
		
		public function set baseclip( value:MovieClip ):void { _baseclip = value; }	

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
		
		// Hack 
		public function initUI(): void 
		{
			_baseclip.onMouseDown = function( e:MouseEvent ):void 
			{
				var scriptComponent:ScriptComponent = this.owner.getComponent(SCRIPT_COMPONENT);
				
				if (scriptComponent != null) 
				{
					scriptComponent.onMouseDown();
				}
			}
			
			_baseclip.onMouseUp = function( e:MouseEvent ):void 
			{
				var scriptComponent:ScriptComponent = this.owner.getComponent(SCRIPT_COMPONENT);
				
				if (scriptComponent != null) 
				{
					scriptComponentoOnMouseUp();
				}
			}
			
			_baseclip.onClick = function( e:MouseEvent ):void 
			{
				var scriptComponent:ScriptComponent = this.owner.getComponent(SCRIPT_COMPONENT);
				
				if (scriptComponent != null) 
				{
					scriptComponent.onClick();
				}
			}
			
			_baseclip.onDoubleClick = function( e:MouseEvent ):void 
			{
				var scriptComponent:ScriptComponent = this.owner.getComponent(SCRIPT_COMPONENT);
				
				if (scriptComponent != null) 
				{
					scriptComponent.onDoubleClick();
				}
			}
			
			_baseclip.onMouseOver = function( e:MouseEvent ):void 
			{
				var scriptComponent:ScriptComponent = this.owner.getComponent(SCRIPT_COMPONENT);
				
				if (scriptComponent != null) 
				{
					scriptComponent.onMouseOver();
				}
			}
			
			_baseclip.onMouseOut = function( e:MouseEvent ):void 
			{
				var scriptComponent:ScriptComponent = this.owner.getComponent(SCRIPT_COMPONENT);
				
				if (scriptComponent != null) 
				{
					scriptComponent.onMouseOut();
				}
			}
			
			_baseclip.onMouseMove = function( e:MouseEvent ):void 
			{
				var scriptComponent:ScriptComponent = this.owner.getComponent(SCRIPT_COMPONENT);
				
				if (scriptComponent != null) 
				{
					scriptComponent.onMouseMove();
				}
			}
			
			_baseclip.onMouseWheel = function( e:MouseEvent ):void 
			{
				var scriptComponent:ScriptComponent = this.owner.getComponent(SCRIPT_COMPONENT);
				
				if (scriptComponent != null) 
				{
					scriptComponent.onMouseWheel();
				}
			}
			
			_baseclip.onRollOver = function( e:MouseEvent ):void 
			{
				var scriptComponent:ScriptComponent = this.owner.getComponent(SCRIPT_COMPONENT);
				
				if (scriptComponent != null) 
				{
					scriptComponent.onRollOver();
				}
			}
			
			_baseclip.onRollOut = function( e:MouseEvent ):void 
			{
				var scriptComponent:ScriptComponent = this.owner.getComponent(SCRIPT_COMPONENT);
				
				if (scriptComponent != null) 
				{
					scriptComponent.onRollOut();
				}
			}
			
			_baseclip.onKeyDown = function( e:MouseEvent ):void 
			{
				var scriptComponent:ScriptComponent = this.owner.getComponent(SCRIPT_COMPONENT);
				
				if (scriptComponent != null) 
				{
					scriptComponent.onKeyDown();
				}
			}
			
			_baseclip.onKeyUp = function( e:MouseEvent ):void 
			{
				var scriptComponent:ScriptComponent = this.owner.getComponent(SCRIPT_COMPONENT);
				
				if (scriptComponent != null) 
				{
					scriptComponent.onKeyUp();
				}
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
		
		public override function destroy():void
		{
			removeEventListener( MouseEvent.CLICK, onClick );
			removeEventListener( MouseEvent.DOUBLE_CLICK, onDoubleClick );
			removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			removeEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
			removeEventListener( MouseEvent.ROLL_OUT, onRollOut );
			removeEventListener( MouseEvent.ROLL_OVER, onRollOver );
			removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			
			super.destroy();
		}
	}
}