package core 
{
	/**
	 */
	public class SceneObject extends BaseObject
	{
		protected var _initialized:Boolean = false;
		
		/**
		 * Initialize the scene memory
		 */
		public override function engine_awake():void
		{
			if ( _initialized ) 
			{
				return;
			}
			
			_initialized = true;
			super.awake();
		}


		/**
		 * Animate the scene coming into the frame
		 */
		public function show():void
		{
		}

		/**
		 * Animate the scene leaving the screen
		 */
		public function hide():void
		{
		}

		/**
		 * Destroy the scene memory
		 */
		public override function engine_destroy():void
		{
			super.destroy();
			
			_initialized = false;
		}
	}
}