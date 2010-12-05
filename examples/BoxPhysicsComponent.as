package  
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2BodyDef;
	import components.PhysicsComponent;
	
	/**
	 */
	public class BoxPhysicsComponent extends PhysicsComponent
	{
		/**
		 * The users constructor. 
		 * Override awake and create any variables and listeners.
		 */
		public override function awake():void
		{
		}
		
		/**
		 * The users start method. 
		 * Start runs when the game object is added to the scene.
		 */
		public override function start():void
		{
			// The example used meters instead of pixels
			var x:int = (Math.random() * 15 + 5) * _physicsWorld.drawScale;
			var y:int = (Math.random() * 10) * * _physicsWorld.drawScale;
			
			var bodyDef:b2BodyDef = createBodyDef( (x, y);

			var rX:Number = (Math.random() + 0.5) * _physicsWorld.drawScale;
			var rY:Number = (Math.random() + 0.5) * _physicsWorld.drawScale;			

			if (Math.random() < 0.5) 
			{
				var boxShape:b2PolygonShape = CreatePolygonShape(rX, rY, 1.0, 0.5, 0.2);
			} 
			else
			{
				var circleShape:b2CircleShape = createCircleShape(rX, 1.0, 0.5, 0.2);
			}
		}

		/**
		 * The users stop method.
		 * Stop runs when the game object is added to the scene.
		 */
		public override function stop():void
		{
		}

		/**
		 * The users destructor. 
		 * Override destroy to clean up any variables or listeners.
		 */
		public override function destroy():void
		{
		}	
	}
}