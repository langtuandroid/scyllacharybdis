package physics 
{
	import com.scyllacharybdis.components.CollisionComponent;
	import com.scyllacharybdis.components.RenderComponent;
	import com.scyllacharybdis.core.memory.allocate;
	import com.scyllacharybdis.core.memory.MemoryManager;
	import com.scyllacharybdis.core.objects.GameObject;
	import com.scyllacharybdis.core.objects.SceneObject;
	import intro.SquareScriptComponent;
	
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
		}
		
		/**
		 * Start the scene
		 */
		public override function start():void
		{
			var _test:GameObject = allocate( GameObject );
			_test.addComponent(allocate(XMLPhysicsRenderComponent ));
			_test.addComponent(allocate(SquareScriptComponent));
			_test.addComponent(allocate(GroundPhysicsComponent));
			
			var _ground:GameObject = allocate( GameObject );
			_ground.addComponent(allocate(SquareScriptComponent));
			_ground.addComponent(allocate(PhysicsRenderComponent));
			_ground.addComponent(allocate(GroundPhysicsComponent));
					
			// Add the to the scene
			addToScene(_ground);
			
			for (var i:int = 1; i < 10; i++)
			{
				// Create a box
				var geom:GameObject = allocate( GameObject );
				geom.addComponent(allocate(SquareScriptComponent));
				geom.addComponent(allocate(PhysicsRenderComponent));
				geom.addComponent(allocate(BoxPhysicsComponent));

				var x:int = Math.random() * 600 + 150;
				var y:int = Math.random() * 300;
				
				var width:Number = Math.random() * 30 + 15;
				var height:Number = Math.random() * 30 + 15;

				var renderComp:PhysicsRenderComponent;
				var physicsComp:BoxPhysicsComponent;
				
				if (Math.random() < 0.5) 
				{
					renderComp = geom.getComponent(RenderComponent);
					physicsComp = geom.getComponent(CollisionComponent);
					renderComp.createBox(width, height);
					physicsComp.createBox(x, y, width, height);
				} 
				else
				{
					renderComp = geom.getComponent(RenderComponent);
					physicsComp = geom.getComponent(CollisionComponent);
					renderComp.createCircle(width);
					physicsComp.createCircle(x,y, width);
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