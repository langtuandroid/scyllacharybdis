package com.scyllacharybdis.core.di
{
	import com.scyllacharybdis.core.di.AbstractModule;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.utils.Dictionary;
	import org.as3commons.bytecode.reflect.ByteCodeType;
	import org.as3commons.reflect.Type;
	
	/**
	 * Dependency Injector
	 */
	public class Injector 
	{
		private var _displayObject:DisplayObjectContainer;
		private var _classNames:Dictionary = new Dictionary(true);
		private var _singletonNames:Dictionary = new Dictionary(true);
		private var _componentNames:Dictionary = new Dictionary(true);
		
		public function Injector(module:AbstractModule ,displayObject:DisplayObjectContainer) 
		{
			// Store the display object
			_displayObject = displayObject;
			
			// Scan the classes and metadata
			scanClasses( _displayObject.loaderInfo );
			scanMetaData( _displayObject.loaderInfo );
			
			// Print the results
			printDictionary( "Class Names", _classNames );
			printDictionary ( "Singletons", _singletonNames );
			printDictionary( "Components", _componentNames );
		}
		
		private function scanClasses(loaderInfo:LoaderInfo):void 
		{
			var definitionNames:Array = ByteCodeType.definitionNamesFromLoader( loaderInfo );
			for each ( var key:String in definitionNames )
			{
				// Split the package names on dot
				var packageNameArray:Array = key.split(".");
				
				// Skip the as3common classes
				if ( packageNameArray[1] == "as3commons" ) 
				{
					continue;
				}
				
				// Add the class to the list
				_classNames[key] = key;
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
					var type:Type = Type.forName( definitionNames[i] ); 
					_singletonNames[type.clazz] = type.clazz;
				}		
			}
			
			// Check for components
			if ( metaDataLookup['component'] != null ) {
				definitionNames = metaDataLookup['component'];
				for (i = 0; i < definitionNames.length; i++)
				{
					type = Type.forName( definitionNames[i] ); 
					_componentNames[type.clazz] = type.getField("type");
				}		
			}		
		}
		
		private function printDictionary( name:String, dict:Dictionary ):void
		{
			trace("*******************************");
			trace( name );
			trace();
			for each ( var key:String in dict )
			{
				trace( "key: " + key + " value: " + dict[key] );
			}
		}
	}
}