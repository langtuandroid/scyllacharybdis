package com.scyllacharybdis.core.memory.pool 
{
	import com.scyllacharybdis.constants.MemoryError;
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import org.as3commons.bytecode.reflect.ByteCodeType;
	import org.as3commons.lang.ClassUtils;
	import org.as3commons.reflect.Parameter;
	import org.as3commons.reflect.Type;
	//import flash.display.DisplayObject.loaderInfo;
	
	public class MemoryPool 
	{
		// At the end check how many objects have only one reference. They were never deleted.
		private static var _objectList:Dictionary = new Dictionary(false);
		private static var _singletonList:Dictionary = new Dictionary(true);
		private static var _initialized:Boolean = false;
		
		private static function initialize():void
		{
			if ( _initialized ) 
			{
				return;
			}
			scanClasses();
		}
		
		public static function allocate(alctype:Class, arg:Array):*
		{
			// Initialize the memory manager
			initialize();
			
			// Get the class information
			var type:Type;
			try
			{
				type = Type.forClass(alctype);
			} 
			catch ( typeError:Error )
			{
				trace( typeError.message );
			}
			
			// Check how many parameters are optional
			var minParam:int = 0;
			for each ( var param:Parameter in type.constructor.parameters) 
			{
				if ( ! param.isOptional )
				{
					minParam++;
				}
			}
			
			var maxParam:int = type.constructor.parameters.length;
			// Check to make sure we have all the parameters
			if ( arg.length < minParam || arg.length > maxParam ) 
			{
				throw new Error("Parameters don't match", MemoryError.PARAM_ERROR);
			}
			
			// Check to see if is a singleton
			if (type.getMetaData("Singleton"))
			{
				if ( _singletonList[type] != null )
				{
					throw new Error("Trying to allocate a singleton twice", MemoryError.SINGLETON_ERROR);
				}
				_singletonList[type] = type;
			}
			
			// Allocated the object
			try 
			{
				var newObj:* = ClassUtils.newInstance( alctype, arg );
				if ( !type.getMetaData("Singleton") )
				{
					_objectList[newObj] = newObj;
				}
				return newObj;
			}
			catch ( alcError:Error )
			{
				trace( alcError.message );
			}
		}
		
		public static function destroy( obj:* ):void
		{
			// Initialize the memory manager
			initialize();

			//
			_objectList[obj] = null;
			delete _objectList[obj];
		}
		
		public static function scanClasses():void
		{
		}
	}
}