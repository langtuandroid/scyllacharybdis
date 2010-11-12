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
		public override function awake():void
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
		
		public function addMaterial( var name:String, var mat:Material ):void
		{
			_materialList[name] = mat;
		}

		public function getMovieClip(name:String, theme:String = "default"):MovieClip
		{
			_materialList[name];
			return _materialList[name].getMaterial(theme);
		}
	}
}