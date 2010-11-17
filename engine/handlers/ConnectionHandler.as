package handlers 
{
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import core.NetworkManager;
	import core.BaseObject;	
	
	/**
	 */
	public class ConnectionHandler extends BaseObject
	{
		
		/****************************************/
		// Type definition
		/****************************************/
		public override function getType():String 
		{
			return CONNECTION_HANDLER;
		}
		
		/****************************************/
		// Overide function
		/****************************************/

		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public override function engine_awake():void
		{
			
			owner.sfs.addEventListener(SFSEvent.CONNECTION, onConnection);
			owner.sfs.addEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost);
			owner.sfs.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess);
			owner.sfs.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure);
			
			super.engine_awake();
		}
		
		/**
		* Destroy is called at the removal of the object
		* Unregister listeners
		*/
		public override function engine_destroy():void
		{
			super.engine_destroy();

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
		protected var _configFile:String = "config.xml";

		protected function get connected():Boolean { return _connected; }
		protected function set connected( value:Boolean ):void
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
			if ( ! owner.sfs.isConnected )
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
				connected = true;
			}
		}
		
		public function disconnect():void
		{
			owner.sfs.connect(false);
			owner.sfs.disconnect();
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
				connected = true;
				owner.sfs.dTrace("Connection Success!")
			}
			else
			{
				connected = false;
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
			owner.sfs.dTrace("Server settings: "  + owner.sfs.config.host + ":" + owner.sfs.config.port)
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