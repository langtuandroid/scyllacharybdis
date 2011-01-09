package core.ami 
{
	/**
	 * ...
	 * @author 
	 */
	public class AMIResults extends BaseObject
	{
		private var _owner:*;

		public function AMIResults( owner:* = null )
		{
			_owner = owner;
		}
		
		public function taskCompleted( data:* )
		{
		}
	}
}