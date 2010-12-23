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
			myXML.load("fileName.xml");
			myXML.onLoad = function(success) 
			{
				if (success) 
				{
					parseXML( myXML.fireChild );
				}
				else 
				{
					trace( "Error loading xml file");
				}
			}
		}
		
		public function parseXML(doc:XMLList)
		{
			var myImage = myXML.firstChild.childNodes;
			for (i=0; i<myImage.length; i++) {
				var imageNumber = i+1;
				var imageName = myImage[i].attributes.title;
				var imageURL = myImage[i].firstChild.nodeValue;
				trace ("My image number "+imageNumber+" is titled "+imageName+" and its URL is "+imageURL+".")
			}
		}
	}
}