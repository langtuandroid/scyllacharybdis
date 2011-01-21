package 
{
	import com.scyllacharybdis.core.di.createInjector;
	import com.scyllacharybdis.core.di.Injector;
	import examples.di.TestClass;
	import examples.di.CoreModule;
	import examples.di.TestClass1;
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
			
			var test:TestClass1 = new TestClass1();
			new TestClass(test);
			
			// Create the injector
			var injector:Injector = createInjector( new CoreModule(), this );
			var test1:TestClass = injector.getInstance(TestClass);
			
			/*
			* Now that we've got the injector, we can build objects.
			*/
			//RealBillingService billingService = injector.getInstance(RealBillingService.class);
		}
	}
	
}