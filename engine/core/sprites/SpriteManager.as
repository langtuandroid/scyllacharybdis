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
			trace( "parseXML: " +  xml);
			parseTextures( xml..texture );
		}
		
		/**
		 * Parse the texture information
		 * @param	doc
		 */
		private function parseTextures(textures:XMLList):void
		{
			trace( "parseTextures: " + textures);
			var textureName:String = textures.attributes.name;
			_textureManager.loadTexture( textureName );
			parseBodies( textures..bodies );
			parseAreas( textures..areas );
		}
		
		/**
		 * Parse the physics bodies
		 * @param	bodies
		 */
		private function parseBodies(bodies:XMLList):void 
		{
			trace( "parseBodies: " + bodies);
			
		}
		
		/**
		 * Parse the areas
		 * @param	areas
		 */
		private function parseAreas(areas:XMLList):void 
		{
			trace( "parseAreas: " + areas);
			var areaName:String = areas.attributes.name;
			var areaTopLeft:String = areas.attributes.topLeft;
			var areaBottomRight:String = areas.attributes.bottomRight;
			parseAnimations(areas..animations);
		}
		
		/**
		 * Parse the animations
		 * @param	animations
		 */
		private function parseAnimations(animations:XMLList):void 
		{
			trace( "parseAnimations: " + animations);
			var animationName:String = animations.attributes.name;
			var animationFrames:String = animations.attributes.frames;
			var animationTopLeft:String = animations.attributes.topLeft;
			var animationBottomRight:String = animations.attributes.bottomRight;
			var animationBackground:String =animations.attributes.background;
		}	
	}
}
