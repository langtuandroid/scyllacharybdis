package sc.core.memory
{
	import sc.core.memory.core.MemoryPool;
	import sc.core.memory.interfaces.IEngineObject;
	import sc.core.memory.interfaces.IBaseObject;
	
	public function allocate( type:Class, ... arg:*  ):*
	{
		var obj:* = MemoryPool.allocate( type, arg );

		if ( obj is IEngineObject )
		{
			obj.engine_awake();
		}
		
		if ( obj is IBaseObject )
		{
			obj.awake();
		}
	}

}