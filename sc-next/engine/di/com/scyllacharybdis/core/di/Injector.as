package com.scyllacharybdis.core.di
{
	import com.scyllacharybdis.core.di.AbstractModule;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.utils.Dictionary;
	import org.as3commons.bytecode.reflect.ByteCodeType;
	import org.as3commons.bytecode.reflect.ByteCodeTypeCache;
	import org.as3commons.lang.ClassUtils;
	import org.as3commons.reflect.MetaData;
	import org.as3commons.reflect.MetaDataArgument;
	import org.as3commons.reflect.Parameter;
	import org.as3commons.reflect.Type;
	import org.as3commons.reflect.TypeCache;

	/**
	 * Dependency Injector
	 */
	public class Injector 
	{
		private var _displayObject:DisplayObjectContainer;
		private var _module:AbstractModule;
		
		private static var _classNames:Dictionary = new Dictionary(true);
		private static var _singletonNames:Dictionary = new Dictionary(true);
		private static var _componentNames:Dictionary = new Dictionary(true);
		
		/**
		 * Injector constructor
		 * @param module (AbstractModule) The configuration for the injector.
		 * @param displayObject (DisplayObjectContainer) The main display object.
		 */
		public function Injector(module:AbstractModule, displayObject:DisplayObjectContainer) 
		{
			// Store the parameters
			_displayObject = displayObject;
			_module = module;
			
			// Scan the classes and metadata
			scanClasses( _displayObject.loaderInfo );
			
			// Configure the injector
			_module.configure();
		}
		
		/**
		 * Get an instance of an object
		 * @param	type (Class) The class to create
		 * @return (*) The newly created class
		 */
		public function getInstance( classType:Class ):*
		{
			trace( classType );
			
			// Get the cache
			var typeCache:TypeCache = ByteCodeType.getTypeProvider().getTypeCache();
			
			// Get the cache
			var type:ByteCodeType = typeCache.get( ClassUtils.getFullyQualifiedName( classType, true )) as ByteCodeType; 

			// Get the configuration bindings
			var bindings:Dictionary = _module.getBindings();
			
			// Setup a dependency array
			var depArray:Array = new Array();

			// Get the parameters
			var paramArray:Array = type.constructor.parameters;

			for each(var param:Parameter in paramArray)
			{
				var paramType:Class = param.type.clazz;
				var paramString:String  = ClassUtils.getFullyQualifiedName( paramType, true );
				if ( bindings[paramString] == null ) 
				{
					depArray.push( getInstance( paramType ) );
				}
				else 
				{
					depArray.push( getInstance( ClassUtils.forName(bindings[paramString] )) );
				}
			}
			// Create the new instances with deps and return it.
			return ClassUtils.newInstance( classType, depArray );
		}
		
		/**
		 * Scan all the classes and cache the results
		 * @private
		 * @param	loaderInfo (LoaderInfo) The root of the class
		 */
		private function scanClasses(loaderInfo:LoaderInfo):void
		{
			// Load the bytecode
			ByteCodeType.fromLoader(loaderInfo);
			
			// Get the cache
			var typeCache:TypeCache = ByteCodeType.getTypeProvider().getTypeCache();
			
			// Loop threw all the classes
			for each (var key:String in typeCache.getKeys() ) 
			{
				// Split the package names on dot
				var packageNameArray:Array = key.split(".");
				
				// Skip the extra classes
				if ( packageNameArray[1] == "as3commons" || packageNameArray[0] == "Main" || packageNameArray[0] == "avmplus" ) 
				{
					continue;
				}				
				
				// Store the class names
				_classNames[key] = key;

				// Get the cache
				var type:ByteCodeType = typeCache.get(key) as ByteCodeType; 

				// Get the singleton data
				var singletonArray:Array = type.getMetaData("Singleton");
				if ( singletonArray != null ) 
				{
					_singletonNames[key] = key;
				}
				
				// Get the component data
				var componentArray:Array = type.getMetaData("Component");
				for each(var metadata:MetaData in componentArray)
				{
					var arg:MetaDataArgument = metadata.getArgument("type");
					trace( "component " + arg.key + ": " + arg.value );
					_componentNames[arg.key] = arg.value;
				}
			}			
		}
	}
}