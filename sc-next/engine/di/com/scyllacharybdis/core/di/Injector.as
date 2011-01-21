package com.scyllacharybdis.core.di
{
	import com.scyllacharybdis.core.di.AbstractModule;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.utils.Dictionary;
	import org.as3commons.bytecode.reflect.ByteCodeType;
	import org.as3commons.bytecode.reflect.ByteCodeTypeCache;
	import org.as3commons.reflect.MetaData;
	import org.as3commons.reflect.MetaDataArgument;
	import org.as3commons.reflect.TypeCache;

	/**
	 * Dependency Injector
	 */
	public class Injector 
	{
		private var _displayObject:DisplayObjectContainer;
		private var _module:AbstractModule;
		
		private var _classNames:Dictionary = new Dictionary(true);
		private var _singletonNames:Dictionary = new Dictionary(true);
		private var _componentNames:Dictionary = new Dictionary(true);
		
		public function Injector(module:AbstractModule, displayObject:DisplayObjectContainer) 
		{
			// Store the parameters
			_displayObject = displayObject;
			_module = module;
			
			// Scan the classes and metadata
			//scanClasses( _displayObject.loaderInfo );
			//scanMetaData( _displayObject.loaderInfo );
			testClasses( _displayObject.loaderInfo );
			
			// Configure the injector
			_module.configure();
			
			// Print the results
			//printDictionary( "Class Names", _classNames );
			//printDictionary ( "Singletons", _singletonNames );
			//printDictionary( "Components", _componentNames );
		}
		
		public function getInstance( type:Class ):*
		{
			var bindings:Dictionary = _module.getBindings();
			
		}
		
		private function testClasses(loaderInfo:LoaderInfo):void
		{
			trace("testclasses");
			ByteCodeType.fromLoader(loaderInfo);
			var typeCache:TypeCache = ByteCodeType.getTypeProvider().getTypeCache();
			for each (var key:String in typeCache.getKeys() ) 
			{
				// Split the package names on dot
				var packageNameArray:Array = key.split(".");
				
				// Skip the extra classes
				if ( packageNameArray[1] == "as3commons" || packageNameArray[0] == "Main" || packageNameArray[0] == "avmplus" ) 
				{
					continue;
				}				
				
				var type:ByteCodeType = typeCache.get(key) as ByteCodeType; 
				trace("*******************************");
				trace( key );
				var componentArray:Array = type.getMetaData("Component");
				for each(var metadata:MetaData in componentArray)
				{
					var arg:MetaDataArgument = metadata.getArgument("type");
					trace( arg.key + ": " + arg.value );
				}
				
				//var metadata:Metadata = type.getMetaDataContainers("Component");
				//var metadata:Metadata = type.getMetadata("Component");
				//var arg:MetaDataArgument = metadata.getArgument("type");
				/*
				var containers:Array = type.getMetaDataContainers("Component");
				for each(var metadataContainer:IMetaDataContainer in containers)
				{
					trace("metacontainer: " + metadataContainer);
					if (metadataContainer is Method)
					{
					  trace(metadataContainer);//do something...
					} 
					else if (metadataContainer is Field)
					{
					  trace(metadataContainer);
					}
					else
					{
						trace(metadataContainer);
					}
				}
				*/
			}			
		}
		
		
		private function scanClasses(loaderInfo:LoaderInfo):void 
		{
			var definitionNames:Array = ByteCodeType.definitionNamesFromLoader( loaderInfo );
			
			for each ( var value:String in definitionNames )
			{
				// Split the package names on dot
				var packageNameArray:Array = value.split(".");
				
				// Skip the as3common classes
				if ( packageNameArray[1] == "as3commons" || packageNameArray[0] == "Main" || packageNameArray[0] == "avmplus" ) 
				{
					continue;
				}
			
				// Add the class to the list
				_classNames[value] = value;
			}
		}
		
		private function scanMetaData(loaderInfo:LoaderInfo):void
		{
			// Load the meta data
			var metaDataLookup:Object = ByteCodeType.metaDataLookupFromLoader(loaderInfo);
			
			// Check for singletons
			if ( metaDataLookup['singleton'] != null ) {
				var definitionNames:Array = metaDataLookup['singleton'];
				for (var i:uint = 0; i < definitionNames.length; i++)
				{
					_singletonNames[definitionNames[i]] =  definitionNames[i];
				}		
			}
			
			// Check for components
			if ( metaDataLookup['component'] != null ) {
				definitionNames = metaDataLookup['component'];
				for (i = 0; i < definitionNames.length; i++)
				{
					_componentNames[definitionNames[i]] =  definitionNames[i];
				}		
			}		
		}
		
		
		private function printDictionary( name:String, dict:Dictionary ):void
		{
			trace("*******************************");
			trace( name );
			trace();
			for ( var key:String in dict )
			{
				trace( "key: " + key + " value: " + dict[key] );
			}
		}
	}
}