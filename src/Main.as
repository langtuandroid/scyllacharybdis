package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Daniel Lamb
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var square:SceneObject = new SceneObject();
			var squareRenderable:RenderComponent = new RenderComponent( this );
			var squareClip:MovieClip = new MovieClip();
			squareClip.graphics.beginFill( 0x123456 );
			squareClip.graphics.drawRect( 0, 0, 200, 200 );
			squareClip.graphics.endFill();
			squareRenderable.movieClip = squareClip;
			
			square.AddComponent( squareRenderable );
			
			(square.GetComponent( Component.RENDER_COMPONENT ) as RenderComponent).Render( new Point( 0, 0 ));
		}
		
	}
	
}