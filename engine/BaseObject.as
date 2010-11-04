package Engine 
{
	public static const GAME_OBJECT:Number = 1;
	public static const RENDER_COMPONENT:Number = 2;
	public static const SCRIPT_COMPONENT:Number = 3;	
	
	/**
	 * BaseObject is a base object for all game elements
	 */
	class BaseObject 
	{
		public BaseObject()
		{
			trace("To create an object use Instantiate(Class)");
		}
		
		/**
		* Awake is called at the construction of the object
		*/
		public function awake():void
		{
		}

		/**
		* Start is called when the object is added to the scene
		*/
		public function start():void		
		{
		}

		/**
		* Stop is called when the object is removed from the scene
		*/
		public function stop():void
		{
		}

		/**
		* Destroy is called at the removal of the object
		*/
		public function destroy():void		
		{
		} 
		
		/**
		 * Update each frame
		 */
		public function update():void
		{
		}
		
		/** 
		 * Return the type of object
		 */
		public function get type():Number { return 0; }
	}
}