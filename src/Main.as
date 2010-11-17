package 
{
	import core.BaseObject;
	import core.Renderer;
	import core.NetworkManager;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.casalib.math.geom.Point3d;
	
	import core.GameObject;
	import core.MemoryManager;
	
	import components.TransformComponent;

	
	/**
	 */
	public class Main extends Sprite 
	{
		private var _renderer:Renderer;
		private var _networkManager:NetworkManager;
		
		private var _square:GameObject;
		private var _otherSquare:GameObject;
		
		public function Main():void 
		{
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
			//_memoryManager.instantiate(TestMaterialLoader);
			//_memoryManager.instantiate(TestSceneLoader);
			
			//var board:GameObject = _memoryManager.instantiate(GameObject);
			//board.addComponent(BoardRenderComponent);
			//board.addComponent(BoardScriptComponent);
			//board.addComponent(BoardNetworkComponent);
			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_renderer = MemoryManager.instantiate(Renderer, Renderer.dependencies);
		
			_square = MemoryManager.instantiate( GameObject, GameObject.dependencies.concat([SquareScriptComponent, SquareRenderComponent, TransformComponent, BoardNetworkComponent ]) );
			
			_square.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( 50, 50, 1 );
			_square.getComponent( BaseObject.TRANSFORM_COMPONENT ).rotate = 45;
			
			_otherSquare = MemoryManager.instantiate( GameObject, GameObject.dependencies.concat([SquareScriptComponent, OtherSquareRenderComponent, TransformComponent]) );
			_otherSquare.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( 100, 100, 0 );
	
			_square.enabled = true;
			_otherSquare.enabled = true;
			
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function onEnterFrame( e:Event ):void
		{
			_renderer.render(this);
		}
	}
}