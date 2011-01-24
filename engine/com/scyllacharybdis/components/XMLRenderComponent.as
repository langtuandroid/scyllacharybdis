package com.scyllacharybdis.components 
{
	import com.scyllacharybdis.core.ami.AMITask;
	import com.scyllacharybdis.core.loaders.TextureLoaderAction;
	import com.scyllacharybdis.core.loaders.TextureResults;
	import com.scyllacharybdis.core.loaders.XMLLoaderAction;
	import com.scyllacharybdis.core.loaders.XMLResults;
	import com.scyllacharybdis.core.objects.BaseObject;
	import com.scyllacharybdis.core.objects.SpriteObject;
	import com.scyllacharybdis.core.objects.TextureObject;
	import com.scyllacharybdis.core.rendering.Backbuffer;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author 
	 */
	[Component (type="RenderComponent")]
	public class XMLRenderComponent extends BaseObject
	{
		private var _area:String;
		private var _sprite:SpriteObject = new SpriteObject();
		private var _texture:TextureObject;
		
		/**
		 * Load the material
		 * @param	fileName (String) The definision file
		 * @param	area (String) The area to load
		 */
		public function loadMaterial( fileName:String, area:String ):void
		{
			// Store the area
			_area = area;
			
			// Create the ami task to load the def
			var task:AMITask = new AMITask( new XMLLoaderAction(fileName), new XMLResults(), this );
		}
		
		/**
		 * Add the renderable to the surface
		 * @param	surface (Backbuffer) The render surface
		 */
		public function render( surface:Backbuffer ):void
		{
			if ( _texture == null )
			{
				return;
			}
			
			if ( ! _sprite.loaded ) 
			{
				return;
			}

			// Copy the pixels to the backbuffer
			surface.copyPixels(_sprite.bitmapData, _sprite.rectangle, new Point(owner.position.x, owner.position.y), null, null, true)
		}
		
		/**
		 * Parse the results from the load action
		 * @param	data
		 */
		public function xmlLoadSuccess( data:* ):void
		{
			// Get the texture name
			var texture:String = data.parseTexture( data..material );
			if ( texture != null )
			{
				var loadTexture:AMITask = new AMITask( new TextureLoaderAction(texture), new TextureResults(), this );
			}
			var areas:String = data.parseAreas( data..material );			
		}
		
		/**
		 * Handle the xml load failure
		 * @param	data
		 */
		public function xmlLoadError( data:* ):void
		{
			trace( "xmlLoadError: " + data );
		}
		
		public function textureLoadSuccess( data:TextureObject ):void
		{
			_sprite.setTexture( data.getTextureData() );
		}
		
		/**
		 * Handle the texture load failure
		 * @param	data
		 */		
		public function textureLoadError( data:* ):void
		{
			trace( "textureLoadError: " + data );
		}
		
		/**
		 * Parse the texture information and load the file
		 * @param	doc
		 */
		private function parseTexture(texture:XMLList):void
		{
			// Get the texture name
			var textureName:String = texture.attribute("filename");
			if ( textureName != null )
			{
				// Load the texture
				var loadTexture:AMITask = new AMITask( new TextureLoaderAction(textureName), new TextureResults(), this );
			}
		}
		
		/**
		 * Parse the areas
		 * @param	areas
		 */
		private function parseAreas(areas:XMLList):void 
		{
			for each ( var area:XML in areas..area ) 
			{
				// Get the area name
				var name:String = area.attribute("name");
				
				// Is this the right definition
				if ( name == _area ) 
				{
					// Get the attributes
					var top:int= area.attribute("top");
					var left:int = area.attribute("left");
					var width:int = area.attribute("width");
					var height:int = area.attribute("height");
					
					// Store the dimensions of the sprite
					_sprite.setDimensions(top, left, width, height);
					
					// Parse the animations
					parseAnimations(areas..animations);
				}
			}
		}

		/**
		 * Parse the animations
		 * @param	animations
		 */
		private function parseAnimations(animations:XMLList):void 
		{
			for each ( var animation:XML in animations..animation ) 
			{
				var name:int= animation.attribute("name");
				var frames:int= animation.attribute("frames");
				var rows:int= animation.attribute("rows");
				var cols:int= animation.attribute("cols");
				var width:int= animation.attribute("width");
				var height:int= animation.attribute("height");
				var background:int = animation.attribute("background");
				_sprite.addAnimation( name, frames, rows, cols, width, height, background );
			}
		}	
	}
}