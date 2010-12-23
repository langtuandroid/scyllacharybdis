package core.materials 
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	/**
	 */
	public class Texture 
	{
		private var _ready:Boolean = false;
		private var _loader:Loader = new Loader();
		
		public function Texture( fileName:String ) 
		{
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderReady);

			var fileRequest:URLRequest = new URLRequest(fileName);
			_loader.load(fileRequest);
		}

		public function onLoaderReady(e:Event) 
		{     
			_ready = true;
		}
		
		public function isLoaded():Boolean
		{
			return _ready;
		}
		
		public function getTextureData():BitmapData
		{
		}
	}

}