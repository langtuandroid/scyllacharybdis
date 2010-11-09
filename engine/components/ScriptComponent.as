package engine.components 
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	/**
	 */
	public class ScriptComponent extends Component
	{
		/****************************************/
		// Type definition
		/****************************************/
		public override function get type():String 
		{
			return SCRIPT_COMPONENT; 
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
		public function set dependencies( dep:Dictionary ):void 
		{ 
		}
		
		/****************************************/
		// Overide function
		/****************************************/
		
		
		/****************************************/
		// Class specific
		/****************************************/
		
		public override function get type():String { return SCRIPT_COMPONENT; }

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