package core.loaders 
{
	import core.objects.BaseObject;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import core.loaders.TextureManager;
	import XML;
	import XMLList;
	
	/**
	 */
	[Singleton]
	public class XMLLoader extends BaseObject
	{
		private var _queue:Array = new Array();
		private var _xmlList:Dictionary = new Dictionary(true);
		
		/**
		 * Load the sprite from the xml file
		 * @param	sheetName
		 * @param	spriteName
		 * @return
		 */
		public function loadDefinition( fileName:String ):XML
		{
			if ( _xmlList[fileName] != null )
			{
				return _xmlList[fileName];
			}

			// Create a details object
			_xmlList[fileName] = new SpriteDetails();
			
			// Add it to the file to the queue
			_queue.push( fileName );
			
			// Check to see if this is the only file in the queue
			if ( _queue.length == 1 ) {
				loadFile( _queue[0] );
			}
			
			// Return the pointer
			return _xmlList[fileName];
		}
	
		/**
		 * Parse the xml tree
		 * @param	doc
		 */
		private function loadedCompleteHandler(e:Event):void
		{
			e.target.removeEventListener(Event.COMPLETE, loadedCompleteHandler);
			var xml:XML = XML(e.target.data);		
			var fileName:String = _queue.shift();

			_xmlList[fileName].parseXML( xml );
			
			if ( _queue.length > 0 ) 
			{
				loadFile( _queue[0] );
			}			
		}
		
		private function loadFile( fileName:String ):void
		{
			// Load the xml file
			var loader:URLLoader = new URLLoader( new URLRequest("xml/" + fileName ) );
			loader.addEventListener(Event.COMPLETE, loadedCompleteHandler);	
		}
	}
}
