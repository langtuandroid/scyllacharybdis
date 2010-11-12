package core 
{
	import flash.utils.Dictionary;
	import core.BaseObject
	import XML;
	import flash.utils.getQualifiedClassName;

	public class SceneManager extends BaseObject
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
		
		private var _sceneList:Dictionary = new Dictionary;
		private var _currentScene:String = "default";
		
		private var _xml:XML = new XML();
		
		/**
		* Awake is called at the construction of the object
		*/
		public override function awake( ):void
		{
			_sceneList = new Dictionary;
			_rootNode = new GameObject();
			_currentScene = "default";		
			
			_xml = new XML();
			_xml.ignoreWhite=true;
		}
		
		public override function destroy():void 
		{
			_sceneList = null;
			_rootNode = null;
			_currentScene = null;

			delete _sceneList;
			delete _xml;
		}	

		/****************************************/
		// Methods
		/****************************************/
		
		public function getSceneRoot():GameObject
		{
			return _sceneList[_currentScene];
		}
		
		public function setSceneRoot( var name:String ):GameObject
		{
			_sceneList[_currentScene].disable();
			_currentScene = name;
			return getSceneRoot();
		}
		
		/****************************************/
		// XML crap.. might be interesting
		/****************************************/
		
		public function loadScene(var sceneName:String) 		
		{
			_xml.onLoad = function(success) {
				if (success) 
				{
					parseTree(sceneName);
				}
				else 
				{
					trace("Unable to load xml");
				}
			}
			_xml.load("scene.xml");
		}
		
		private function parseTree(var sceneName:String):void
		{
			// Set the scene
			setSceneRoot(sceneName);
			
			for each ( var scene:XML in scenes.scene.(@name == sceneName) )
			{
				for each ( var gameObject:XML in scene.gameObject )
				{
					var child:GameObject = _memoryManager.Instanciate(GameObject);
					
					var name = gameObject.attribute("name");
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

					getSceneRoot.addChild( child );
				}
			}
		}
	}
}