package components
{
	import flash.utils.Dictionary;
	
	import core.GameObject;
	import di.Dependencies;
	import di.Description;

	/**
	 */
	public class StateComponent extends Component
	{
		/****************************************/
		// Type definition
		/****************************************/
		public override function get type():String 
		{
			return STATE_COMPONENT; 
		}		
		
		/****************************************/
		// Dependency Injection calls
		/****************************************/
		
		/**
		 * Return the class description
		 */
		public static function get description():Description  
		{ 
			return new Description( StateComponent, Description.NEW_OBJECT );
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
		
		public static const BLANK_STATE:String = "blank_state";

		
		public function enter( owner:GameObject ):void
		{
		}
		
		public function exit( owner:GameObject ):void
		{
		}

		public function stateUpdate( owner:GameObject ):void
		{
			
		}
		
	}

}