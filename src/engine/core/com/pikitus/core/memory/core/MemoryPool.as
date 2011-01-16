package sc.core.memory.core 
{
	import flash.utils.Dictionary;
	import org.as3commons.lang.ClassUtils;
	import org.as3commons.reflect.Parameter;
	import org.as3commons.reflect.Type;
	import sc.core.memory.constants.MemoryError;
	
	public class MemoryPool 
	{
		private static var _objectList:Dictionary = new Dictionary(true);
		private static var _singletonList:Dictionary = new Dictionary(true);
		
		public static function allocate(alctype:Class, arg:Array):*
		{
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
			_objectList[obj] = null;
			delete _objectList[obj];
		}
	}
}