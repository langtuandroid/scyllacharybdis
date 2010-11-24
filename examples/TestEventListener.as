package  
{
	import core.BaseObject;
	import core.EventManager

	/**
	 * A Test event
	 */
	public class TestEventListener extends BaseObject
	{
		// The event manager
		private var _eventHandler:EventManager;

		/**
		 * The construtor
		 */
		public override function awake():void
		{
			_eventHandler = getDependency(EventManager);
			
			if ( _eventHandler == null ) {
				trace("Event Handler is null");
				return;
			}
			trace("RegisterListener");
			_eventHandler.registerListener("myevent", this, myEventHandler);			
		}
		
		/**
		 * The destructor
		 */
		public override function destroy():void
		{
			if ( _eventHandler == null ) {
				trace("Event Handler is null");
				return;
			}
			trace("UnregisterListener");
			_eventHandler.unregisterListener("myevent", this, myEventHandler);
		}

		/**
		 * The test handler method
		 * @param	theData
		 */
		public function myEventHandler(theData:*):void
		{
			trace("Received and event");
		}
	}
}