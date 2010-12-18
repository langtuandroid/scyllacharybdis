package handlers
{
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import core.BaseObject;
	import core.NetworkObject;
	import core.EventManager;
	import models.SendModel;
	import models.SendSFSObject;

	/**
	 */
	public class MessageHandler extends BaseObject
	{
		/**
		 * Get the dependencies to instantiate the class
		 */
		public static function get dependencies():Array { return [EventManager]; }
		
		/****************************************/
		// Type definition
		/****************************************/
		
		public override function getType():String 
		{
			return MESSAGE_HANDLER;
		}

		/****************************************/
		// Class Details
		/****************************************/

		private var _eventManager:EventManager;
		
		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		* @private
		*/		
		public final override function engine_awake():void 
		{
			// Get the event manager
			_eventManager = getDependency(EventManager);

			_eventManager.registerListener("SEND_MODEL_TO_SERVER", this, sendModelToServer);
			_eventManager.registerListener("SEND_OBJECT_TO_SERVER", this, sendObjectToServer );

			// Register event handlers
			owner.sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);
			
			// Call the super
			super.engine_awake();
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
			// Call the supper
			super.engine_destroy();
			
			// Unregister all the event handlers
			owner.sfs.removeEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);

			_eventManager.unregisterListener("SEND_MODEL_TO_SERVER", this, sendModelToServer);
			_eventManager.unregisterListener("SEND_OBJECT_TO_SERVER", this, sendObjectToServer );
			
			// Release the event manager
			_eventManager = null;
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
		 * Extension response handler
		 * @param	evt (SFSEvent) The data from the server
		 */
		public function onExtensionResponse(evt:SFSEvent):void
		{
			// Get the network message information
			var params:ISFSObject = evt.params.params;
			var cmd:String = evt.params.cmd;
			trace(cmd);
			
			// Fire the event using the event name and pass the event object
			_eventManager.fireEvent(cmd, evt);
		}
		
		/**
		 * @internal
		 * Send a model to the server
		 * @param	data (SendModel)
		 */
		public function sendModelToServer(data:SendModel):void
		{
			var sfsObject:ISFSObject = SFSObject.newInstance();
			sfsObject.putClass(data.modelName, data.model);
			var request:ExtensionRequest;
			
			if ( data.room == null ) 
			{
				request = new ExtensionRequest(data.eventName, sfsObject);
			} 
			else 
			{
				request = new ExtensionRequest(data.eventName, sfsObject, data.room);
			}
			owner.sfs.send(request);	
		}

		/**
		 * @internal
		 * Send a SFSobject to the server
		 * @param	data (SendSFSObject)
		 */
		public function sendObjectToServer(data:SendSFSObject):void
		{
			var request:ExtensionRequest;
			
			if ( data.room == null ) 
			{
				request = new ExtensionRequest(data.eventName, data.sfsObject);
			} 
			else 
			{
				request = new ExtensionRequest(data.eventName, data.sfsObject, data.room);
			}
			owner.sfs.send(request);				
		}
	}
}