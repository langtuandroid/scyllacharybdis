package  
{
	import org.casalib.math.geom.Point3d;
	import core.BaseObject;
	import core.PhysicsWorld;
	import core.SceneObject;
	import core.GameObject;
	import core.MemoryManager;
	import core.EventManager;
	
	/**
	 */
	public class PhysicsScene extends SceneObject
	{
		/**
		 * Create the scene
		 */
		public override function awake():void 
		{
			trace("Starting PhysicsScene");
		}
		
		/**
		 * Start the scene
		 */
		public override function start():void
		{
			var _ground:GameObject = MemoryManager.instantiate( GameObject );
			_ground.addComponent(SquareScriptComponent, [EventManager]);
			_ground.addComponent(PhysicsRenderComponent);
			_ground.addComponent(GroundPhysicsComponent, [PhysicsWorld]);

			// Add the to the scene
			addToScene(_ground);
			
			for (var i:int = 1; i < 10; i++)
			{
				// Create a box
				var _geom:GameObject = MemoryManager.instantiate( GameObject );
				_geom.addComponent(SquareScriptComponent, [EventManager]);
				_geom.addComponent(PhysicsRenderComponent);
				_geom.addComponent(BoxPhysicsComponent, [PhysicsWorld]);

				var x:int = Math.random() * 600 + 150;
				var y:int = Math.random() * 300;
				
				var rX:Number = Math.random() * 30 + 15;
				var rY:Number = Math.random() * 30 + 15;

			
				if (Math.random() < 0.5) 
				{
					_geom.getComponent(BaseObject.RENDER_COMPONENT).createBox(rX, rY);
					_geom.getComponent(BaseObject.PHYSICS_COMPONENT).createBox(rX, rY);
					_geom.worldPosition = new Point3d( x, y, 1 );
				} 
				else
				{
					_geom.getComponent(BaseObject.RENDER_COMPONENT).createCircle(rX);
					_geom.getComponent(BaseObject.PHYSICS_COMPONENT).createCircle(rX);
					_geom.worldPosition = new Point3d( x, y, 1 );
				}
			
				// Add the to the scene
				addToScene(_geom);
			}
		}
		
		/**
		 * Stop the scene
		 */
		public override function stop():void
		{
		}
		
		/**
		 * Destroy the scene
		 */
		public override function destroy():void
		{
		}
	}
}