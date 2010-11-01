package  
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Daniel Lamb
	 */
	public class RenderComponent extends Component
	{
		protected var mMovieClip:MovieClip = null;
		protected var mPosition:Point = new Point( 0, 0 );
		protected var mSurface:DisplayObjectContainer = null;
		
		public override function get type():Number { return RENDER_COMPONENT; }
		
		public function set movieClip( value:MovieClip ):void 	{
																	if ( mMovieClip != null )
																	{
																		mSurface.removeChild( mMovieClip );
																	}
																	
																	mMovieClip = value;
																	mSurface.addChild( mMovieClip );
																}
																
		public function set position( value:Point ):void { mPosition = value; }
		
		public function RenderComponent( surface:DisplayObjectContainer ) 
		{
			mSurface = surface;
		}	
		
		// Render at the world position
		public function Render( position:Point ):void
		{
			mMovieClip.x = mPosition.x + position.x
			mMovieClip.y = mPosition.y + position.y;	
		}
	}
}