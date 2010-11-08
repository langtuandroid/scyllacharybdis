package engine.components
{
	import com.smartfoxserver.v2.SmartFox;
	/**
	 */
	public class NetworkComponent extends Component 
	{
		public override function get type():String { return NETWORK_COMPONENT; }
		
		protected var _sfs:SmartFox = new SmartFox(true);
		public function get sfs():SmartFox { return _sfs; }
		
		protected var _connected:Boolean = false;
		protected function get connected():Boolean { return _connected; }
		protected function set connected( value:Boolean ) 
		{
			_connected = value;
		}
	}
}