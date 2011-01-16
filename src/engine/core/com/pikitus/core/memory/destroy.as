package sc.core.memory 
{
	import sc.core.memory.core.MemoryPool;
	import sc.core.memory.interfaces.IEngineObject;
	import sc.core.memory.interfaces.IBaseObject;
	
	public function destroy( obj:* ):void
	{
		if ( obj is IBaseObject )
		{
			obj.destroy();
		}		

		if ( obj is IEngineObject )
		{
			obj.engine_destroy();
		}

		MemoryPool.destroy( obj );
	}
}