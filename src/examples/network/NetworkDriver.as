package examples.network 
{
	import com.scyllacharybdis.core.events.NetworkEventHandler;
	import com.scyllacharybdis.core.events.NetworkEvents;
	import com.scyllacharybdis.core.objects.BaseObject;
	
	/**
	 * ...
	 * @author 
	 */
	[Requires ("com.scyllacharybdis.core.events.NetworkEventHandler")]
	public class NetworkDriver extends BaseObject
	{
		private var _networkHandler:NetworkEventHandler;
		
		public override function awake():void
		{
			_networkHandler = getDependency(NetworkEventHandler);
			_networkHandler.setDebug( true );
			
			_networkHandler.addEventListener( NetworkEvents.CONNECTION_REQUEST_SUCCESS, this, onConnectSuccess );
			_networkHandler.addEventListener( NetworkEvents.CONNECTION_REQUEST_FAILED, this, onConnectFailed );
			
			_networkHandler.fireEvent( NetworkEvents.CONNECT_REQUEST );
		}
		
		public override function destroy():void
		{
			_networkHandler.removeEventListener( NetworkEvents.CONNECTION_REQUEST_SUCCESS, this, onConnectSuccess );
			_networkHandler.removeEventListener( NetworkEvents.CONNECTION_REQUEST_FAILED, this, onConnectFailed );
		}
		
		public function onConnectSuccess(evt:NetworkEvents):void
		{
			trace("connection success");
		}
		
		public function onConnectFailed(evt:NetworkEvents):void
		{
			trace("connection failed");
		}
	}

}