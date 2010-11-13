package handlers 
{
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import core.NetworkManager;
	import core.BaseObject;	
	
	[Component (TransformComponent)]
	public class ConnectionHandler extends BaseObject
	{
		/****************************************/
		// Overide function
		/****************************************/

		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public override function awake():void
		{
			owner.sfs.addEventListener(SFSEvent.CONNECTION, onConnection);
			owner.sfs.addEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost);
			owner.sfs.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess);
			owner.sfs.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure);
		}
		
		/**
		* Destroy is called at the removal of the object
		* Unregister listeners
		*/
		public override function destroy():void
		{
			owner.sfs.removeEventListener(SFSEvent.CONNECTION, onConnection);
			owner.sfs.removeEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost);
			owner.sfs.removeEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess);
			owner.sfs.removeEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure);
		}

		/****************************************/
		// Class specific
		/****************************************/

		protected var _connected:Boolean = false;
		protected var _isConnecting:Boolean = false;
		protected var configFile:String = "config.xml";

		protected function get connected():Boolean { return _connected; }
		protected function set connected( value:Boolean ) 
		{
			_connected = value;
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
				if (owner.sfs.config == null) 
				{
					owner.sfs.loadConfig(_configFile, true);
				} 
				else 
				{
					owner.sfs.connect();
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

		/****************************************/
		// Event Handlers
		/****************************************/
		
		/**
		 * onConntection event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onConnection(evt:SFSEvent):void
		{
			if (evt.params.success)
			{
				connected(true);
				owner.sfs.dTrace("Connection Success!")
			}
			else
			{
				connected(false);
				owner.sfs.dTrace("Connection Failure: " + evt.params.errorMessage)
			}
		}
		
		/**
		 * onConnectionLost event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onConnectionLost(evt:SFSEvent):void
		{
			owner.sfs.dTrace("Connection was lost. Reason: " + evt.params.reason)
		}
		
		/**
		 * onConfigLoadSuccess event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onConfigLoadSuccess(evt:SFSEvent):void
		{
			owner.sfs.dTrace("Config load success!")
			owner.sfs.dTrace("Server settings: "  + sfs.config.host + ":" + sfs.config.port)
		}
		
		/**
		 * onConfigLoadFailure event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onConfigLoadFailure(evt:SFSEvent):void
		{
			owner.sfs.dTrace("Config load failure!!!")
		}
	}
}