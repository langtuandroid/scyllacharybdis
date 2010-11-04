package Engine 
{

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	/**
	 * 
	 */
	public class RenderComponent extends Component
	{
		protected var _baseclip:MovieClip = null;
		protected var _position:Point = new Point( 0, 0 );
		
		public override function get type():Number { return RENDER_COMPONENT; }
		
		public function set baseclip( value:MovieClip ):void { _baseclip = value; }									
		public function set position( value:Point ):void { _position = value; }
		
		public function render( surface:DisplayObjectContainer ):void
		{
			surface.addChild( _baseclip );
		}
		
		public function erase( surface:DisplayObjectContainer ):void
		{
			surface.removeChild( _baseclip );
		}
		
		// Hack 
		public function addMovieClip(): void 
		{
			_baseclip = new MovieClip();
			_baseclip.graphics.beginFill( color );
			_baseclip.graphics.drawRect( 0, 0, size, size );
			_baseclip.graphics.endFill();
			_baseclip.addEventListener( MouseEvent.MOUSE_DOWN, (scriptComponent as SquareScriptComponent).onMouseDown ); 

			// If the other way didn't work try this:
			mMovieClip.onMouseDown = function() 
			{
				var tempComp = this.GetGameObject().GetComponent(ScriptType);
				if (tempComp != null) {
					tempComp.OnMouseDown();
				}
			}
			
			mMovieClip.onMouseUp =  = function() 
			{
				var tempComp = this.GetGameObject().GetComponent(ScriptType);
				if (tempComp != null) {
					tempComp.OnMouseUp();
				}
			}
		}
		
		/**
		* Awake is called at the construction of the object
		*/
		public override function awake():void
		{
		}

		/**
		* Start is called when the object is added to the scene
		*/
		public override function start():void		
		{
		}

		/**
		* Stop is called when the object is removed from the scene
		*/
		public override function stop():void
		{
		}

		/**
		* Destroy is called at the removal of the object
		*/
		public override function destroy():void		
		{
		} 		

		/**
		 * Update each frame
		 */
		public override function update():void
		{
			_baseclip.x = _position.x;
			_baseclip.y = _position.y;	
		}
	}
}