package com.scyllacharybdis.core.di
{
	import com.scyllacharybdis.core.di.AbstractModule;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * Create the injector
	 * @author 
	 */
	public function createInjector( module:AbstractModule, displayObject:DisplayObjectContainer ):Injector
	{
		return new Injector( module, displayObject );
	}
}