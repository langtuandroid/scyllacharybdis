package components 
{
	import adobe.utils.CustomActions;
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
		// Class Details
		/****************************************/
		
		private var _updateTimer:Timer = new Timer(1/30, 0); 

		public final override function engine_awake():void
		{
			super.engine_awake();
		}

		public function update(event:TimerEvent):void
		{
		}
		
		public final override function engine_start():void
		{
			super.engine_start();

			// setup the timer
			_updateTimer.addEventListener(TimerEvent.TIMER, update);
			_updateTimer.start();
		}

		public final override function engine_stop():void
		{
			super.engine_stop();
		}

		public final override function engine_destroy():void
		{

			super.engine_destroy();

			// Stop the timer
			_updateTimer.stop();
			_updateTimer = null;

		}

		/*
		 * Handler mouse down 
		 */
		public function onMouseDown( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler mouse up
		 */
		public function onMouseUp( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler click
		 */
		public function onClick( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler double click
		 */
		public function onDoubleClick( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler mouse move
		 */
		public function onMouseMove( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler mouse lost focus
		 */
		public function onMouseOut( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler mouse over
		 */
		public function onMouseOver( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler wheel mouse
		 */
		public function onMouseWheel( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler roll over
		 */
		public function onRollOver( e:MouseEvent ):void
		{
			
		}

		/*
		 * Handler roll out (Whatever that is)
		 */
		public function onRollOut( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler key down
		 */
		public function onKeyDown( e:KeyboardEvent ):void
		{
			
		}
		
		/*
		 * Handler key up
		 */
		public function onKeyUp( e:KeyboardEvent ):void
		{
			
		}
	}
}