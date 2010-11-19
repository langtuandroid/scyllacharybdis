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
		
		public override function engine_awake():void 
		{
			_eventManager = owner.getComponent(EventManager);
			owner.sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);
			
			super.engine_awake();
		}
		
		public override function engine_destroy():void 
		{
			super.engine_destroy();
			
			owner.sfs.removeEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);
			_eventManager = null;
		}
		
		
		/****************************************/
		// Event Handlers
		/****************************************/
		
		public function onExtensionResponse(evt:SFSEvent):void
		{
			var params:ISFSObject = evt.params.params;
			var cmd:String = evt.params.cmd;
			trace(cmd);
			
			_eventManager.fireEvent(cmd, evt);
		}
	}
}