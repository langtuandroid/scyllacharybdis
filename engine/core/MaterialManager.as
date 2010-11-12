package core 
{
	import flash.utils.Dictionary;
	import core.BaseObject
	import XML;
	import XMLList;
	import flash.display.MovieClip
	
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
		
		private var _xml:XML;
		private var _materialList:Dictionary;
		
		/**
		* Awake is called at the construction of the object
		*/
		public override function awake():void
		{
			_xml = new XML();
			_materialList = new Dictionary();
		}
		
		public override function destroy():void 
		{
			// Should do a better job cleaning this up
			delete _xml;
			_xml = null;

			delete _materialList;
			_materialList = null;
		}	

		/****************************************/
		// Methods
		/****************************************/
		
		/**
		 * Add a material to the tree
		 * @param	name (String) a unique name for the material
		 * @param	mat  (Material) the material object
		 */
		public function addMaterial( var name:String, var mat:Material ):void
		{
			if ( _materialList[name] != null ) {
				trace("Name already taken");
				return;
			}
			_materialList[name] = mat;
		}

		/**
		 * Get the movie clip from the material
		 * @param	name (String) a unique name for the material
		 * @param	theme (String) the theme you want to use
		 * @return Move
		 */
		public function getMovieClip(name:String, theme:String = "default"):movieClip
		{
			_materialList[name];
			return _materialList[name].getMaterial(theme);
		}
		
		private function loadMaterials()
		{
			// Define a callback method
			_xml.onLoad = function(success) {
			if (success) 
			{
				// Parse the xml tree
				parseTree();
			}
			
			// Load the materials
			_xml.load("materials.xml");
		}
		}
		
		private function parseTree()
		{
			// Loop through the materials
			for each ( var material:XML in materials.material ) 
			{
				// Create a new material ( should use memory manager )
				var mat:Material = new Material();
				
				// Get the name off the material
				var materialName:String = material.attribute("name");

				// Loop through the themes 
				for each ( var theme:XML in material.theme ) 
				{
					var themeName:String = theme.attribute("name");
					var movieClip:String = theme.movieClip.attribute("name");
					mat.setTexture(movieClip, themeName);
				}
				
				// Add the material to the list
				addMaterial(materialName, mat);
			}			
		}
	}
}