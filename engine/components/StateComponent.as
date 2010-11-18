package components
{
	import flash.utils.Dictionary;

	import core.BaseObject;	

	/**
	 */
	public class StateComponent extends BaseObject
	{
		/**
		 * Get the dependencies to instantiate the class
		 */
		public static function get dependencies():Array { return []; }
		
		/****************************************/
		// Type definition
		/****************************************/
		public override function get type():String 
		{
			return STATE_COMPONENT; 
		}		

		/****************************************/
		// Overide function
		/****************************************/
		
		
		/****************************************/
		// Class specific
		/****************************************/
		
		public static const BLANK_STATE:String = "blank_state";

		//private var _currentState:State
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