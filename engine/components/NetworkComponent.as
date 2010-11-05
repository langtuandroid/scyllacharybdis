package engine.components
{
	/**
	 */
	public function NetworkComponent extends Component 
	{
		public override function get type():int { return NETWORK_COMPONENT; }
		
		private var _sfs:SmartFox = = new SmartFox(true);
		public get sfs():SmartFox { return _sfs; }

		private var _connected:Boolean = false;
		protected var get connected:Boolean { return _connected; }
		protected var set connected( value:Boolean ) {
			_connected = value;
		}
	}
}