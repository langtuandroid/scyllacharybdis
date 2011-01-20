package com.scyllacharybdis.core.memory
{
	import com.scyllacharybdis.core.memory.pool.MemoryPool;
	
	public function allocate( type:Class, ... arg:*  ):*
	{
		return MemoryPool.allocate( type, arg );
	}

}