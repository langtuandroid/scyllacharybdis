package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Daniel Lamb
	 */
	public class SceneObject
	{
		private static var sObjectCount:int = 0;
		
		private var mName:String = null;
		private var mParent:SceneObject = null;
		private var mChildren:Array = new Array();
		private var mComponents:Array = new Array();
		private var mPosition:Point = new Point( 0.0, 0.0 );
		private var mWorldPosition:Point = new Point( 0.0, 0.0 );
		private var mDisabled:Boolean = false;
		
		public function get name():String { return mName; }
		public function get parent():SceneObject { return mParent; }
		public function get postion():Point { return mPosition; }
		public function get worldPosition():Point { return mWorldPosition; }
		
		public function set parent( value:SceneObject ):void { mParent = value; }
		public function set position ( value:Point ):void 	{ 
																// Set the local position
																mPosition.x = value.x;
																mPosition.y = value.y;

																// Cache the world position
																mWorldPosition.x = value.x;
																mWorldPosition.y = value.y;
																if (mParent != null)
																{
																	var pos:Point = mParent.worldPosition;
																	mWorldPosition.x = mPosition.x + pos.x;
																	mWorldPosition.y = mPosition.y + pos.y;
																}
															}

		public function SceneObject( name:String = null ) 
		{
			sObjectCount++;
			mName = ( name == null ) ? "SceneObject" + sObjectCount : name;
		}
		
		/*******************************************/
		// SceneObject Tree Structure
		/*******************************************/

		public function AddChild( child:SceneObject ):void
		{
			child.parent = this;
			mChildren.push( child );
		}

		public function RemoveChild( child:SceneObject ):void
		{
			var index:int = mChildren.indexOf( child );
			if ( index >= 0 )
			{
				mChildren.splice( index, 1 );
			}
		}

		/*******************************************/
		// SceneObject Components
		/*******************************************/

		public function AddComponent( component:Component ):void 
		{
			if (component == null)
			{
				return;
			}
			component.sceneObject = this;
			mComponents.push( component );
		}

		public function GetComponent( type:Number ):Component
		{
			for each ( var component:Component in mComponents ) 
			{
				if ( component.type == type)
				{
					return component;
				}
			}
			
			return null;
		}

		public function RemoveComponent( component:Component ):void
		{
			if (component == null)
			{
				return;
			}
			var index:int = mComponents.indexOf( component, 0 );
			if ( index >= 0 )
			{
				mComponents.splice(index, 1);
			}
		}

		/*******************************************/
		// Update all the children
		/*******************************************/

		public function Update():void
		{
			UpdateChildren();
			UpdateComponents();
			Render();
		}

		private function UpdateChildren():void 
		{
			for each ( var child:SceneObject in mChildren ) 
			{
				child.Update();
			}
		}

		private function UpdateComponents( ):void 
		{
			for each ( var component:Component in mComponents ) 
			{
				component.Update();
			}
		}

		private function Render():void 
		{
			for each ( var component:Component in mComponents ) 
			{
				if ( component.type == Component.RENDER_COMPONENT )
				{
					(component as RenderComponent).Render( this.worldPosition );
				}
			}
		}
	}

}