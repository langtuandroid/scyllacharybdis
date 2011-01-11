package components 
{
	import core.objects.TextureObject;
	/**
	 * ...
	 * @author 
	 */
	public class XMLRenderComponent extends RenderComponent
	{
		private var _area:String;
		private var _texture:TextureObject;
		
		/**
		 * Add the renderable to the surface
		 * @param	surface (DisplayObjectContainer) 
		 */
		public function render( surface:Backbuffer ):void
		{
			if ( _texture == null )
			{
				return;
			}
			
			// Get the bitmap
			var bitmapData = _texture.getTextureData();
			
			// Copy the pixels to the backbuffer
			surface.copyPixels(bitmapData, bitmapData.rect, new Point(owner.position.x, owner.position.y), null, null, true)
		}
				
		
		public function loadMaterial( fileName:String, area:String=null)
		{
			_area = area;
			var task:AMITask = new AMITask( new XMLLoaderAction(fileName), new RendererResults(), this );
		}
		
		public function parseXML( data:* ):void
		{
			var textures:String = _renderer.parseTexture( data..material );
			var areas:String = _renderer.parseAreas( data..material );			
		}
		
		/**
		 * Parse the texture information
		 * @param	doc
		 */
		public function parseTexture(texture:XMLList):void
		{
			trace("******************************");
			var textureName:String = texture.attribute("filename");
			trace("texture name: " + textureName );
		}
		
		/**
		 * Parse the areas
		 * @param	areas
		 */
		public function parseAreas(areas:XMLList):void 
		{
			trace("******************************");
			trace( "parseAreas: " + areas);
			for each ( var area:XML in areas..area ) {
				trace( "Area name: " + area.attribute("name") );
				trace( "Area topleft: " + area.attribute("topleft") );
				trace( "Area bottomright: " + area.attribute("bottomright") );
				parseAnimations(areas..animations);
			}
		}

		/**
		 * Parse the animations
		 * @param	animations
		 */
		public function parseAnimations(animations:XMLList):void 
		{
			trace("******************************");
			trace( "parseAnimations: " + animations);
			for each ( var animation:XML in animations..animation ) {
				trace( "Animation name: " + animation.attribute("name") );
				trace( "Animation frames: " + animation.attribute("frames") );
				trace( "Animation rows: " + animation.attribute("rows") );
				trace( "Animation cols: " + animation.attribute("cols") );
				trace( "Animation width: " + animation.attribute("width") );
				trace( "Animation height: " + animation.attribute("height") );
				trace( "Animation background: " + animation.attribute("background") );
			}
		}	
	}
}