package engine.components 
{
	/**
	 */
	public class ConnectionComponent extends NetworkComponent
	{
		private var _isConnecting:Boolean = false;
		
		public override function get type():String { return CONNECTION_COMPONENT; }
	
		public override function awake():void
		{
			sfs().addEventListener(SFSEvent.CONNECTION, onConnection)
			sfs().addEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost)
			sfs().addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess)
			sfs().addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure)
		}
		
		public override function destroy():void
		{
			sfs().removeEventListener(SFSEvent.CONNECTION, onConnection)
			sfs().removeEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost)
			sfs().removeEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess)
			sfs().removeEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure)
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
				if (sfs.config == null) 
				{
					sfs.loadConfig("config.xml", true);
				} 
				else 
				{
					sfs.connect();
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
			ta_debug.text += "--> " + msg + "\n";
		}
	}
}