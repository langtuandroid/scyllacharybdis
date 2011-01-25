package com.scyllacharybdis.core.di
{
	import com.scyllacharybdis.core.di.AbstractModule;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * Create the dependency injector.
	 * @param module (AbstractModule) The configuration for the injector.
	 * @param displayObject (DisplayObjectContainer) The main display object.
	 * @author 
	 */
	public function createInjector( module:AbstractModule, displayObject:DisplayObjectContainer ):Injector
	{
		return new Injector( module, displayObject );
	}
}