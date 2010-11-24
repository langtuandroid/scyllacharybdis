package core 
{
	/**
	 */
	public class MaterialManager
	{
	import flash.utils.Dictionary;
	import core.BaseObject
	/**
	 */
	public class MaterialManager extends BaseObject
	{
		/****************************************/
		// Dependency Information
		/****************************************/
		
		/**
		 * Return the class scope
		 */
		public static function get scope():int { base.SINGLETON_OBJECT };
		
		/**
		 * Return the class dependencies
		 */
		public static function get dependencies():Array  
		{
			return null;
		}
		
		/****************************************/
		// Constructors and Allocation 
		/****************************************/
		
		private var _materialList:Dictionary;
		
		/**
		* Awake is called at the construction of the object
		*/
		public override function awake( ):void
		{
			_materialList = new Dictionary();
		}
		
		public override function destroy():void 
		{
			// Should do a better job cleaning this up
			delete _materialList;
			_materialList = null;
		}	

		/****************************************/
		// Methods
		/****************************************/
		
		public function getMaterial(name:String):Texture
		{
			return _materialList[name];
		}
		
		public function createMaterial( var name:String ):Material
		{
			if ( _materialList[name] != null ) {
				trace("Name already used!!!!");
				return null;
			}
			_materialList[name] = new Material;
			return _materialList[name];
		}
	}
}