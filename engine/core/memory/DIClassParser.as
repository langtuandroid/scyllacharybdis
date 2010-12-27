package core.memory 
{
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 */
	public class DIClassParser 
	{
		private var _classes:Dictionary = new Dictionary();
		private var _dependencies:Dictionary = new Dictionary();
		
		public function loadClass( className:Class ):DIClassDetails
		{
			if ( _classes[className] != null ) 
			{
				return _classes[className];
			}
			
			return populateClassDetails( className );
		}
		
		private function populateClassDetails( className:Class ):DIClassDetails 
		{
			// Create the class details
			_classes[className] = new DIClassDetails();
			_classes[className].className = className;

			// Get the calss description
			var typeInfo:XML = describeType(className);
			var metaData:XMLList = typeInfo..metadata;
			
			for each ( var value:XML in metaData )
			{
				// Is it a singleton
				if (value.attribute("name") == "Singleton" ) 
				{
					_classes[className].singleton = true;
				}
				
				// Is it a singleton
				if (value.attribute("name") == "ComponentType" ) 
				{
					for each ( var com:XML in value.arg ) 
					{
						_classes[className].componentType = getDefinitionByName(getQualifiedClassName(com.attribute("value"))) as Class;
					}
				}
				
				// Get the requirements
				if (value.attribute("name") == "Requires" ) 
				{
					for each ( var req:XML in value.arg ) 
					{
						var reqName:String = req.attribute("value");
						var depClass:Class = getDefinitionByName(getQualifiedClassName(reqName)) as Class;
						var classObj:DIClassDetails = loadClass(depClass);
						_classes[className].addDependency(classObj);
					}
				}				
			}
			return _classes[className];
		}
	}
}