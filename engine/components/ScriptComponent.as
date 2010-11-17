package components 
{
	import flash.utils.Dictionary;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	import components.Component;	

	/**
	 */
	public class ScriptComponent extends Component
	{
		/**
		 * Get the dependencies to instantiate the class
		 */
		public static function get dependencies():Array { return []; }
		
		/****************************************/
		// Type definition
		/****************************************/
		public override final function get type():String 
		{
			return SCRIPT_COMPONENT; 
		}		
		
		
		/****************************************/
		// Overide function
		/****************************************/
		
		
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