package core 
{
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.SmartFox;

	import core.BaseObject;
	import handlers.ConnectionHandler;
	import handlers.LoginHandler;
	import handlers.RoomHandler;

	public class NetworkObject extends ContainerObject
	{
		/****************************************/
		// Dependency Information
		/****************************************/

		/**
		 * Return the class scope
		 */
		public static function get scope():int { return SINGLETON_OBJECT };
		
		
		/****************************************/
		// Overide function
		/****************************************/
		
		private var _sfs:SmartFox = new SmartFox(true);
		
		/**
		* Awake is called at the construction of the object
		*/
		public override function engine_awake():void
		{
			super.engine_awake();
		}
		
		/**
		* Destroy is called at the removal of the object
		*/	
		public override function engine_destroy():void
		{
			super.engine_destroy();
		}
		
		/**
		 * Get the smartfox server
		 */
		public function get sfs():SmartFox { return _sfs; }
	}
}

