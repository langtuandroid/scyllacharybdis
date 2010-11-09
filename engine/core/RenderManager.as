package core 
{
	/**
	 * ...
	 * @author ...
	 */
	public class RenderManager 
	{
		public function RenderManager() 
		{
			/****************************************/
			// Dependency Injection calls
			/****************************************/

			/**
			 * Return the class description
			 */
			public static function get description():Description  
			{ 
				return new Description( getQualifiedClassName(this), SINGLETON_OBJECT );
			}

			/**
			 * Return the class dependencies
			 */
			public static function get dependencies():Dependencies  
			{  
			}

			/**
			 * Set the dependencies
			 * @param dep (Dictionary) Key = Class and Value is the object
			 */
			public function set dependencies( dep:Dictionary ):void 
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
}