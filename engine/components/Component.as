package components 
{
	import core.BaseObject;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Component extends BaseObject 
	{
		/*
		 * Variables
		 */
		private var _owner:* = null;
		
		public function Component() 
		{
			
		}
		
		/****************************************/
		// Owner Methods
		/****************************************/
		
		/**
		 * Get the ownering Game Object
		 */
		public function get owner():* { return _owner; }

		/**
		 * Set the ownering Game Object
		 */
		public function set owner( value:* ):void { _owner = value; }
		
	}

}