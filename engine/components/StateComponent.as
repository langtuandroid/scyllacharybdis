package engine.components
{
	import Engine.GameObject;
	/**
	 * ...
	 * @author ...
	 */
	public class StateComponent extends Component
	{
		public static const BLANK_STATE:String = "blank_state";
		
		public function get type():String { return BLANK_STATE; }
		
		public function State() 
		{
			
		}
		
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