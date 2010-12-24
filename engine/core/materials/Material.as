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
		

	}
}