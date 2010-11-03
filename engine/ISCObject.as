package {

	/**
	 * ISCObject is a base object for all game elements
	 */
	interface ISCObject 
	{
		public awake():void;
		public start():void;
		public stop():void;
		public destroy():void;
	}
}