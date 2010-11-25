package  
{
	import org.casalib.math.geom.Point3d;
	import core.SceneObject;
	import core.GameObject;
	import core.MemoryManager;
	import core.EventManager;
	import components.TransformComponent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class IntroScene extends SceneObject
	{
		private var _square:GameObject;
		private var _otherSquare:GameObject;
		
		public override function awake():void 
		{
			trace("Starting IntroScene");
			_square = MemoryManager.instantiate( GameObject, GameObject.dependencies);
			_otherSquare = MemoryManager.instantiate( GameObject, GameObject.dependencies );
		}
		
		public override function show():void
		{
			// Set the square
			_square.addComponent(SquareScriptComponent, [EventManager]);
			_square.addComponent(SquareRenderComponent);
			_square.addComponent(TransformComponent);
			
			// Set the square
			_otherSquare.addComponent(SquareScriptComponent, [EventManager]);
			_otherSquare.addComponent(OtherSquareRenderComponent);
			_otherSquare.addComponent(TransformComponent);

			// Disable the sqares
			_square.enabled = true;
			_otherSquare.enabled = true;

			// Update the components
			_square.position = new Point3d( 50, 50, 11 );
			_square.rotate = 45;
			_otherSquare.position = new Point3d( 100, 100, 10 );
			_otherSquare.scale = new Point3d( 5, 5, 1 );			trace("Show the IntroScene");
		}
		
		public override function hide():void
		{
			trace("Hide the IntroScene");
		}
		
		public override function destroy():void
		{
			trace("Stoping IntroScene");
		}
	}
}