package core.loaders 
{
	import core.ami.AMIFileLoadAction;
	import core.cache.TextureCache;
	import core.objects.TextureObject;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	/**
	 */
	public class TextureLoaderAction extends AMIFileLoadAction
	{
		private var _fileName:String;
		private static var _cache = new TextureCache();
		
		public function TextureLoaderAction(fileName:String) 
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
			
			// Load the textire file
			var loader:URLLoader = new URLLoader( new URLRequest("textures/" + fileName ) );
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
			var texture:TextureObject = new TextureObject( Bitmap(loader.content) );
			
			// Store it in the cache
			_cache.setCache( _fileName, texture );
			
			// Call the success handler
			success( xml );
		}			
	}
}