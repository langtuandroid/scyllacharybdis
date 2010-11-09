package engine.components
{
	import com.smartfoxserver.v2.SmartFox;

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
		// Dependency Injection calls
		/****************************************/
		
		/**
		 * Return the class description
		 */
		public static function get description():Description  
		{ 
			return new Description( getQualifiedClassName(this), NEW_OBJECT );
		}

		/**
		 * Return the class dependencies
		 */
		public static function get dependencies():Dependencies  
		{  
			return Dependencies(NetworkManager);
		}

		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 */
		public function set dependencies( dep:Dictionary ):void 
		{
 			_networkManager = dep[NetowrkManager];
		}

		
		/****************************************/
		// Overide function
		/****************************************/

		public function Awake() 
		{
			sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse)
		}
		
		public function Destroy() 
		{
			sfs.removeEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse)
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