package core.materials 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	/**
	 */
	public class Texture 
	{
		private var _loaded:Boolean = false;
		private var _bitmap:Bitmap = new Bitmap();
		
		public function isLoaded():Boolean
		{
			return _loaded;
		}
		
		public function getTextureData():BitmapData
		{
			if ( ! isLoaded() ) 
			{
				return null;
			}
			
			return _bitmap.bitmapData();
		}
		
		public function setTextureData( data:BitmapData ):void
		{
			_bitmap = data;
			_ready = true;
		}
	}
}