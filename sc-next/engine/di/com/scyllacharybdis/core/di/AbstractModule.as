package com.scyllacharybdis.core.di
{
	import com.scyllacharybdis.core.di.Injector;
	import flash.utils.Dictionary;
	
	/**
	 * Abstract Module is a baseclass for configuring the injector.
	 * Override the configure to define bindings. 
	 * @author 
	 */
	public class AbstractModule 
	{
		// A list of all mappings
		private var _binding:Dictionary = new Dictionary();
		
		/**
		 * Configure the class bindings.
		 */
		public function configure( ):void
		{
		}

		/**
		 * Bind a requested class to a implemenation class.
		 * @param	from (Class) The requested class.
		 * @param	to (Class) The used class.
		 */
		protected final function bind( from:Class, to:Class ):void
		{
			_binding[from] = to;
		}

		/**
		 * Returns the list of bindings to the injector.
		 * @private
		 * @return
		 */
		public final function getBindings():Dictionary
		{
			return _binding;
		}
		
	}
}