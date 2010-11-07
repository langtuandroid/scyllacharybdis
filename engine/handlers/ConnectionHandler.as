package engine.handlers 
{
	/**
	 */
	public class ConnectionHandler
	{
		protected var _connected:Boolean = false;
		protected var _isConnecting:Boolean = false;
		protected var configFile:String = "config.xml";

		protected function get connected():Boolean { return _connected; }
		protected function set connected( value:Boolean ) 
		{
			_connected = value;
		}
		
		public override function awake():void
		{
			NetworkManager.sfs.addEventListener(SFSEvent.CONNECTION, onConnection)
			NetworkManager.sfs.addEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost)
			NetworkManager.sfs.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess)
			NetworkManager.sfs.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure)
		}
		
		public override function destroy():void
		{
			NetworkManager.sfs.removeEventListener(SFSEvent.CONNECTION, onConnection)
			NetworkManager.sfs.removeEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost)
			NetworkManager.sfs.removeEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess)
			NetworkManager.sfs.removeEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure)
		}

		/** 
		 * Connect to the server
		 */
		public function connect():void
		{
			_isConnecting = true;

			// Check if connection is already available
			if (!sfs.isConnected)
			{
				if (NetworkManager.sfs.config == null) 
				{
					NetworkManager.sfs.loadConfig(_configFile, true);
				} 
				else 
				{
					NetworkManager.sfs.connect();
				}
			}
			else 
			{
				connected(true);
			}
		}
		
		/**
		 * onConntection event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onConnection(evt:SFSEvent):void
		{
			if (evt.params.success)
			{
				connected(true);
				dTrace("Connection Success!")
			}
			else
			{
				connected(false);
				dTrace("Connection Failure: " + evt.params.errorMessage)
			}
		}
		
		/**
		 * onConnectionLost event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onConnectionLost(evt:SFSEvent):void
		{
			dTrace("Connection was lost. Reason: " + evt.params.reason)
		}
		
		/**
		 * onConfigLoadSuccess event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onConfigLoadSuccess(evt:SFSEvent):void
		{
			dTrace("Config load success!")
			dTrace("Server settings: "  + sfs.config.host + ":" + sfs.config.port)
		}
		
		/**
		 * onConfigLoadFailure event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onConfigLoadFailure(evt:SFSEvent):void
		{
			dTrace("Config load failure!!!")
		}

		/**
		 * Helper function for displaying errors
		 * @param	msg (String) The error message
		 */
		protected function dTrace(msg:String):void
		{
			trace ( "--> " + msg + "\n" );
			//ta_debug.text += "--> " + msg + "\n";
		}
	}
}