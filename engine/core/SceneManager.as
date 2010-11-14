package core 
{
	import flash.utils.Dictionary;
	import XML;
	import flash.utils.getQualifiedClassName;
	
	import core.BaseObject
	import core.MemoryManager;

	public class SceneManager extends BaseObject
	{
		/****************************************/
		// Dependency Information
		/****************************************/
		
		/**
		 * Return the class scope
		 */
		public static function get scope():int { return SINGLETON_OBJECT };		
		
		/****************************************/
		// Constructors and Allocation 
		/****************************************/
		
		private var _scenes:Dictionary = new Dictionary(true);
		private var _currentScene:Scene = null;
		
		/**
		* Awake is called at the construction of the object
		*/
		public override function awake( ):void
		{
			
		}
		
		/**
		* Destroy is called at the destruction of the object
		*/
		public override function destroy():void 
		{
			_sceneList = null;
			_currentScene = null;
		}	

		/****************************************/
		// Methods
		/****************************************/
		
		/**
		 * Get the root game object
		 * @return
		 */
		public function getRootObject():GameObject
		{
			return _sceneList[_currentScene];
		}
		
		/**
		 * Set the root scene object
		 * @param	var name (String) Name of the scene object
		 */
		public function setRootObject( name:String ):GameObject
		{
			_sceneList[_currentScene].disable();
			_currentScene = name;
			return getRootObject();
		}
		
		/****************************************/
		// XML crap.. might be interesting
		/****************************************/
		
		/**
		 * Load scene xml database
		 * @param	var sceneName (String) name of the scene
		 */
		public function loadScene(sceneName:String):void	
		{
			_xml.onLoad = function(success:Boolean):void 
			{
				if (success) 
				{
					parseTree(sceneName);
				}
				else 
				{
					trace("Unable to load xml");
				}
			}
			//_xml.load("scene.xml");
		}
		
		/**
		 * XML tree parser
		 * @param	var sceneName
		 */
		private function parseTree(sceneName:String):void
		{
			// Set the scene
			setRootObject(sceneName);
			
			var scenes:XMLList = scenes.scene.(@name == sceneName);
			for each ( var scene:XML in scenes )
			{
				var gameObjects:XMLList = scene.gameObject;
				for each ( var gameObject:XML in gameObjects )
				{
					var child:GameObject = _memoryManager.instantiate(GameObject);
					
					var objName:String = gameObject.attribute("name");
					var x:Number = gameObject.position.attribute("x");
					var y:Number = gameObject.position.attribute("y");
					var z:Number = gameObject.position.attribute("z");
					
					var materialName:String = gameObject.material.attribute("name");
					
					for each ( var component:XML in gameObject.component )
					{
						var objType:String = component.attribute("type");
						var objClass:String = component.attribute("class");
						
						// Would be good to set the type here so then we don't need the extra type crap
						child.addComponent( getQualifiedClassName(objClass) );
					}

					getRootObject().addChild( child );
				}
			}
		}
	}
}