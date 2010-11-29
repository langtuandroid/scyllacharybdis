package chess 
{
	import components.RenderComponent;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class BlackKnightRenderComponent extends RenderComponent 
	{
		private var _loader:Loader = new Loader();
		
		public function BlackKnightRenderComponent() 
		{
			_baseclip = new MovieClip();
			_loader.addEventListener( Event.COMPLETE, onComplete, false, 0, true );
			_loader.load( new URLRequest( "../examples/chess/assets/bk.png" ));
			_baseclip.addChild(_loader);
		}
		
		private function onComplete( e:Event ):void
		{
			trace("COMPLETE");
		}
	}

}