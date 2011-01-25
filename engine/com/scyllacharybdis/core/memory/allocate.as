package com.scyllacharybdis.core.memory 
{
	import com.scyllacharybdis.core.memory.MemoryManager; 
	/**
	 * ...
	 * @author 
	 */
	public function allocate(type:Class, owner:Object=null):*
	{
		return MemoryManager.instantiate(type, owner);
	}
}