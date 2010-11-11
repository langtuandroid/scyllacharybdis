package  
{
	/**
	 */
	public class BoardNetworkComponent  extends NetworkComponent 
	{
		
		public function Awake() 
		{
			sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse)
		}
		
		public function Destroy() 
		{
			sfs.removeEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse)
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