package examples.physics 
{
	import com.scyllacharybdis.components.CollisionComponent;
	import com.scyllacharybdis.components.RenderComponent;
	import com.scyllacharybdis.components.ScriptComponent;
	import com.scyllacharybdis.core.composite.GameObject;
	import com.scyllacharybdis.core.memory.allocate;
	import com.scyllacharybdis.graphics.scenegraph.SceneGraph;
	import com.scyllacharybdis.interfaces.IPhysicsComponent;
	import com.scyllacharybdis.interfaces.IRenderComponent;
	import com.scyllacharybdis.interfaces.IScriptComponent;
	import com.scyllacharybdis.objects.SceneObject;
	com.scyllacharybdis.components.CollisionComponent;
	
	/**
	 */
	public class PhysicsScene extends SceneObject
	{
		private var _sceneGraph:SceneGraph;
		public function PhysicsScene( sceneGraph:SceneGraph )
		{
			_sceneGraph = sceneGraph;
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
		public function show():void
		{
			var _test:GameObject = allocate(GameObject );
			_test.addComponent(RenderComponent, allocate(XMLPhysicsRenderComponent));
			_test.addComponent(ScriptComponent, allocate(SquareScriptComponent));
			_test.addComponent(CollisionComponent, allocate(GroundPhysicsComponent, _sceneGraph));
			
			var _ground:GameObject = allocate( GameObject );
			_ground.addComponent(RenderComponent, allocate(PhysicsRenderComponent));
			_ground.addComponent(ScriptComponent, allocate(SquareScriptComponent));
			_ground.addComponent(CollisionComponent, allocate(GroundPhysicsComponent, _sceneGraph));
					
			// Add the to the scene
			addToScene(_ground);
			
			for (var i:int = 1; i < 10; i++)
			{
				// Create a box
				var geom:GameObject = allocate(GameObject);
				geom.addComponent(RenderComponent, allocate(PhysicsRenderComponent));
				geom.addComponent(ScriptComponent, allocate(SquareScriptComponent));
				geom.addComponent(CollisionComponent, allocate(BoxPhysicsComponent, _sceneGraph));

				var x:int = Math.random() * 600 + 150;
				var y:int = Math.random() * 300;
				
				var width:Number = Math.random() * 30 + 15;
				var height:Number = Math.random() * 30 + 15;
		
				trace( geom.getComponent(RenderComponent) );
				var renderComp:PhysicsRenderComponent = geom.getComponent(RenderComponent) as PhysicsRenderComponent;
				var collitionComp:BoxPhysicsComponent = geom.getComponent(CollisionComponent) as BoxPhysicsComponent;
				trace( renderComp );
				trace( collitionComp );
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