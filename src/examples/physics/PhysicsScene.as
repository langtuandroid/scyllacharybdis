package examples.physics 
{
	import com.scyllacharybdis.core.composite.GameObject;
	import com.scyllacharybdis.core.memory.allocate;
	import com.scyllacharybdis.interfaces.IPhysicsComponent;
	import com.scyllacharybdis.interfaces.IRenderComponent;
	import com.scyllacharybdis.interfaces.IScriptComponent;
	import com.scyllacharybdis.objects.SceneObject;
	import examples.intro.SquareScriptComponent;
	
	/**
	 */
	public class PhysicsScene extends SceneObject
	{
		private var boxes:Array = new Array();
		
		/**
		 * Create the scene
		 */
		public function awake():void 
		{
		}
		
		/**
		 * Start the scene
		 */
		public function start():void
		{
			var _test:GameObject = allocate(GameObject );
			_test.addComponent(IRenderComponent, XMLPhysicsRenderComponent);
			_test.addComponent(IScriptComponent, SquareScriptComponent);
			_test.addComponent(IPhysicsComponent, GroundPhysicsComponent);
			
			var _ground:GameObject = allocate( GameObject );
			_ground.addComponent(SquareScriptComponent);
			_ground.addComponent(PhysicsRenderComponent);
			_ground.addComponent(GroundPhysicsComponent);
					
			// Add the to the scene
			addToScene(_ground);
			
			for (var i:int = 1; i < 10; i++)
			{
				// Create a box
				var geom:GameObject = allocate(GameObject );
				geom.addComponent(IRenderComponent, SquareScriptComponent);
				geom.addComponent(IScriptComponent, PhysicsRenderComponent);
				geom.addComponent(IPhysicsComponent, BoxPhysicsComponent);

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
		 * Destroy the scene
		 */
		public override function destroy():void
		{
		}
	}
}