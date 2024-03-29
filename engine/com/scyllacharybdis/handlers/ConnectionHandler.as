package com.scyllacharybdis.handlers 
{
	import com.scyllacharybdis.core.events.NetworkEventHandler;
	import com.scyllacharybdis.core.events.NetworkEvents;
	import com.scyllacharybdis.core.objects.BaseObject;
	import com.smartfoxserver.v2.core.SFSEvent;
	import flash.utils.Dictionary;
	
	/**
	 */
	[Singleton]
	[Requires ("com.scyllacharybdis.core.events.NetworkEventHandler")]
	public class ConnectionHandler extends BaseObject
	{
		private var _networkEventHandler:NetworkEventHandler;
		protected var _connected:Boolean = false;
		protected var _isConnecting:Boolean = false;
		protected var _configFile:String = "config.xml";		

		/**
		 * Register all the listeners
		 * Awake is called at the construction of the object
		 * @private
		 */
		public final override function engine_awake():void
		{
			// Get the event manager
			_networkEventHandler = getDependency(NetworkEventHandler);
			
			_networkEventHandler.addEventListener(SFSEvent.CONNECTION, this, onConnection);
			_networkEventHandler.addEventListener(SFSEvent.CONNECTION_LOST, this, onConnectionLost);
			_networkEventHandler.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, this, onConfigLoadSuccess);
			_networkEventHandler.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, this, onConfigLoadFailure);
			
			super.engine_awake();

			_networkEventHandler.addEventListener(NetworkEvents.CONNECT_REQUEST, this, requestConnection );
			_networkEventHandler.addEventListener(NetworkEvents.DISCONNECT_REQUEST, this, requestDisconnection );
			
		}
		
		/**
		 * Engine start should handle engine related start. 
		 * @private
		 */
		public final override function engine_start():void 
		{
			super.engine_start();
		}
		
		/**
		 * Engine stop should handle engine related stop. 
		 * @private
		 */
		public final override function engine_stop():void 
		{
			super.engine_stop();
		}
		
		/**
		 * Destroy is called at the removal of the object
 		 * Unregister listeners
		 * @private
		 */
		public final override function engine_destroy():void
		{
			_networkEventHandler.removeEventListener(NetworkEvents.CONNECT_REQUEST, this, requestConnection );
			_networkEventHandler.removeEventListener(NetworkEvents.DISCONNECT_REQUEST, this, requestDisconnection );

			super.engine_destroy();
			
			_networkEventHandler.removeEventListener(SFSEvent.CONNECTION, this, onConnection);
			_networkEventHandler.removeEventListener(SFSEvent.CONNECTION_LOST, this, onConnectionLost);
			_networkEventHandler.removeEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, this, onConfigLoadSuccess);
			_networkEventHandler.removeEventListener(SFSEvent.CONFIG_LOAD_FAILURE, this, onConfigLoadFailure);
		}
		
		/**
		 * The users constructor. 
		 * Override awake and create any variables and listeners.
		 */
		public override function awake():void
		{
		}
		
		/**
		 * The users start method. 
		 * Start runs when the game object is added to the scene.
		 */
		public override function start():void
		{
		}

		/**
		 * The users stop method.
		 * Stop runs when the game object is added to the scene.
		 */
		public override function stop():void
		{
		}

		/**
		 * The users destructor. 
		 * Override destroy to clean up any variables or listeners.
		 */
		public override function destroy():void
		{
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
			if ( ! _networkEventHandler.isConnected )
			{
				if (_networkEventHandler.config == null) 
				{
					_networkEventHandler.loadConfig(_configFile, true);
				} 
				else 
				{
					_networkEventHandler.connect();
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
			_networkEventHandler.connect();
			_networkEventHandler.disconnect();
		}				
		

		/**
		 * Connection Success callback
		 */
		private function connectionSuccess():void
		{
			trace( "connectionSuccess" );
			_connected = true;
			_networkEventHandler.fireEvent(NetworkEvents.CONNECTION_REQUEST_SUCCESS);
		}
		
		/**
		 * Connection failed callback
		 * @param	message
		 */
		private function connectionFailed(message:String):void
		{
			trace( "connectionFailed" );
			_connected = false;
			_networkEventHandler.fireEvent(NetworkEvents.CONNECTION_REQUEST_FAILED, message);
		}
		
		/**
		 * onConntection event handler
		 * @param	evt (NetworkEvents)
		 */
		private function onConnection(evt:SFSEvent):void
		{
			trace("onConnection: " + evt.params.success);
			if (evt.params.success)
			{
				connectionSuccess();
			}
			else
			{
				connectionFailed(evt.params.errorMessage);
			}
		}
		
		/**
		 * onConnectionLost event handler
		 * @param	evt (NetworkEvents)
		 */
		private function onConnectionLost(evt:SFSEvent):void
		{
			trace("Connection was lost. Reason: " + evt.params.reason)
		}
		
		/**
		 * onConfigLoadSuccess event handler
		 * @param	evt (NetworkEvents)
		 */
		private function onConfigLoadSuccess(evt:SFSEvent):void
		{
			trace("Server settings: "  + _networkEventHandler.config.host + ":" + _networkEventHandler.config.port)
		}
		
		/**
		 * onConfigLoadFailure event handler
		 * @param	evt (NetworkEvents)
		 */
		private function onConfigLoadFailure(evt:SFSEvent):void
		{
			trace("Config load failure!!!")
		}
	}
}