package com.scyllacharybdis.core.loaders 
{
	import com.scyllacharybdis.core.ami.AMIUniqueAction;
	import com.scyllacharybdis.core.cache.TextureCache;
	import com.scyllacharybdis.core.objects.TextureObject;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	/**
	 */
	public class TextureLoaderAction extends AMIUniqueAction
	{
		private var _fileName:String;
		private var _loader:URLLoader;
		private static var _cache:TextureCache = new TextureCache();
		
		public function TextureLoaderAction(fileName:String) 
		{
			super(fileName);
			_fileName = fileName;
		}
		
		/**
		 * Execute the loading of the file
		 */
		public override function execute():void
		{
			
			// Check to see if we have already loaded it
			if ( _cache.getCache( _fileName ) ) 
			{
				// Call the success handler
				task.results.success( _cache.getCache( _fileName ) );
				return;
			}
			
			// Load the textire file
			_loader = new URLLoader( new URLRequest("textures/" + _fileName ) );
			_loader.addEventListener(Event.COMPLETE, loadedCompleteHandler);	
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
			var texture:TextureObject = new TextureObject( Bitmap(_loader.data) );
			
			// Store it in the cache
			_cache.setCache( _fileName, texture );
			
			// Call the success handler
			success( texture );
		}			
	}
}