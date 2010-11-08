package engine.components
{
	import com.smartfoxserver.v2.SmartFox;
	/**
	 */
	public class NetworkComponent extends Component 
	{
		public function Awake() 
		{
			sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse)
		}
		
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