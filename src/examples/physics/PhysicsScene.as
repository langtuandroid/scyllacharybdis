package examples.physics 
{
	import com.scyllacharybdis.components.CollisionComponent;
	import com.scyllacharybdis.components.RenderComponent;
	import com.scyllacharybdis.core.composite.GameObject;
	import com.scyllacharybdis.core.memory.allocate;
	import com.scyllacharybdis.graphics.scenegraph.SceneGraph;
	import com.scyllacharybdis.interfaces.IPhysicsComponent;
	import com.scyllacharybdis.interfaces.IRenderComponent;
	import com.scyllacharybdis.interfaces.IScriptComponent;
	import com.scyllacharybdis.objects.SceneObject;
	
	/**
	 */
	public class PhysicsScene extends SceneObject
	{
		
		public function PhysicsScene( sceneGraph:SceneGraph )
		{
			super(sceneGraph);
		}
		
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
			_test.addComponent(IRenderComponent, allocate(XMLPhysicsRenderComponent));
			_test.addComponent(IScriptComponent, allocate(SquareScriptComponent));
			_test.addComponent(IPhysicsComponent, allocate(GroundPhysicsComponent));
			
			var _ground:GameObject = allocate( GameObject );
			_ground.addComponent(IScriptComponent, allocate(SquareScriptComponent));
			_ground.addComponent(IRenderComponent, allocate(PhysicsRenderComponent));
			_ground.addComponent(IPhysicsComponent, allocate(GroundPhysicsComponent));
					
			// Add the to the scene
			addToScene(_ground);
			
			for (var i:int = 1; i < 10; i++)
			{
				// Create a box
				var geom:GameObject = allocate(GameObject );
				geom.addComponent(IRenderComponent, allocate(SquareScriptComponent));
				geom.addComponent(IScriptComponent, allocate(PhysicsRenderComponent));
				geom.addComponent(IPhysicsComponent, allocate(BoxPhysicsComponent));

				var x:int = Math.random() * 600 + 150;
				var y:int = Math.random() * 300;
				
				var width:Number = Math.random() * 30 + 15;
				var height:Number = Math.random() * 30 + 15;
		
				var renderComp:PhysicsRenderComponent = geom.getComponent(RenderComponent) as PhysicsRenderComponent;
				var collitionComp:BoxPhysicsComponent = geom.getComponent(CollisionComponent) as BoxPhysicsComponent;
				if (Math.random() < 0.5) 
				{
					renderComp.createBox(width, height);
					collitionComp.createBox(x, y, width, height);
				} 
				else
				{
					renderComp.createCircle(width);
					collitionComp.createCircle(x,y, width);
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