package core 
{
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Contacts.b2Contact;
	import components.ScriptComponent;
	import core.GameObject;
	import core.BaseObject

	/**
	 */
	public class PhysicsContactListener extends b2ContactListener
	{
		public override function BeginContact(contact:b2Contact):void 
		{
			super.BeginContact(contact);
			
			var obj1:b2Fixture = contact.GetFixtureA();
			var obj2:b2Fixture = contact.GetFixtureB();

			var gameObj1:GameObject = obj1.GetUserData();
			var gameObj2:GameObject = obj2.GetUserData();

			var script1:ScriptComponent = gameObj1.getComponent( BaseObject.SCRIPT_COMPONENT );
			var script2:ScriptComponent = gameObj2.getComponent( BaseObject.SCRIPT_COMPONENT );
			
			if ( script1 != null ) {
				script1.onBeginContact( gameObj2 );
			}
			
			if ( script2 != null ) {
				script2.onBeginContact( gameObj1 );
			}
		}
		
		public override function EndContact(contact:b2Contact):void 
		{
			super.EndContact(contact);
			var obj1:b2Fixture = contact.GetFixtureA();
			var obj2:b2Fixture = contact.GetFixtureB();

			var gameObj1:GameObject = obj1.GetUserData();
			var gameObj2:GameObject = obj2.GetUserData();

			var script1:ScriptComponent = gameObj1.getComponent( BaseObject.SCRIPT_COMPONENT );
			var script2:ScriptComponent = gameObj2.getComponent( BaseObject.SCRIPT_COMPONENT );
			
			if ( script1 != null ) {
				script1.onEndContact( gameObj2 );
			}
			
			if ( script2 != null ) {
				script2.onEndContact( gameObj1 );
			}

		}
	}
}