package core.sprites 
{
	import core.objects.BaseObject;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import core.sprites.TextureManager;
	import core.sprites.Sprite;
	import XML;
	import XMLList;
	
	/**
	 */
	[Singleton]
	[Requires ("core.sprites.TextureManager")]
	public class SpriteManager extends BaseObject
	{
		private var _textureManager:TextureManager;
		private var _spriteList:Dictionary = new Dictionary(true);
		
		override public function awake():void 
		{
			_textureManager = getDependency(TextureManager);
			super.awake();
		}
		
		/**
		 * Load the sprite from the xml file
		 * @param	sheetName
		 * @param	spriteName
		 * @return
		 */
		public function loadSprite( sheetName:String, spriteName:String ):Sprite
		{
			if ( _spriteList[ sheetName ] == null ) 
			{
				_spriteList[ sheetName ] = new Dictionary(true);
			} 
			else 
			{
				// Check to see if we have already loaded the sprite
				if ( _spriteList[sheetName][spriteName] != null ) 
				{	
					// Return the requested sprite
					return _spriteList[sheetName][spriteName];
				}
			}

			// Create the sprite
			_spriteList[ sheetName ][spriteName] = new Sprite();
			
			// Load the xml file
			var loader:URLLoader = new URLLoader( new URLRequest("sprites/" + sheetName ) );
			loader.addEventListener(Event.COMPLETE, loadedCompleteHandler);
			
			// Return the sprite pointer
			return _spriteList[sheetName][spriteName];
		}
	
		/**
		 * Parse the xml tree
		 * @param	doc
		 */
		private function loadedCompleteHandler(e:Event):void
		{
			e.target.removeEventListener(Event.COMPLETE, loadedCompleteHandler);
			var xml:XML = XML(e.target.data);		
			parseXML( xml );
		}

		/**
		 * Parse the xml file
		 * @param	spritesheet
		 */
		private function parseXML(spritesheet:XML):void
		{
			//parseTexture( spritesheet..texture );
			//parseBodies( spritesheet..bodies );
			//parseAreas( spritesheet..areas );
			parseSprites( spritesheet..sprites );
		}
		
		/**
		 * Parse the texture information
		 * @param	doc
		 */
		private function parseTexture(texture:XMLList):void
		{
			trace("******************************");
			var textureName:String = texture.attribute("filename");
			trace("texture name: " + textureName );
			if ( textureName != null )
			{
				_textureManager.loadTexture( textureName );
			}
		}
		
		/**
		 * Parse the physics bodies 
		 * @param	bodies
		 */
		private function parseBodies(bodies:XMLList):void 
		{
			trace("******************************");
			for each ( var body:XML in bodies..body )
			{
				trace();
				trace ("Body name: " + body.attribute("name") );
				trace ("Body dynamic: " + body.attribute("dynamtic") );
				for each ( var shape:XML in body..shape ) {
					if ( shape.attribute("type") == "circle" ) 
					{
						trace ("Shape type: " + shape.attribute("type") );
						trace ("Shape center: " + shape.attribute("center") );
						trace ("Shape radius: " + shape.attribute("radius") );
					} 
					else if ( shape.attribute("type") == "polygon" ) 
					{
						trace ("Shape type: " + shape.attribute("type") );
						trace ("Shape top: " + shape.attribute("top") );
						trace ("Shape left: " + shape.attribute("left") );
						trace ("Shape width: " + shape.attribute("width") );
						trace ("Shape height: " + shape.attribute("height") );
					}
					else
					{
						trace("Shape has to be a polygon or circle: " + shape.attributes() );
					}
					trace ("Shape friction: " + shape.attribute("friction") );
					trace ("Shape density: " + shape.attribute("density") );
					trace ("Shape restitution: " + shape.attribute("restitution") );
				}
			}
		}
		
		/**
		 * Parse the areas
		 * @param	areas
		 */
		private function parseAreas(areas:XMLList):void 
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
		private function parseAnimations(animations:XMLList):void 
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

		/**
		 * Parse the sprite definition
		 * @param	sprites
		 */
		private function parseSprites(sprites:XMLList):void 
		{
			trace("******************************");
			trace( "parseSprites: " + sprites);
			for each ( var sprite:XML in sprites..sprite ) {
				trace( "Sprite name: " + sprite.attribute("name") );
				trace( "Sprite name: " + sprite.attribute("area") );
				trace( "Sprite name: " + sprite.attribute("body") );
			}
		}		
		
	}
}
