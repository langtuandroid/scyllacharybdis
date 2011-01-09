package core.ami 
{
	import core.objects.BaseObject;
	/**
	 * ...
	 * @author 
	 */
	public class AMITask extends BaseObject
	{
		private var _results:AMIResults;
		private var _started:Boolean;

		public IAMITask( results:AMIResults )
		{
			_results = results;
		}
		
		public function startTask():void
		{
			if ( _started == true ) 
			{
				return;
			}
			_started = true;
		}
		
		public function taskCompleted( data:* = null ):void
		{
			_results.completed( data );
		}
	}
}