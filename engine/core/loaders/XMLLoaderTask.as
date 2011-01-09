package core.loaders 
{
	import core.ami.AMIResults;
	import core.ami.AMITask;
	/**
	 * ...
	 * @author 
	 */
	public class XMLLoaderTask extends AMITask
	{
		private var _fileName:String;
		private static var _cache = new XMLCache();
		
		public function XMLLoaderTask(results:AMIResults, fileName:String) 
		{
			super(results);
			_fileName = fileName;
		}
		
		public function execute()
		{
			// Check to see if we have already loaded it
			if ( _cache.getCache( _fileName ) ) 
			{
				_results.taskCompleted( _cache.getCache( _fileName ) );
				return;
			}
			// Load the xml file
			var loader:URLLoader = new URLLoader( new URLRequest("xml/" + fileName ) );
			loader.addEventListener(Event.COMPLETE, loadedCompleteHandler);	
		}
		
		private function loadedCompleteHandler(e:Event):void
		{
			e.target.removeEventListener(Event.COMPLETE, loadedCompleteHandler);
			var xml:XML = XML(e.target.data);
			
			_cache.setCache( _fileName, xml );
			_results.taskCompleted( xml );
		}		
	}
}