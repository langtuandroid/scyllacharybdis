package com.scyllacharybdis.components
{
	import com.scyllacharybdis.core.objects.BaseObject;
	import com.scyllacharybdis.core.rendering.Backbuffer;
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
	[Component (type="RenderComponent")]
	public class MovieClipComponent extends RenderComponent
	{
		private var _baseclip:MovieClip  = new MovieClip();
		
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
		
		/**
		 * Get the movie clip
		 */
		public final function get baseclip():MovieClip { return _baseclip; }

		/**
		 * Set the movie clip
		 */
		public final function set baseclip( value:MovieClip ):void { _baseclip = value; }
		
		/**
		 * Add the renderable to the surface
		 * @param	surface (DisplayObjectContainer) 
		 */
		public final override function render( surface:Backbuffer ):void
		{
			// Create a new bitmap
			var bitmapData:BitmapData = new BitmapData(_baseclip.width, _baseclip.height, true, 0x000000FF);
			
			// Draw the baseclip to the bitmap
			bitmapData.draw(_baseclip);
			
			// Copy the pixels to the backbuffer
			surface.copyPixels(bitmapData, bitmapData.rect, new Point(owner.position.x, owner.position.y), null, null, true);
		}
		
		/**
		 * Add all the listeners to this object
		 */
		private final function addListeners():void
		{
			{
				_baseclip.addEventListener( MouseEvent.CLICK, onClick, false, 0, true);
				_baseclip.addEventListener( MouseEvent.DOUBLE_CLICK, onDoubleClick, false, 0, true );
				_baseclip.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true );
				_baseclip.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true );
				_baseclip.addEventListener( MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true );
				_baseclip.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true );
				_baseclip.addEventListener( MouseEvent.MOUSE_UP, onMouseUp, false, 0, true );
				_baseclip.addEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel, false, 0, true );
				_baseclip.addEventListener( MouseEvent.ROLL_OUT, onRollOut, false, 0, true );
				_baseclip.addEventListener( MouseEvent.ROLL_OVER, onRollOver, false, 0, true );
				_baseclip.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true );
				_baseclip.addEventListener( KeyboardEvent.KEY_UP, onKeyUp, false, 0, true );
			}			
		}

		/**
		 * Remove all the listeners from the movie clip
		 */
		private final function removeListeners():void
		{
			_baseclip.removeEventListener( MouseEvent.CLICK, onClick );
			_baseclip.removeEventListener( MouseEvent.DOUBLE_CLICK, onDoubleClick );
			_baseclip.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			_baseclip.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			_baseclip.removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			_baseclip.removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			_baseclip.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			_baseclip.removeEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
			_baseclip.removeEventListener( MouseEvent.ROLL_OUT, onRollOut );
			_baseclip.removeEventListener( MouseEvent.ROLL_OVER, onRollOver );
			_baseclip.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			_baseclip.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onClick(e:MouseEvent):void 
		{
			var scriptComponent:ScriptComponent = owner.getComponent(ScriptComponent);
			if ( scriptComponent != null )
			{
				scriptComponent.onClick(e);
			}
			
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onDoubleClick(e:MouseEvent):void 
		{
			var scriptComponent:ScriptComponent = owner.getComponent(ScriptComponent);
			if ( scriptComponent != null )
			{
				scriptComponent.onDoubleClick(e);
			}
			
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onMouseDown(e:MouseEvent):void 
		{
			var scriptComponent:ScriptComponent = owner.getComponent(ScriptComponent);
			if ( scriptComponent != null )
			{
				scriptComponent.onMouseDown(e);
			}
			
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onMouseMove(e:MouseEvent):void 
		{
			var scriptComponent:ScriptComponent = owner.getComponent(ScriptComponent);
			if ( scriptComponent != null )
			{
				scriptComponent.onMouseMove(e);
			}
			
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onMouseOut(e:MouseEvent):void 
		{
			var scriptComponent:ScriptComponent = owner.getComponent(ScriptComponent);
			if ( scriptComponent != null )
			{
				scriptComponent.onMouseOut(e);
			}
			
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onMouseOver(e:MouseEvent):void 
		{
			var scriptComponent:ScriptComponent = owner.getComponent(ScriptComponent);
			if ( scriptComponent != null )
			{
				scriptComponent.onMouseOver(e);
			}
			
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onMouseUp(e:MouseEvent):void 
		{
			var scriptComponent:ScriptComponent = owner.getComponent(ScriptComponent);
			if ( scriptComponent != null )
			{
				scriptComponent.onMouseUp(e);
			}
			
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onMouseWheel(e:MouseEvent):void 
		{
			var scriptComponent:ScriptComponent = owner.getComponent(ScriptComponent);
			if ( scriptComponent != null )
			{
				scriptComponent.onMouseWheel(e);
			}
			
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onKeyDown(e:KeyboardEvent):void 
		{
			var scriptComponent:ScriptComponent = owner.getComponent(ScriptComponent);
			if ( scriptComponent != null )
			{
				scriptComponent.onKeyDown(e);
			}
			
		}

		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onKeyUp(e:KeyboardEvent):void 
		{
			var scriptComponent:ScriptComponent = owner.getComponent(ScriptComponent);
			if ( scriptComponent != null )
			{
				scriptComponent.onKeyUp(e);
			}
			
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onRollOver(e:MouseEvent):void 
		{
			var scriptComponent:ScriptComponent = owner.getComponent(ScriptComponent);
			if ( scriptComponent != null )
			{
				scriptComponent.onRollOver(e);
			}
			
		}
		
		/**
		 * Helper function
		 * @private
		 * @param	e
		 */
		private final function onRollOut(e:MouseEvent):void 
		{
			var scriptComponent:ScriptComponent = owner.getComponent(ScriptComponent);
			if ( scriptComponent != null )
			{
				scriptComponent.onRollOut(e);
			}
			
		}
	}
}