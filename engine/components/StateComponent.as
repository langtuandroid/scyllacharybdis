package engine.components
{
	import Engine.GameObject;
	/**
	 * ...
	 * @author ...
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
		
		public static const BLANK_STATE:String = "blank_state";

		
		public function enter( owner:GameObject ):void
		{
			
		}
		
		public function update( owner:GameObject ):void
		{
			
		}
		
		public function exit( owner:GameObject ):void
		{
			
		}
	}

}