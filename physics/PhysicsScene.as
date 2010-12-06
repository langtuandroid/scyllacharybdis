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
		private var boxes:Array = new Array();
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
				var geom:GameObject = MemoryManager.instantiate( GameObject );
				geom.addComponent(SquareScriptComponent, [EventManager]);
				geom.addComponent(PhysicsRenderComponent);
				geom.addComponent(BoxPhysicsComponent, [PhysicsWorld]);

				var x:int = Math.random() * 600 + 150;
				var y:int = Math.random() * 300;
				
				var width:Number = Math.random() * 30 + 15;
				var height:Number = Math.random() * 30 + 15;

			
				if (Math.random() < 0.5) 
				{
					geom.getComponent(BaseObject.RENDER_COMPONENT).createBox(width, height);
					geom.getComponent(BaseObject.PHYSICS_COMPONENT).createBox(x, y, width, height);
				} 
				else
				{
					geom.getComponent(BaseObject.RENDER_COMPONENT).createCircle(width);
					geom.getComponent(BaseObject.PHYSICS_COMPONENT).createCircle(x,y, width);
				}
			
				// Add the to the scene
				addToScene( geom );
				boxes.push( geom );
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