package com.scyllacharybdis.components
{
	import com.scyllacharybdis.core.composite.GameObject;
	import com.scyllacharybdis.graphics.rendering.Backbuffer;
	import com.scyllacharybdis.interfaces.IRenderComponent;
	import com.scyllacharybdis.interfaces.IScriptComponent;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import org.casalib.math.geom.Point3d;
	
	/**
	 * 
	 */
	public class RenderComponent implements IRenderComponent
	{
		private var _baseclip:MovieClip  = new MovieClip();
		private var _owner:GameObject;
		
		/** 
		 * Constructor
		 * @private
		 */
		public function awake(owner:*):void
		{
			_owner = owner;
			addListeners();
		}
		
		public function update():void
		{
		}
	
		/** 
		 * Destroy
		 * @private
		 */
		public function destroy():void
		{
			removeListeners();
		}
		
		public function get comparator():Number 
		{
			return _owner.tranform.position.z;
		}
	
		public function set baseclip( value:MovieClip ):void { _baseclip = value; }
		public function get baseclip():MovieClip { return _baseclip; }
		
		
		
		/**
		 * Add the renderable to the surface
		 * @param	surface (DisplayObjectContainer) 
		 */
		public function render( surface:Backbuffer ):void
		{
			// Create a new bitmap
			var bitmapData:BitmapData = new BitmapData(_baseclip.width, _baseclip.height, true, 0x555555FF);
			
			// Draw the baseclip to the bitmap
			bitmapData.draw(_baseclip);
			
			// Copy the pixels to the backbuffer
			surface.copyPixels(bitmapData, bitmapData.rect, new Point(_owner.tranform.position.x, _owner.tranform.position.y), null, null, true)
		}
		
		
		private final function addListeners():void
		{
			var scriptComponent:ScriptComponent = _owner.getComponent( ScriptComponent) as ScriptComponent;
			
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
			var scriptComponent:ScriptComponent = _owner.getComponent( ScriptComponent) as ScriptComponent;
			
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
					_baseclip.removeEventListener( MouseEvent.ROLL_OUT, scriptComponent.onRollOut );
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