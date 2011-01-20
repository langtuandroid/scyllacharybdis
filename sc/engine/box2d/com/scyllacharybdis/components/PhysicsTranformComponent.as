package com.scyllacharybdis.components 
{
	import Box2D.Common.Math.b2Vec2;
	import com.scyllacharybdis.core.composite.GameObject;
	import com.scyllacharybdis.interfaces.ITranformComponent;
	import org.casalib.math.geom.Point3d;
	
	/**
	 * ...
	 * @author 
	 */
	public class PhysicsTranformComponent implements ITranformComponent
	{
		private var _position:Point3d = new Point3d();
		private var _scale:Point3d = new Point3d();
		private var _rotation:Number = 0;
		private var _owner:GameObject;
		
		public function awake( owner:* ):void
		{
			_owner = owner;
		}
		
		public function update():void 
		{
		}
		
		public function destroy():void 
		{
		}
		
		/**
		 * Get the local coordinates position.
		 */
		public function get position():Point3d 
		{
			if ( _owner == null ) 
			{
				return new Point3d(0, 0, 0);
				trace("GOT HERE");
			}
			var collision:CollisionComponent = _owner.getComponent( CollisionComponent ) as CollisionComponent;
			if ( collision != null ) {
				_position.x = collision.body.GetPosition().x;
				_position.y = collision.body.GetPosition().y;
			}
			return _position;
		}

		/**
		 * Set the local coordinates position
		 * @param position (Point3d) The position to set the game object
		 */
		public function set position( value:Point3d ):void 
		{ 
			_position = value; 

			var collision:CollisionComponent = _owner.getComponent( CollisionComponent ) as CollisionComponent;
			if ( collision != null ) {
				collision.body.SetPosition( new b2Vec2( _position.x, _position.y ) );
			}
		}
		
		/**
		 * Get the renderobjects local coordinates scale.
		 */
		public function get scale():Point3d 
		{ 
			return _scale;
		}

		/**
		 * Set the renderobjects local coordinates scale.
		 */
		public function set scale( value:Point3d ):void 
		{ 
			_scale = value; 
		}
		
		/**
		 * Get the local coordinates rotation
		 */		
		public function get rotation():Number 
		{ 
			var collision:CollisionComponent = _owner.getComponent( CollisionComponent ) as CollisionComponent;
			if ( collision != null ) {
				_rotation = collision.body.GetAngle() * ( 180/Math.PI );
			}
			return _rotation;
		}
		
		/**
		 * Set the local coordinates rotation
		 */
		public function set rotation( value:Number ):void 
		{ 
			_rotation = value; 
			var collision:CollisionComponent = _owner.getComponent( CollisionComponent ) as CollisionComponent;
			if ( collision != null ) {
				collision.body.SetAngle( value * ( Math.PI / 180 ) );
			}
		}		
	}
}