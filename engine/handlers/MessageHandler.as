package handlers
{
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import core.BaseObject;
	import core.NetworkManager;
	import core.EventManager;

	/**
	 */
	public class MessageHandler extends BaseObject
	{
		/**
		 * Get the dependencies to instantiate the class
		 */
		public static function get dependencies():Array { return [EventManager]; }
		
		/****************************************/
		// Type definition
		/****************************************/
		public override function getType():String 
		{
			return MESSAGE_HANDLER;
		}

		/****************************************/
		// Overide function
		/****************************************/

		private var _eventManager:EventManager;
		
		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/		
		public override function engine_awake():void 
		{
			// Get the event manager
			_eventManager = owner.getComponent(EventManager);
			
			// Register event handlers
			owner.sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);
			
			// Call the super
			super.engine_awake();
		}
		
		/**
		* Destroy is called at the removal of the object
		* Unregister listeners
		*/		
		public override function engine_destroy():void 
		{
			// Call the supper
			super.engine_destroy();
			
			// Unregister all the event handlers
			owner.sfs.removeEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);
			
			// Release the event manager
			_eventManager = null;
		}
		
		
		/****************************************/
		// Event Handlers
		/****************************************/
		
		public function onExtensionResponse(evt:SFSEvent):void
		{
			// Get the network message information
			var params:ISFSObject = evt.params.params;
			var cmd:String = evt.params.cmd;
			trace(cmd);
			
			// Fire the event using the event name and pass the event object
			_eventManager.fireEvent(cmd, evt);
		}
	}
}