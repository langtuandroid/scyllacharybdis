package com.scyllacharybdis.core.di
{
	import com.scyllacharybdis.core.di.Injector;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author 
	 */
	[Component (type="AbstractModuleTypeTHing")]
	public class AbstractModule 
	{
		private var _binding:Dictionary = new Dictionary();
		
		public function configure( ):void
		{
		}
		
		public final function getBindings():Dictionary
		{
			return _binding;
		}
		
		protected final function bind( from:Class, to:Class ):void
		{
			_binding[from] = to;
		}
	}
}