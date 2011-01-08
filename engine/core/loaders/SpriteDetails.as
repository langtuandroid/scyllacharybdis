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
		
		public function set renderer(value:RenderDetails):void 
		{
			_renderer = value;
		}
		
		public function get physics():PhysicsDetails { return _physics; }
		
		public function set physics(value:PhysicsDetails):void 
		{
			_physics = value;
		}
		
		public function get complete():Boolean { return _complete; }
		
		public function set complete(value:Boolean):void 
		{
			_complete = value;
		}
		
		/**
		 * Parse the xml file
		 * @param	spritesheet
		 */
		private function parseXML(spritesheet:XML):void
		{
			//parseTexture( spritesheet..texture );
			//parseAreas( spritesheet..areas );
			//parseBodies( spritesheet..bodies );
		}		
	}
}