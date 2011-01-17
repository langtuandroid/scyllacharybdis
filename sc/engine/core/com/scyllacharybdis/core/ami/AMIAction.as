package com.scyllacharybdis.core.ami
{
	import core.ami.AMITask;
	import core.events.EventHandler;
	import core.objects.BaseObject;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author 
	 */
	public class AMIAction 
	{
		private var _task:AMITask;
		private var _eventHandler:EventHandler;
		
		/**
		 * Override with specific details
		 */
		public function execute():void
		{
		}
		
		/**
		 * Call when the task has succeeded
		 * @param	data
		 */
		public final function success( data:* ):void
		{
			// Pack the results
			var results:Dictionary = new Dictionary(true);
			results["task"] = task;
			results["data"] = data;
			
			// Fire the success event
			_eventHandler.fireEvent("AMI_SUCCESS", results );
		}
		
		/**
		 * Call when the task has failed
		 * @param	data
		 */
		public final function failed( data:* ):void
		{
			// Pack the results
			var results:Dictionary = new Dictionary(true);
			results["task"] = task;
			results["data"] = data;
			
			// Fire the failed event
			_eventHandler.fireEvent("AMI_FAILED", results );
		}

		/**
		 * Get the parent task
		 */
		public final function get task():AMITask { return _task; }

		/**
		 * Set the parent task
		 */
		public final function set task(task:AMITask):void 
		{
			_task = task;
		}
	}
}