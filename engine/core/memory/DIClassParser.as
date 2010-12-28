package core.memory 
{
	import core.objects.BaseObject;
	import flash.events.EventDispatcher;
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
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
			
			_classes[className] = new DIClassDetails();
			_classes[className].className = className;		
			
			// Get the calss description
			var typeInfo:XML = describeType( className );
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
						var comName:String = com.attribute("value");
						var compType:Class = getQualifiedClassName( comName ) as Class;
						_classes[className].componentType  = compType;
					}
				}
				
				// Get the requirements
				if (value.attribute("name") == "Requires" ) 
				{
					for each ( var req:XML in value.arg ) 
					{
						var reqName:String = req.attribute("value");
						//trace("qualified: " + getDefinitionByName(getQualifiedClassName(reqName)));
						var depClass:Class = getDefinitionByName(reqName) as Class;
						_classes[className]..addDependencyClass(depClass);
					}
				}				
			}
			parseAncestor( className, _classes[className] );
			
			populateDependencies( _classes[className] );

			return _classes[className];
		}
		
		private function parseAncestor( className:Class, details:DIClassDetails ):void 
		{
			// Get its parent
			className = getDefinitionByName(getQualifiedSuperclassName(className)) as Class;
			
			if ( className == null || className == Object || className == String || className == EventDispatcher || className == BaseObject ) 
			{
				return;
			}
			trace("Parse " + details.className + " Ancestor " + className );
			
			// Get the calss description
			var typeInfo:XML = describeType( className );
			var metaData:XMLList = typeInfo..metadata;
			
			for each ( var value:XML in metaData )
			{
				// Is it a singleton
				if (value.attribute("name") == "Singleton" ) 
				{
					details.singleton = true;
				}
				
				// Is it a singleton
				if (value.attribute("name") == "ComponentType" ) 
				{
					for each ( var com:XML in value.arg ) 
					{
						var comName:String = com.attribute("value");
						trace("Com Name: " + comName );
						details.componentType = getQualifiedClassName( comName ) as Class;
					}
				}
				
				// Get the requirements
				if (value.attribute("name") == "Requires" ) 
				{
					for each ( var req:XML in value.arg ) 
					{
						var reqName:String = req.attribute("value");
						var depClass:Class = getDefinitionByName(getQualifiedClassName(reqName)) as Class;
						details.addDependencyClass(depClass);
					}
				}				
			}
			parseAncestor( className, details );
		}
		
		private function populateDependencies(details:DIClassDetails):void 
		{
			var loadedClasses:Dictionary = new Dictionary();
			var dict:Dictionary = details.getDependencyClass();
			for each ( var value:String in dict ) 
			{
				var tempDetails:DIClassDetails = loadClass( getDefinitionByName(getQualifiedClassName(value)) as Class );
				loadedClasses[tempDetails.className] = tempDetails;
			}
			details.dependencies = loadedClasses;
		}		
	}
}