package components 
{
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	import core.BaseObject;
	import core.EventManager;

	/**
	 */
	public class PhysicsComponent extends BaseObject
	{
		var body:b2Body;
		var bodyDef:b2BodyDef;
		var boxShape:b2PolygonShape;
		var circleShape:b2CircleShape;
			
		/****************************************/
		// Type definition
		/****************************************/
		public override final function getType():String 
		{
			return PHYSICS_COMPONENT; 
		}		
		
		/****************************************/
		// Class Details
		/****************************************/
		

		public final override function engine_awake():void
		{
			super.engine_awake();
		}

		
		public final override function engine_start():void
		{
			// Add ground body
			bodyDef = new b2BodyDef();
			//bodyDef.position.Set(15, 19);
			bodyDef.position.Set(10, 12);
			//bodyDef.angle = 0.1;
			boxShape = new b2PolygonShape();
			boxShape.SetAsBox(30, 3);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = boxShape;
			fixtureDef.friction = 0.3;
			fixtureDef.density = 0; // static bodies require zero density
			// Add sprite to body userData
			bodyDef.userData = new PhysGround();
			bodyDef.userData.width = 30 * 2 * 30; 
			bodyDef.userData.height = 30 * 2 * 3; 
			addChild(bodyDef.userData);
			body = m_world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			// Add some objects
			for (var i:int = 1; i < 10; i++){
				bodyDef = new b2BodyDef();
				bodyDef.position.x = Math.random() * 15 + 5;
				bodyDef.position.y = Math.random() * 10;
				var rX:Number = Math.random() + 0.5;
				var rY:Number = Math.random() + 0.5;
				// Box
				if (Math.random() < 0.5){
					boxShape = new b2PolygonShape();
					boxShape.SetAsBox(rX, rY);
					fixtureDef.shape = boxShape;
					fixtureDef.density = 1.0;
					fixtureDef.friction = 0.5;
					fixtureDef.restitution = 0.2;
					bodyDef.userData = new PhysBox();
					bodyDef.userData.width = rX * 2 * 30; 
					bodyDef.userData.height = rY * 2 * 30; 
					body = m_world.CreateBody(bodyDef);
					body.CreateFixture(fixtureDef);
				} 
				// Circle
				else {
					circleShape = new b2CircleShape(rX);
					fixtureDef.shape = circleShape;
					fixtureDef.density = 1.0;
					fixtureDef.friction = 0.5;
					fixtureDef.restitution = 0.2;
					bodyDef.userData = new PhysCircle();
					bodyDef.userData.width = rX * 2 * 30; 
					bodyDef.userData.height = rX * 2 * 30; 
					body = m_world.CreateBody(bodyDef);
					body.CreateFixture(fixtureDef);
				}
				addChild(bodyDef.userData);
			}
			
			super.engine_start();
		}

		public final override function engine_stop():void
		{
			super.engine_stop();
		}

		public final override function engine_destroy():void
		{

			super.engine_destroy();

			// Stop the timer
			_updateTimer.stop();
			_updateTimer = null;

		}

		/*
		 * Handler mouse down 
		 */
		public function onMouseDown( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler mouse up
		 */
		public function onMouseUp( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler click
		 */
		public function onClick( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler double click
		 */
		public function onDoubleClick( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler mouse move
		 */
		public function onMouseMove( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler mouse lost focus
		 */
		public function onMouseOut( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler mouse over
		 */
		public function onMouseOver( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler wheel mouse
		 */
		public function onMouseWheel( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler roll over
		 */
		public function onRollOver( e:MouseEvent ):void
		{
			
		}

		/*
		 * Handler roll out (Whatever that is)
		 */
		public function onRollOut( e:MouseEvent ):void
		{
			
		}
		
		/*
		 * Handler key down
		 */
		public function onKeyDown( e:KeyboardEvent ):void
		{
			
		}
		
		/*
		 * Handler key up
		 */
		public function onKeyUp( e:KeyboardEvent ):void
		{
			
		}
	}
}