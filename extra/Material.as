package core 
{
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	/**
	 */
	public class Material
	{
		private var _materialNameList:Dictionary = new Dictionary();
		private var _materialList:Dictionary = new Dictionary();
		
		public function addTexture(var movieClipName:String, var themeName:String = "default")
		{
			_materialNameList[themeName] = movieClipName;
		}
		
		public function getMaterial(themeName:String = "default")
		{
			if ( _materialList[themeName] == null ) 
			{
				// Load the movie clip
				_materialList[themeName] = new MovieClip();
			}
			return _materialList[themeName];
		}
	}
}