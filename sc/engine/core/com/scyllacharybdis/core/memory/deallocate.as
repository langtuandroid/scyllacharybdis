package com.scyllacharybdis.core.memory 
{
	import com.scyllacharybdis.core.memory.pool.MemoryPool;
	import com.scyllacharybdis.interfaces.IBaseObject;

	public function deallocate( obj:* ):void
	{
		if ( obj is IBaseObject )
		{
			obj.destroy();
		}		

		MemoryPool.destroy( obj );
	}
}