package core.objects 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author 
	 */
	public class SpriteObject 
	{
		private var _loaded:Boolean = false;
		private var _bitmapData:BitmapData;
		private var _rectangle:Rectangle;
		
		public function get loaded():Boolean { return _loaded; }
		
		public function set loaded(value:Boolean):void 
		{
			_loaded = value;
		}
		
		public function get bitmapData():BitmapData { return _bitmapData; }
		
		public function set bitmapData(value:BitmapData):void 
		{
			_bitmapData = value;
		}
		
		public function get rectangle():Rectangle { return _rectangle; }
		
		public function set rectangle(value:Rectangle):void 
		{
			_rectangle = value;
		}
		
		public function setTexture(textureData:BitmapData):void 
		{
			// copy the texture information
			
		}
		
		public function setDimensions(top:int, left:int, width:int, height:int):void 
		{
			
		}
		
		public function addAnimation(name:int, frames:int, rows:int, cols:int, width:int, height:int, background:int):void 
		{
			
		}
	}

}