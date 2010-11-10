package components 
{
	import flash.utils.Dictionary;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import di.Dependencies;
	import di.Description;
	
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
			return new Description( ScriptComponent, Description.NEW_OBJECT );
		}

		/**
		 * Return the class dependencies
		 */
		public static function get dependencies():Dependencies  
		{
			return null;
		}

		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 */
		public override function set dependencies( dep:Dictionary ):void 
		{ 
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