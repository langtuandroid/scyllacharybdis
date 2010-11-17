package  
{
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import components.NetworkComponent;
	import com.smartfoxserver.v2.core.SFSEvent;
	/**
	 */
	public class BoardNetworkComponent  extends NetworkComponent 
	{
		
		public override function awake():void
		{
			trace ( "BoardNetworkComponent is starting!");
			//sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse)
		}
		
		public override function destroy():void
		{
			//sfs.removeEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse)
		}
		
		public override function onExtensionResponse(evt:SFSEvent):void
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