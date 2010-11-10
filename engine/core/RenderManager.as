package core 
{
	import flash.utils.Dictionary;
	import di.Dependencies;
	import di.Description;
	
	/**
	 */
	public class RenderManager extends BaseObject
	{
		/****************************************/
		// Dependency Injection calls
		/****************************************/

		/**
		 * Return the class description
		 */
		public static function get description():Description  
		{ 
			return new Description( RenderManager, Description.SINGLETON_OBJECT );
		}

		/**
		 * Return the class dependencies
		 */
		public static function get dependencies():Dependencies  
		{  
			return null;
		}

		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 */
		public override function set dependencies( dep:Dictionary ):void 
		{ 
		}
		
		/****************************************/
		// Overide function
		/****************************************/

		/****************************************/
		// Class specific
		/****************************************/			
	}
}