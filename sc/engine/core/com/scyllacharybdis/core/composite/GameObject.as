package com.scyllacharybdis.core.composite 
{
	import com.scyllacharybdis.components.TranformComponent;
	import com.scyllacharybdis.interfaces.ITranformComponent;
	
	/**
	 */
	public final class GameObject extends CompositeObject
	{
		/****************************************/
		// Class Details
		/****************************************/
		private var _enabled:Boolean = true;
		private var _tranform:ITranformComponent = new TranformComponent();

		/**
		 * Constructor
		 */
		public function GameObject():void
		{
		}
		
		public function start():void 
		{
			awakeComponents();
		}
		
		public function destroy():void 
		{
			destroyComponents();
			_tranform = null;
		}
		
		/**
		 * Is the object enabled
		 */
		public function get enabled():Boolean { return _enabled; }
		
		/**
		 * Set if the object is enabled or not
		 * @param value (Boolean) Enabled
		 */
		public function set enabled( value:Boolean ):void 
		{
			_enabled = value;
		}

		/**
		 * Get the tranform component
		 */
		public function get tranform():ITranformComponent { return _tranform; }
	}
}