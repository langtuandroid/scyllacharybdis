package core 
{
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	/**
	 */
	public class Material extends BaseObject
	{
		/****************************************/
		// Constructors and Allocation 
		/****************************************/
		private var _materialNameList:Dictionary;
		private var _materialList:Dictionary;
		
		/**
		* Awake is called at the construction of the object
		*/
		public override function awake():void
		{
			_materialNameList:Dictionary = new Dictionary();
			_materialList:Dictionary = new Dictionary();
		}
		
		public override function destroy():void 
		{
			// Should do a better job here as well
			_materialNameList:Dictionary = null;
			_materialList:Dictionary = null;
		}	
		
		/****************************************/
		// Methods
		/****************************************/		
		
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
				_materialList[themeName].loadMovie(movieClipName);
			}
			return _materialList[themeName];
		}
	}
}