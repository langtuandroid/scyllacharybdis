package core.loaders 
{
	import core.ami.AMIResults;
	/**
	 * ...
	 * @author 
	 */
	public class PhysicsResults extends AMIResults
	{
		
		public function PhysicsResults( owner:* ) 
		{
			super( owner );
		}
		
		public function taskCompleted( data:* )
		{
			_owner.parseXML( data );
		}		
	}
}