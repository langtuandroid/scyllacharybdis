package core.cache 
{
	import core.objects.TextureObject;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	public class TextureCache 
	{
		private var _textureList:Dictionary = new Dictionary(true);
		
		/**
		 *  Return the loaded xml
		 * @param	fileName (String) Key to the data
		 */
		public function getCache( fileName:String ):TextureObject
		{
			return _textureList[fileName];
		}
		
		/**
		 * Store the xml
		 * @param	fileName (String) Key to the data
		 * @param	xml (XML) The xml data
		 */
		public function setCache(fileName:String, texture:TextureObject):void 
		{
			_textureList[fileName] = texture;
		} 		
	}

}