package core.loaders 
{
	import core.objects.BaseObject;
	/**
	 * ...
	 * @author 
	 */
	[Singleton]
	public class XMLCache extends BaseObject
	{
		private var _xmlList:Dictionary = new Dictionary(true);
		
		public function getCache( fileName:String )
		{
			return _xmlList[fileName];
		}
		
		public function setCache(fileName:String, xml:XML):void 
		{
			_xmlList[fileName] = xml;
		} 
	}
}