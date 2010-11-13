package components
{
	import flash.utils.Dictionary;

	import components.Component;	

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