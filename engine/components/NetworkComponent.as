package components
{
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import core.NetworkManager;
	import components.Component;	

	/**
	 */
	public class NetworkComponent extends Component
	{
		/****************************************/
		// Type definition
		/****************************************/
		public override function get type():String 
		{
			return NETWORK_COMPONENT;
		}

		/****************************************/
		// Overide function
		/****************************************/

		public override function awake():void 
		{
			//sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse)
		}
		
		public override function destroy():void 
		{
			//sfs.removeEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse)
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