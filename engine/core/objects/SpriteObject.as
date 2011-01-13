package core.objects 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	public class SpriteObject 
	{
		private var _loaded:Boolean = false;
		private var _bitmapData:BitmapData;
		private var _rectangle:Rectangle;
		private var _playing:String = null;
		private var _animated:Boolean;
		private var _animation:Dictionary = new Dictionary(true);
		
		/**
		 * Is the sprite loaded
		 */
		public function get loaded():Boolean { return _loaded; }
		
		/**
		 * Get the bitmap data
		 */
		public function get bitmapData():BitmapData { return _bitmapData; }
	
		/**
		 * Get the rectangle
		 */
		public function get rectangle():Rectangle 
		{ 
			if ( ! _animated ) 
			{
				return _rectangle;
			}
			
			if ( _playing )
			{
				return _animation[ _playing ]["rectangle"];
			}
			
			return null; 
		}
		
		public function play(animationName:String):void
		{
			if ( _animating[animationName] == null ) 
			{ 
				stop();
				return;
			}
			_playing = animationName; 
		}
		
		public function stop()
		{
			_playing = null;
		}

		/**
		 * Loader function to get the texture data
		 * @param	textureData
		 */
		public function setTexture(textureData:BitmapData):void 
		{
			// copy the texture information
			_loaded = true;
		}
		
		/**
		 * Loader function to get the dimensions
		 * @param	top
		 * @param	left
		 * @param	width
		 * @param	height
		 */
		public function setDimensions(top:int, left:int, width:int, height:int):void 
		{
			_rectangle = new Rectangle(top, left, width, height );
		}
		
		/**
		 * Loader function to get the animations
		 * @param	name
		 * @param	frames
		 * @param	rows
		 * @param	cols
		 * @param	width
		 * @param	height
		 * @param	background
		 */
		public function addAnimation(name:int, frames:int, rows:int, cols:int, width:int, height:int, background:int):void 
		{
			_animation[name] = new Dictionary(true);
			_animation[name]["frames"] = frames;
			_animation[name]["rows"] = frames;
			_animation[name]["cols"] = frames;
			_animation[name]["rectangle"] = new Rectangle(0, 0, width, height);
			_animation[name]["background"] = background;
		}
	}

}