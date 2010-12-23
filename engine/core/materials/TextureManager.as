package core.materials 
{
	import core.objects.BaseObject;
	import core.materials.Texture;
	import flash.utils.Dictionary;
	/**
	 */
	public class TextureManager extends BaseObject
	{
		private var _textureList:Dictionary = new Dictionary();
		
		public function TextureManager() 
		{
		}
		
		public function loadTexture( fileName:String ):Texture
		{
			if ( _textureList[fileName] != null ) {
				return _textureList[fileName];
			}
			
			_textureList = new Texture( fileName );
		}
	}
}