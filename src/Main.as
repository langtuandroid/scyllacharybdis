package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import engine.di.DependencyInjector;
	import engine.core.MemoryManager;
	
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
			
			zTest();
			
			registerDependencies();
		}
		
		private function registerDependencies():void
		{
			var injector:DependencyInjector = new DependencyInjector();
			var memory:MemoryManager  = new MemoryManager(injector);
			
		}
		
		private function squaretest():void
		{
		}
		
		private function zTest():void
		{
			var square1:MovieClip = new MovieClip();
			var square2:MovieClip = new MovieClip();
			
			square1.graphics.beginFill( 0x333333 );
			square1.graphics.drawRect( 0, 0, 250, 250 );
			square1.graphics.endFill();
			
			square1.x = 0;
			square1.y = 0;
			square1.z = 0;
			
			square2.graphics.beginFill( 0x999999 );
			square2.graphics.drawRect( 0, 0, 500, 500 );
			square2.graphics.endFill();
			
			square2.x = 0;
			square2.y = 0;
			square2.z = 5;
			
			this.addChild(square2);
			this.addChild(square1);
			
			
		}
	}
}