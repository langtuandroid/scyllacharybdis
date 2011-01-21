package 
{
	import com.scyllacharybdis.core.di.createInjector;
	import com.scyllacharybdis.core.di.Injector;
	import examples.di.CoreModule;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
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
			
			var injector:Injector = createInjector( new CoreModule(), this );
		}
	}
	
}