package core 
{
	import Engine.GameObject;
	/**
	 * ...
	 * @author ...
	 */
	public class State 
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