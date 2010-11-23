package core 
{
	/**
	 */
	public class SceneObject extends BaseObject
	{
		protected var _initialized:Boolean = false;
		protected var _showing:Boolean = false;

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

		public function engine_show():void
		{
			if ( _showing == true ) {
				return;
			}
			
			_showing = true;
			show();
		}


		public function engine_hide():void
		{
			if ( _showing == false ) {
				return;
			}
			_showing = false;
			hide();
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