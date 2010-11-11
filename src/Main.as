package 
{
	import core.BaseObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	import core.MemoryManager;
	import core.GameObject;
	
	import components.TransformComponent;
	
	import examples.BoardRenderComponent;
	import examples.BoardScriptComponent;
	import examples.BoardNetworkComponent;
	
	
	/**
	 */
	public class Main extends Sprite 
	{
		var _memoryManager:MemoryManager;
		
		public function Main():void 
		{
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			_memoryManager = new MemoryManager();
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var base:BaseObject = _memoryManager.instantiate( BaseObject );
		}
		
		private function setupBoard():void
		{
			_memoryManager.instantiate(GameObject);
			
			GameObject.addComponent(TransformComponent);
			GameObject.addComponent(BoardRenderComponent);
			GameObject.addComponent(BoardScriptComponent);
			GameObject.addComponent(BoardNetworkComponent);
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