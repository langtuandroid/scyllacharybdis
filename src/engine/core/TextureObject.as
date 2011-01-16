package core.objects 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	/**
	 */
	public class TextureObject
	{
		private var _bitmap:Bitmap;
		
		public function TextureObject( bitmap:Bitmap )
		{
			_bitmap = bitmap;
		}
		
		public function getTextureData():BitmapData
		{
			return _bitmap.bitmapData;
		}
	}
}