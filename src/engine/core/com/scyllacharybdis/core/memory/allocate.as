package com.scyllacharybdis.core.memory
{
	import com.scyllacharybdis.core.memory.pool.MemoryPool;
	
	public function allocate( type:Class, ... arg:*  ):*
	{
		var obj:* = MemoryPool.allocate( type, arg );
	}

}