package com.scyllacharybdis.core.ami
{
	import com.scyllacharybdis.core.events.EventHandler;
	import com.scyllacharybdis.interfaces.IBaseObject;
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
	public final class AMIHandler extends IBaseObject
	{
		private var _taskList:Dictionary = new Dictionary( true );
		private var _eventHander:EventHandler;
		
		public function AMIHandler( eventHandler:EventHandler ):void
		{
			_eventHander = eventHandler;
		}
		
		public function awake():void
		{
			_eventHander.addEventListener("AMI_SUCCESS", this, success );
			_eventHander.addEventListener("AMI_FAILED", this, failed );

			super.engine_awake();
		}
		
		public function destroy():void 
		{
			_eventHander.removeEventListener("AMI_SUCCESS", this, success );
			_eventHander.removeEventListener("AMI_FAILED", this, failed );
		}
		
		/**
		 * Dispatch a task
		 * @param	task
		 */
		public final function dispatchTask( task:AMITask )
		{
			if ( ! (task.action is AMIUniqueAction) ) 
			{
					// Execute the action
					task.execute();
					
					// Early out
					return;
			}
			
			if ( _taskList[task][task.key] == null )
			{
				_taskList[task][task.key] = new Array();
			}
			
			// Add the task to the array
			_taskList[task][task.key].push( task );

			if ( _taskList[task][task.key].length == 1 )
			{
				// Execute the action
				task.execute();
			}
		}

		/**
		 * Handle task success event
		 * @param	message
		 */
		private final function success(message:Dictionary):void 
		{
			var task:AMITask = message["task"];
			if ( ! (task.action is AMIUniqueAction) ) 
			{
				// Call the success method
				task.success( message["data"] );

				// Early out
				return;
			}
			// Get the array
			var list:Array = _taskList[task][task.key];
			
			// Loop until all the messages have been returned 
			while ( list.length ) 
			{
				// Shift the task off the list
				var taskObj = list.shift();
				
				// Call the success method
				taskObj.success( message["data"] );
			}

			// Delete everything in the list
			_taskList[task][task.key] = null;
			
		}

		/**
		 * Handle task failed event
		 * @param	message
		 */
		private final function failed(message:Dictionary):void 
		{
			var task:AMITask = message["task"];
			if ( ! (task.action is AMIUniqueAction) ) 
			{
				// Call the failed method
				task.failed( message["data"] );

				// Early out
				return;
			}
			// Get the array
			var list:Array = _taskList[task][task.key];
			
			// Loop until all the messages have been returned 
			while ( list.length ) 
			{
				// Shift the task off the list
				var taskObj = list.shift();
				
				// Call the failed method
				taskObj.failed( message["data"] );
			}

			// Delete everything in the list
			_taskList[task][task.key] = null;
		}
	}
}