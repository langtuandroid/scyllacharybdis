package physics 
{
	import com.scyllacharybdis.components.CollisionComponent;
	import com.scyllacharybdis.components.RenderComponent;
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
			var _test:GameObject = MemoryManager.instantiate( GameObject );
			_test.addComponent(XMLPhysicsRenderComponent);
			_test.addComponent(SquareScriptComponent);
			_test.addComponent(GroundPhysicsComponent);
			
			var _ground:GameObject = MemoryManager.instantiate( GameObject );
			_ground.addComponent(SquareScriptComponent);
			_ground.addComponent(PhysicsRenderComponent);
			_ground.addComponent(GroundPhysicsComponent);
					
			// Add the to the scene
			addToScene(_ground);
			
			for (var i:int = 1; i < 10; i++)
			{
				// Create a box
				var geom:GameObject = MemoryManager.instantiate( GameObject );
				geom.addComponent(SquareScriptComponent);
				geom.addComponent(PhysicsRenderComponent);
				geom.addComponent(BoxPhysicsComponent);

				var x:int = Math.random() * 600 + 150;
				var y:int = Math.random() * 300;
				
				var width:Number = Math.random() * 30 + 15;
				var height:Number = Math.random() * 30 + 15;

			
				if (Math.random() < 0.5) 
				{
					geom.getComponent(RenderComponent).createBox(width, height);
					geom.getComponent(CollisionComponent).createBox(x, y, width, height);
				} 
				else
				{
					geom.getComponent(RenderComponent).createCircle(width);
					geom.getComponent(CollisionComponent).createCircle(x,y, width);
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