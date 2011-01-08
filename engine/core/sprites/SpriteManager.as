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
		
		private function parseXML(spritesheet:XML):void
		{
			//trace("******************************");
			//trace( "parseXML: " +  spritesheet);
			var test:XMLList = spritesheet..texture;
			trace( test );
			trace( test.attributes );
			trace( test.attributes.filename );

			parseTexture( spritesheet..texture );
			parseBodies( spritesheet..bodies );
			parseAreas( spritesheet..areas );
			parseSprites( spritesheet..sprites );
		}
		

		
		/**
		 * Parse the texture information
		 * @param	doc
		 */
		private function parseTexture(texture:XMLList):void
		{
			trace("******************************");
			trace( "parseTexture: " + texture);
			trace("******************************");
			//var textureName:String = textures.attributes.filename;
			//trace( textureName );
			//_textureManager.loadTexture( textureName );
		}
		
		/**
		 * Parse the physics bodies
		 * @param	bodies
		 */
		private function parseBodies(bodies:XMLList):void 
		{
			//trace("******************************");
			trace( "parseBodies: " + bodies);
		}
		
		/**
		 * Parse the areas
		 * @param	areas
		 */
		private function parseAreas(areas:XMLList):void 
		{
			//trace("******************************");
			//trace( "parseAreas: " + areas);
			var areaName:String = areas.attributes.name;
			var areaTopLeft:String = areas.attributes.topLeft;
			var areaBottomRight:String = areas.attributes.bottomRight;
			parseAnimations(areas..animations);
		}
		
		private function parseSprites(sprites:XMLList):void 
		{
			//trace("******************************");
			//trace( "parseSprites: " + sprites);
		}		
		
		/**
		 * Parse the animations
		 * @param	animations
		 */
		private function parseAnimations(animations:XMLList):void 
		{
			//trace( "parseAnimations: " + animations);
			var animationName:String = animations.attributes.name;
			var animationFrames:String = animations.attributes.frames;
			var animationTopLeft:String = animations.attributes.topLeft;
			var animationBottomRight:String = animations.attributes.bottomRight;
			var animationBackground:String =animations.attributes.background;
		}	
	}
}
