package core.ami 
{
	import core.ami.AMIResults;
	/**
	 * ...
	 * @author 
	 */
	public class AMITask 
	{
		private var _invoker:Object;
		private var _action:AMIAction;
		private var _results:AMIResults;
		private var _key:String;
		
		public function AMITask( action:AMIAction, results:AMIResults, invoker:Object ) 
		{
			// Store the parameters
			_action = action;
			_results = results;
			_invoker = invoker;
			
			// Tell the dependencies about the task
			action.task = this;
			results.task = this;
		}
		
		/**
		 * Execute the action
		 */
		public function execute():void
		{
			action.start();
		}
		
		/**
		 * Action was successful
		 * @param	data
		 */
		public final function success( data:* ):void
		{
			results.success( data );
		}
		
		/**
		 * Action failed
		 * @param	data
		 */
		public final function failed( data:* ):void
		{
			results.failed( data );
		}

		/**
		 * Get the class that invoked the task
		 */
		public final function get invoker():Object 
		{ 
			return _invoker; 
		}
	}
}