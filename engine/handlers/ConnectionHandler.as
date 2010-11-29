package handlers 
{
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import core.NetworkObject;
	import core.BaseObject;	
	import core.EventManager;
	
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
		// Class Details
		/****************************************/
		
		private var _eventManager:EventManager;
		protected var _connected:Boolean = false;
		protected var _isConnecting:Boolean = false;
		protected var _configFile:String = "config.xml";		

		/**
		* Register all the listeners
		* Awake is called at the construction of the object
		*/
		public final override function engine_awake():void
		{
			// Get the event manager
			_eventManager = getDependency(EventManager);
			
			owner.sfs.addEventListener(SFSEvent.CONNECTION, onConnection);
			owner.sfs.addEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost);
			owner.sfs.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess);
			owner.sfs.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure);
			
			super.engine_awake();

			_eventManager.registerListener("NETWORK_CONNECT", this, requestConnection );
			_eventManager.registerListener("NETWORK_DISCONNECT", this, requestDisconnection );
		}
		
		/**
		 * Engine start should handle engine related start. 
		 */
		public final override function engine_start():void 
		{
			super.engine_start();
		}
		
		/**
		 * Engine stop should handle engine related stop. 
		 */
		public final override function engine_stop():void 
		{
			super.engine_stop();
		}
		
		/**
		* Destroy is called at the removal of the object
		* Unregister listeners
		*/
		public final override function engine_destroy():void
		{
			_eventManager.unregisterListener("NETWORK_CONNECT", this, requestConnection );
			_eventManager.unregisterListener("NETWORK_DISCONNECT", this, requestDisconnection );

			super.engine_destroy();
			
			owner.sfs.removeEventListener(SFSEvent.CONNECTION, onConnection);
			owner.sfs.removeEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost);
			owner.sfs.removeEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess);
			owner.sfs.removeEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure);
		}
		
		
		/**
		 * Request connection event handler
		 * @param	data
		 */
		public function requestConnection( data:* ):void
		{
			if ( _connected == true ) 
			{
				// Already connected so just call the success callback
				connectionSuccess();
				return;
			}
			
			// Connect to the server
			connect();
		}

		/**
		 * Request disconnect handler
		 * @param	data
		 */
		public function requestDisconnection( data:* ):void
		{
			// Disconnect from the server
			disconnect();
		}
		
		/** 
		 * Connect to the server
		 */
		private function connect():void
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
				_connected = true;
			}
		}
		
		/**
		 * Diconnect from the server
		 */
		private function disconnect():void
		{
			owner.sfs.connect(false);
			owner.sfs.disconnect();
		}				
		

		/**
		 * Connection Success callback
		 */
		private function connectionSuccess():void
		{
			_connected = true;
			_eventManager.fireEvent("CONNECTION_SUCCESS");
		}
		
		/**
		 * Connection failed callback
		 * @param	message
		 */
		private function connectionFailed(message:String):void
		{
			_connected = false;
			trace("Connection Failure: " + message)
			_eventManager.fireEvent("CONNECTION_FAILED", message);
		}
		
		/**
		 * onConntection event handler
		 * @param	evt (SFSEvent)
		 */
		private function onConnection(evt:SFSEvent):void
		{
			if (evt.params.success)
			{
				connectionSuccess();
				trace("Connection Success!")
			}
			else
			{
				connectionFailed(evt.params.errorMessage);
			}
		}
		
		/**
		 * onConnectionLost event handler
		 * @param	evt (SFSEvent)
		 */
		private function onConnectionLost(evt:SFSEvent):void
		{
			trace("Connection was lost. Reason: " + evt.params.reason)
		}
		
		/**
		 * onConfigLoadSuccess event handler
		 * @param	evt (SFSEvent)
		 */
		private function onConfigLoadSuccess(evt:SFSEvent):void
		{
			trace("Config load success!")
			trace("Server settings: "  + owner.sfs.config.host + ":" + owner.sfs.config.port)
		}
		
		/**
		 * onConfigLoadFailure event handler
		 * @param	evt (SFSEvent)
		 */
		private function onConfigLoadFailure(evt:SFSEvent):void
		{
			trace("Config load failure!!!")
		}
	}
}