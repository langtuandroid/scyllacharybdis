package core.sprites 
{
	import core.objects.BaseObject;
	import core.sprites.Texture;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	/**
	 */
	[Singleton]
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
			return _textureList[fileName] = new Texture();
		}
		
		
		public function onLoaderComplete(event:Event):void
		{   
			var loader:Loader = Loader(event.target.loader);
			var fileName:String = _queue.shift();
			_textureList[fileName].setTextureData( Bitmap(loader.content).bitmapData );
			if ( _queue.length > 0 ) 
			{
				loadFile( _queue[0] );
			}
		}		
		
		private function loadFile( fileName:String ):void
		{
			// Is there anything in the queue
			if ( _queue.length <= 0 ) {
				return;
			}
			
			// Create a content loader
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);

			// Create the url request
			var fileRequest:URLRequest = new URLRequest("textures/" + fileName);
			loader.load(fileRequest);
		}
		
	}
}