package core.loaders 
{
	import core.ami.AMIFileLoadAction;

	/**
	 */
	public class XMLLoaderAction extends AMIFileLoadAction
	{
		private var _fileName:String;
		private static var _cache = new XMLCache();
		
		public function XMLLoaderTask(fileName:String) 
		{
			_fileName = fileName;
		}
		
		/**
		 * Execute the loading of the file
		 */
		public override function execute()
		{
			// Check to see if we have already loaded it
			if ( _cache.getCache( _fileName ) ) 
			{
				// Call the success handler
				_results.success( _cache.getCache( _fileName ) );
				return;
			}
			
			// Load the xml file
			var loader:URLLoader = new URLLoader( new URLRequest("xml/" + fileName ) );
			loader.addEventListener(Event.COMPLETE, loadedCompleteHandler);	
		}
		
		/**
		 * Load completed handler
		 * @param	e
		 */
		private function loadedCompleteHandler(e:Event):void
		{
			// Remove the listeners
			e.target.removeEventListener(Event.COMPLETE, loadedCompleteHandler);
			
			// Get the data
			var xml:XML = XML(e.target.data);
			
			// Store it in the cache
			_cache.setCache( _fileName, xml );
			
			// Call the success handler
			success( xml );
		}		
	}
}