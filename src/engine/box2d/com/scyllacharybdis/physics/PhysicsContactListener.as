package com.scyllacharybdis.physics 
{
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Contacts.b2Contact;
	import com.scyllacharybdis.components.ScriptComponent;
	import com.scyllacharybdis.interfaces.IScriptComponent;
	import com.scyllacharybdis.objects.GameObject;

	/**
	 */
	public final class PhysicsContactListener extends b2ContactListener
	{
		/**
		 * A colision has happened 
		 * @param	contact (b2Contact) The contact point
		 */
		public override function BeginContact(contact:b2Contact):void 
		{
			super.BeginContact(contact);
			
			var obj1:b2Fixture = contact.GetFixtureA();
			var obj2:b2Fixture = contact.GetFixtureB();

			var gameObj1:GameObject = obj1.GetUserData();
			var gameObj2:GameObject = obj2.GetUserData();

			var script1:Array = gameObj1.getComponent( IScriptComponent );
			var script2:Array = gameObj2.getComponent( IScriptComponent );
			
			for ( var i:int = 0; i < script1.length; i++ )
			{
				script1[i].onBeginContact( gameObj2 );
			}
			
			for ( i = 0; i < script1.length; i++ )
			{
				script2[i].onBeginContact( gameObj1 );
			}
		}
		
		/**
		 * A colision has stoped 
		 * @param	contact (b2Contact) The contact point
		 */
		public override function EndContact(contact:b2Contact):void 
		{
			super.EndContact(contact);
			var obj1:b2Fixture = contact.GetFixtureA();
			var obj2:b2Fixture = contact.GetFixtureB();

			var gameObj1:GameObject = obj1.GetUserData();
			var gameObj2:GameObject = obj2.GetUserData();

			var script1:Array = gameObj1.getComponent( IScriptComponent );
			var script2:Array = gameObj2.getComponent( IScriptComponent );
			
			for ( var i:int = 0; i < script1.length; i++ )
			{
				script1[i].onEndContact( gameObj2 );
			}
			
			for ( i = 0; i < script1.length; i++ )
			{
				script2[i].onEndContact( gameObj1 );
			}
		}
	}
}