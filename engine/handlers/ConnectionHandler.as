package engine.handlers 
{
	/**
	 */
	public class ConnectionHandler extends Handler
	{
		protected var _connected:Boolean = false;
		protected var _isConnecting:Boolean = false;
		protected var configFile:String = "config.xml";

		protected function get connected():Boolean { return _connected; }
		protected function set connected( value:Boolean ) 
		{
			_connected = value;
		}
		
		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public override function awake():void
		{
			NetworkManager.sfs.addEventListener(SFSEvent.CONNECTION, onConnection);
			NetworkManager.sfs.addEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost);
			NetworkManager.sfs.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess);
			NetworkManager.sfs.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure);
		}
		
		/**
		* Destroy is called at the removal of the object
		* Unregister listeners
		*/
		public override function destroy():void
		{
			NetworkManager.sfs.removeEventListener(SFSEvent.CONNECTION, onConnection);
			NetworkManager.sfs.removeEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost);
			NetworkManager.sfs.removeEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess);
			NetworkManager.sfs.removeEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure);
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
		
		private function disconnect():void
		{
			connect(false);
			sfs.disconnect();
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
				NetworkManager.sfs.dTrace("Connection Success!")
			}
			else
			{
				connected(false);
				NetworkManager.sfs.dTrace("Connection Failure: " + evt.params.errorMessage)
			}
		}
		
		/**
		 * onConnectionLost event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onConnectionLost(evt:SFSEvent):void
		{
			NetworkManager.sfs.dTrace("Connection was lost. Reason: " + evt.params.reason)
		}
		
		/**
		 * onConfigLoadSuccess event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onConfigLoadSuccess(evt:SFSEvent):void
		{
			NetworkManager.sfs.dTrace("Config load success!")
			NetworkManager.sfs.dTrace("Server settings: "  + sfs.config.host + ":" + sfs.config.port)
		}
		
		/**
		 * onConfigLoadFailure event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onConfigLoadFailure(evt:SFSEvent):void
		{
			NetworkManager.sfs.dTrace("Config load failure!!!")
		}
	}
}