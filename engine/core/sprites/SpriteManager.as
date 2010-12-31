package core.sprites 
{
	import core.objects.BaseObject;
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
		private var _spriteList:Dictionary = new Dictionary();
		
		public function loadSprite( fileName:String ):void
		{
			var sprite:XML = new XML();
			sprite.ignoreWhite = true;
			sprite.onLoad = function(success:Boolean):void
			{
				if (success) 
				{
					parseXML( sprite );
				}
				else 
				{
					trace( "Error loading xml file");
				}
			}
			fileName = "materials/" + fileName;
			//material.load( fileName );
		}
	
		private function parseXML(doc:XML):void
		{
			parseTextures( doc..texture );
		}
		
		private function parseTextures(doc:XMLList):void
		{
			var textureName:String = doc.attributes.name;
			parseBodies( doc..bodies );
			parseAreas( doc..areas );
		}
		
		private function parseBodies(bodies:XMLList):void 
		{
			
		}
		
		private function parseAreas(areas:XMLList):void 
		{
			var areaName:String = areas.attributes.name;
			var areaTopLeft:String = areas.attributes.topLeft;
			var areaBottomRight:String = areas.attributes.bottomRight;
			parseAnimations(areas..animations);
		}
		
		private function parseAnimations(animations:XMLList):void 
		{
			var animationName:String = animations.attributes.name;
			var animationFrames:String = animations.attributes.frames;
			var animationTopLeft:String = animations.attributes.topLeft;
			var animationBottomRight:String = animations.attributes.bottomRight;
			var animationBackground:String =animations.attributes.background;
		}	
	}
}
