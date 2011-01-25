package com.scyllacharybdis.core.memory 
{
	import com.scyllacharybdis.core.objects.BaseObject;
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
		private var _classes:Dictionary = new Dictionary(true);
		private var _dependencies:Dictionary = new Dictionary(true);
		private var _bind:Dictionary = new Dictionary(true);
		
		/**
		 * Load the class details
		 * @param	className 
		 * @return
		 */
		public function loadClass( className:Class ):DIClassDetails
		{
			if ( _classes[className] != null ) 
			{
				return _classes[className];
			}
			return populateClassDetails( className );
		}

		/**
		 * Populate the class details
		 * @param	className
		 * @return
		 */
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
				if (value.attribute("name") == "Component" ) 
				{
					for each ( var com:XML in value.arg ) 
					{
						var comKey:String = com.attribute("value");
						var comValue:String = com.attribute("value");
						var comClass:Class = Class(getDefinitionByName("com.scyllacharybdis.components." + comValue));
						//trace( "DIClassParser: " + comClass );
						_classes[className].componentType  = comClass;
					}
				}
				
				// Get the requirements
				if (value.attribute("name") == "Requires" ) 
				{
					for each ( var req:XML in value.arg ) 
					{
						var reqKey:String = req.attribute("value");
						var reqValue:String = req.attribute("value");
						if ( _bind[ reqKey ] != null ) 
						{
							reqValue = _bind[ reqKey ];
						}
						_classes[className].addDependency(reqKey, reqValue);
					}
				}				
			}
			parseAncestor( className, _classes[className] );

			return _classes[className];
		}
		
		private function parseAncestor( className:Class, details:DIClassDetails ):void 
		{
			// Get its parent
			className = getDefinitionByName(getQualifiedSuperclassName(className)) as Class;
			
			if ( className == null || className == Object || className == String || className == EventDispatcher || className == BaseObject ) 
			{
				//trace("Done parsing ancestors")
				return;
			}
			
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
						var comClass:Class = Class(getDefinitionByName(comName));
						details.componentType  = comClass;
					}
				}
				
				// Get the requirements
				if (value.attribute("name") == "Requires" ) 
				{
					for each ( var req:XML in value.arg ) 
					{
						var reqKey:String = req.attribute("value");
						var reqValue:String = req.attribute("value");
						if ( _bind[ reqKey ] != null ) 
						{
							reqValue = _bind[ reqKey ];
						}
						details.addDependency(reqKey, reqValue);
					}
				}				
			}
			parseAncestor( className, details );
		}
	}
}