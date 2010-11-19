package components 
{
	import flash.utils.Dictionary;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	import core.BaseObject;
	import core.EventManager;

	/**
	 */
	public class ScriptComponent extends BaseObject
	{
		/****************************************/
		// Type definition
		/****************************************/
		public override final function getType():String 
		{
			return SCRIPT_COMPONENT; 
		}		
		
		
		/****************************************/
		// Overide function
		/****************************************/
		private var _updateTimer:Timer = new Timer(1/16, 0); 

		public override function engine_awake():void
		{
			// setup the timer
			_updateTimer.addEventListener(TimerEvent.TIMER, update);
			_updateTimer.start();

			super.engine_awake();
		}

		public function update(event:TimerEvent):void
		{
		}

		public override function engine_destroy():void
		{

			super.engine_destroy();

			// Stop the timer
			_updateTimer.stop();
			_updateTimer = null;

		}
		
		
		/****************************************/
		// Class specific
		/****************************************/

		/****************************************/
		// Event Handlers
		/****************************************/
		/*
		 * Handler functions for the keyboard and mouse events
		 */
		public function onMouseDown( e:MouseEvent ):void
		{
			
		}
		
		public function onMouseUp( e:MouseEvent ):void
		{
			
		}
		
		public function onClick( e:MouseEvent ):void
		{
			
		}
		
		public function onDoubleClick( e:MouseEvent ):void
		{
			
		}
		
		public function onMouseMove( e:MouseEvent ):void
		{
			
		}
		
		public function onMouseOut( e:MouseEvent ):void
		{
			
		}
		
		public function onMouseOver( e:MouseEvent ):void
		{
			
		}
		
		public function onMouseWheel( e:MouseEvent ):void
		{
			
		}
		
		public function onRollOver( e:MouseEvent ):void
		{
			
		}
		
		public function onRollOut( e:MouseEvent ):void
		{
			
		}
		
		public function onKeyDown( e:KeyboardEvent ):void
		{
			
		}
		
		public function onKeyUp( e:KeyboardEvent ):void
		{
			
		}
	}
}