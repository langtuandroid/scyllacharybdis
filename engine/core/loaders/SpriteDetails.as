package core.loaders 
{
	/**
	 * ...
	 * @author 
	 */
	public class SpriteDetails 
	{
		private var _renderer:RenderDetails;
		private var _physics:PhysicsDetails;
		private var _complete:Boolean = false;
		
		public function get renderer():RenderDetails { return _renderer; }
		
		public function get physics():PhysicsDetails { return _physics; }

		public function get complete():Boolean { return _complete; }
		
		
		/**
		 * Parse the xml file
		 * @param	spritesheet
		 */
		public function parseXML(spritesheet:XML):void
		{
			if ( spritesheet..material != null ) 
			{
				_renderer = new RenderDetails();
				_renderer.parseTexture( spritesheet..material );
				_renderer.parseAreas( spritesheet..material );
			}
			if ( spritesheet..physics != null ) 
			{
				_physics = new PhysicsDetails();
				_physics.parseBodies( spritesheet..physics );
			}
			
			_complete = true;
		}		
	}
}