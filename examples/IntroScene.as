package  
{
	import org.casalib.math.geom.Point3d;
	import core.SceneObject;
	import core.GameObject;
	import core.MemoryManager;
	import core.EventManager;
	import components.SoundComponent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class IntroScene extends SceneObject
	{
		private var _square:GameObject;
		private var _otherSquare:GameObject;
		
		/**
		 * Create the scene
		 */
		public override function awake():void 
		{
			trace("Starting IntroScene");
			_square = MemoryManager.instantiate( GameObject );
			_otherSquare = MemoryManager.instantiate( GameObject );
		}
		
		/**
		 * Start the scene
		 */
		public override function start():void
		{
			// Set the square
			_square.addComponent(SoundComponent);
			_square.addComponent(SquareScriptComponent, [EventManager]);
			_square.addComponent(SquareRenderComponent);
			
			// Set the square
			_otherSquare.addComponent(SquareScriptComponent, [EventManager]);
			_otherSquare.addComponent(OtherSquareRenderComponent);

			// Update the components
			_square.position = new Point3d( 50, 50, 11 );
			_square.rotate = 45;
			_otherSquare.position = new Point3d( 100, 100, 10 );
			_otherSquare.scale = new Point3d( 5, 5, 1 );			

			// Add the to the scene
			addToScene(_square);
			addToScene(_otherSquare);
		}
		
		/**
		 * Stop the scene
		 */
		public override function stop():void
		{
			// Add the to the scene
			removeFromScene(_square);
			removeFromScene(_otherSquare);
		}
		
		/**
		 * Destroy the scene
		 */
		public override function destroy():void
		{
			trace("Destroy IntroScene");
			MemoryManager.destroy( _square );
			MemoryManager.destroy( _otherSquare );
		}
	}
}