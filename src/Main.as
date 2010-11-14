package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
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
			
			var square1:SquareSceneObject = new SquareSceneObject( 400, 0x333333 );
			var square2:SquareSceneObject = new SquareSceneObject( 300, 0x666666 );
			var square3:SquareSceneObject = new SquareSceneObject( 200, 0x999999 );
			var square4:SquareSceneObject = new SquareSceneObject( 100, 0xBBBBBB );
			
			square3.addSceneChild( square4 );
			square2.addSceneChild( square3 );
			square1.addSceneChild( square2 );
			
			square1.render( this );
		}
	}
}