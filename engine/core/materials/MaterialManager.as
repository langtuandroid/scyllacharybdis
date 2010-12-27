package core.materials 
{
	import core.objects.BaseObject;
	import flash.utils.Dictionary;
	import core.materials.TextureManager;
	import core.materials.Material;
	import XML;
	import XMLList;
	
	/**
	 */
	[Singleton]
	[Requires (TextureManager)]
	public class MaterialManager extends BaseObject
	{
		private var _materialList:Dictionary = new Dictionary();
		
		public function loadMaterial( fileName:String ):void
		{
			var material:XML = new XML();
			material.ignoreWhite = true;
			material.onLoad = function(success:Boolean):void
			{
				if (success) 
				{
					parseXML( material );
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
			for (var i:int = 0; i < doc.firstChild.childNodes.length; i++) 
			{
				if (doc.firstChild.childNodes[i].nodeName == "texture")
				{
					parseTexture(doc.firstChild.childNode[i]);
				}
			}
		}
		
		private function parseTexture(doc:XMLList):void
		{
			var textureName:String = doc.attributes.name;
			for (var i:int = 0; i < doc.firstChild.childNodes.length; i++) 
			{
				if (doc.firstChild.childNodes[i].nodeName == "area") 
				{
					parseArea(doc.firstChild.childNodes[i]);
				} 
				else if (doc.firstChild.childNodes[i].nodeName == "animation") 
				{
					parseAnimation(doc.firstChild.childNodes[i]);
				}
				else 
				{ 
					trace("Found something weird: " + doc.firstChild.childNodes[i] );
				}
			}
		}
		
		private function parseArea(doc:XMLList):void 
		{
			var areaName:String = doc.attributes.name;
			var areaTopLeft:String = doc.attributes.topLeft;
			var areaBottomRight:String = doc.attributes.bottomRight;
		}
		
		private function parseAnimation(doc:XMLList):void 
		{
			var animationName:String = doc.attributes.name;
			var animationFrames:String = doc.attributes.frames;
			var animationTopLeft:String = doc.attributes.topLeft;
			var animationBottomRight:String = doc.attributes.bottomRight;
			var animationBackground:String = doc.attributes.background;
		}	
	}
}
