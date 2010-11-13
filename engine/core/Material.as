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
			_materialNameList = new Dictionary();
			_materialList = new Dictionary();
		}
		
		public override function destroy():void 
		{
			// Should do a better job here as well
			_materialNameList = null;
			_materialList = null;
		}	
		
		/****************************************/
		// Methods
		/****************************************/		
		
		public function addTexture(movieClipName:String, themeName:String = "default"):void
		{
			_materialNameList[themeName] = movieClipName;
		}
		
		public function getMaterial(themeName:String = "default"):MovieClip
		{
			if ( _materialList[themeName] == null ) 
			{
				// Load the movie clip
				_materialList[themeName] = new MovieClip();
				_materialList[themeName].loadMovie(_materialNameList[themeName]);
			}
			return _materialList[themeName];
		}
	}
}