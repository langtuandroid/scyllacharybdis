package components
{
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import core.BaseObject;
	import core.NetworkManager;

	/**
	 */
	public class NetworkComponent extends BaseObject
	{
		/**
		 * Get the dependencies to instantiate the class
		 */
		public static function get dependencies():Array { return []; }
		
		/****************************************/
		// Type definition
		/****************************************/
		public override function getType():String 
		{
			return NETWORK_COMPONENT;
		}

		/****************************************/
		// Overide function
		/****************************************/

		public override function engine_awake():void 
		{
			owner.sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);
			
			super.engine_awake();
		}
		
		public override function engine_destroy():void 
		{
			super.engine_destroy();
			
			owner.sfs.removeEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);
		}
		
		/****************************************/
		// Class specific
		/****************************************/
		
		
		/****************************************/
		// Event Handlers
		/****************************************/
		
		public function onExtensionResponse(evt:SFSEvent):void
		{
			// This should be moved to a handler that generates custom events
			var params:ISFSObject = evt.params.params
			var cmd:String = evt.params.cmd
			
			switch(cmd)
			{
				case "start":
//					startGame(params)
					break
				
				case "stop":
//					userLeft()
					break
				
				case "move":
//					moveReceived(params)
					break
				
				case "specStatus":
//					setSpectatorBoard(params)
					break
				
				case "win":
				case "tie":
//					showWinner(cmd, params)
					break
			}
		}
	}
}