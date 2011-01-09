package core.loaders 
{
	/**
	 */
	public class RenderDetails 
	{
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