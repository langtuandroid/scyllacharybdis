package core.materials 
{
	import core.objects.BaseObject;
	import core.materials.Texture;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	/**
	 */
	public class TextureManager extends BaseObject
	{
		private var _queue:Array = new Array();
		private var _textureList:Dictionary = new Dictionary();
		
		public function loadTexture( fileName:String ):Texture
		{
			if ( _textureList[fileName] != null ) 
			{
				return _textureList[fileName];
			}
			
			// Add it to the image queue
			_queue.push( fileName );
			
			// Check to see if this is the only file in the queue
			if ( _queue.length == 1 ) {
				loadFile( _queue[0] );
			}
			return _textureList[fileName] = new Texture( fileName );
		}
		
		public function loadFile( fileName:String ) void
		{
			// Is there anything in the queue
			if ( _queue.length <= 0 ) {
				return;
			}
			
			// Create a content loader
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderReady);

			// Create the url request
			var fileRequest:URLRequest = new URLRequest("textures/" + fileName);
			loader.load(fileRequest);
		}
		
		public function onLoaderComplete(event:Event) 
		{   
			var loader:Loader = Loader(event.target.loader);
			_textureList[_queue.shift].setTextureData( Bitmap(loader.content) );
			if ( _queue.length > 0 ) 
			{
				loadFile( _queue[0] );
			}
		}		
	}
}