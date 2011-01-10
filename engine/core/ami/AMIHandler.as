package core.ami 
{
	import core.events.EventHandler;
	import core.objects.BaseObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	[Singleton]
	[Requires ("core.events.EventHandler")]
	public final class AMIHandler extends BaseObject
	{
		private var _eventHander:EventHandler;
		
		public override function engine_awake():void
		{
			_eventHander = getDependency(EventHandler);
			_eventHander.addEventListener("AMI_SUCCESS", this, success );
			_eventHander.addEventListener("AMI_FAILED", this, failed );

			super.engine_awake();
		}
		
		public override function engine_destroy():void 
		{
			super.engine_destroy();

			_eventHander.removeEventListener("AMI_SUCCESS", this, success );
			_eventHander.removeEventListener("AMI_FAILED", this, failed );
		}
		
		/**
		 * Dispatch a task
		 * @param	task
		 */
		public function dispatchTask( task:AMITask )
		{
			task.execute();
		}

		/**
		 * Handle task success event
		 * @param	message
		 */
		private function success(message:Dictionary):void 
		{
			var task:AMITask = message["task"];
			task.success( message["data"] );
		}

		/**
		 * Handle task failed event
		 * @param	message
		 */
		private function failed(message:Dictionary):void 
		{
			var task:AMITask = message["task"];
			task.failed( message["data"] );
		}
	}
}