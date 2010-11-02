package  
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Daniel Lamb
	 */
	public class SceneObject
	{
		private static var _sObjectCount:int = 0;
		
		private var _name:String = null;
		private var _parent:SceneObject = null;
		private var _children:Array = new Array();
		private var _components:Array = new Array();
		private var _position:Point = new Point( 0.0, 0.0 );
		private var _worldPosition:Point = new Point( 0.0, 0.0 );
		private var _disabled:Boolean = false;
		
		public function get name():String { return _name; }
		public function get parent():SceneObject { return _parent; }
		public function get postion():Point { return _position; }
		public function get worldPosition():Point { return _worldPosition; }
		
		public function set parent( value:SceneObject ):void { _parent = value; }
		public function set position ( value:Point ):void 	{ 
																// Set the local position
																_position.x = value.x;
																_position.y = value.y;
																
																// Cache the world position
																_worldPosition.x = value.x;
																_worldPosition.y = value.y;
																
																// If the parent exists
																if ( _parent != null )
																{
																	// Set world position from parent's world position
																	var parentPos:Point = _parent.worldPosition;
																	_worldPosition.x = _position.x + parentPos.x;
																	_worldPosition.y = _position.y + parentPos.y;
																}
															}

		public function SceneObject( name:String = null ) 
		{
			_sObjectCount++;
			_name = ( name == null ) ? "SceneObject" + _sObjectCount : name;
		}
		
		/*******************************************/
		// SceneObject Tree Structure
		/*******************************************/

		public function addSceneChild( child:SceneObject ):void
		{
			child.parent = this;
			_children.push( child );
		}

		public function removeSceneChild( child:SceneObject ):void
		{
			var index:int = _children.indexOf( child );
			if ( index >= 0 )
			{
				_children.splice( index, 1 );
			}
		}

		/*******************************************/
		// SceneObject Components
		/*******************************************/

		public function addComponent( component:Component ):void 
		{
			if (component == null)
			{
				return;
			}
			component.owner = this;
			_components.push( component );
		}

		public function getComponent( type:Number ):Component
		{
			for each ( var component:Component in _components ) 
			{
				if ( component.type == type)
				{
					return component;
				}
			}
			
			return null;
		}

		public function removeComponent( component:Component ):void
		{
			if (component == null)
			{
				return;
			}
			var index:int = _components.indexOf( component, 0 );
			if ( index >= 0 )
			{
				_components.splice(index, 1);
			}
		}

		/*
		 * Rendering/Erasing
		 */
		public function render( surface:DisplayObjectContainer ):void 
		{
			var renderComponent:RenderComponent = getComponent( Component.RENDER_COMPONENT ) as RenderComponent;
			
			if ( renderComponent != null )
			{
				renderComponent.render( surface );
			}
			
			for each ( var child:SceneObject in _children ) 
			{
				child.render( surface );
			}
		}
		
		public function erase( surface:DisplayObjectContainer ):void
		{
			for each ( var child:SceneObject in _children ) 
			{
				child.erase( surface );
			}
			
			var renderComponent:RenderComponent = getComponent( Component.RENDER_COMPONENT ) as RenderComponent;
			
			if ( renderComponent != null )
			{
				renderComponent.erase( surface );
			}
		}
		
		/*******************************************/
		// Update all the children
		/*******************************************/

		public function update():void
		{
			updateChildren();
			updateComponents();
		}

		private function updateChildren():void 
		{
			for each ( var child:SceneObject in _children ) 
			{
				child.update();
			}
		}
		
		private function updateComponents( ):void 
		{
			for each ( var component:Component in _components ) 
			{
				if ( component.type != Component.RENDER_COMPONENT )
				{
					component.update();
				}
			}
			
			var renderComponent:RenderComponent = getComponent( Component.RENDER_COMPONENT ) as RenderComponent;
			
			if ( renderComponent != null ) 
			{
				renderComponent.update();
			}
		}
	}
}