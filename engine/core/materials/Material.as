package core.materials 
{
	/**
	 */
	public class Material 
	{
		public function Material( fileName:String ) 
		{
			var myXML:XML = new XML();
			myXML.ignoreWhite=true;
			myXML.load( "materials/" + fileName );
			myXML.onLoad = function(success) 
			{
				if (success) 
				{
					parseXML( myXML );
				}
				else 
				{
					trace( "Error loading xml file");
				}
			}
		}
		
		private function parseXML(doc:XMLList)
		{
			for (var i = 0; i < doc.firstChild.childNodes.length; i++) 
			{
				if (doc.firstChild.childNodes[n].nodeName == "texture")
				{
					parseTexture(doc.firstChild.childNode[n]);
				}
			}
		}
		
		private function parseTexture(doc:XMLList)
		{
			var textureName = doc.attributes.name;
			for (var i = 0; i < doc.firstChild.childNodes.length; i++) 
			{
				if (doc.firstChild.childNodes[n].nodeName == "area") 
				{
					parseArea(doc.firstChild.childNodes[n]);
				} 
				else if (doc.firstChild.childNodes[n].nodeName == "animation") 
				{
					parseAnimation(doc.firstChild.childNodes[n]);
				}
				else 
				{ 
					trace("Found something weird: " + doc.firstChild.childNodes[n] );
				}
			}
		}
		
		private function parseArea(doc:XMLList):void 
		{
			var areaName = doc.attributes.name;
			var areaTopLeft = doc.attributes.topLeft;
			var areaBottomRight = doc.attributes.bottomRight;
		}
		
		private function parseAnimation(doc:XMLList):void 
		{
			var animationName = doc.attributes.name;
			var animationFrames = doc.attributes.frames;
			var animationTopLeft = doc.attributes.topLeft;
			var animationBottomRight = doc.attributes.bottomRight;
			var animationBackground = doc.attributes.background;
		}
	}
}