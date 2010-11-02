/**
 * SceneObject are used to define the structure of gameobject. 
 * They contain components that represent the rendering and scripting
 * information.
 */
class SceneObject
{
	private static var sObjectCount:int = 0;
	private var mName:String = null;
	private var mParent:SceneObject = null;
	private var mChildren:Array = new Array();
	private var mComponents:Array = new Array();
	private var mPosition:Point = new Point(0.0f,0.0f);
	private var mWorldPosition:Point = new Point(0.0f,0.0f);
	private var mDisabled:boolean = false;

	/*******************************************/
	// SceneObject Constructors
	/*******************************************/
	public SceneObject():void 
	{
		sObjectCount++;
		mName = "SceneObject" + sObjectCount;
	}

	public SceneObject(name:String):void 
	{
		sObjectCount++;
		mName = name;
	}

	/*******************************************/
	// SceneObject Tree Structure
	/*******************************************/

	public AddChild( var child:SceneObject ):void
	{
		child.SetParent( this );
		mChildren.push( child );
	}

	public RemoveChild( var child:SceneObject ):void
	{
		var index = mChild.indexOf( child, 0 );
		if ( index != 0 )
		{
			mChild.splice(index, 1);
		}
	}

	/*******************************************/
	// SceneObject Components
	/*******************************************/

	public AddComponent( component:Component ):void 
	{
		if (component == null)
		{
			return;
		}
		component.SetParent( this );
		mComponents.push( component );
	}

	public GetComponent(type:Number):Component
	{
		for ( var component in mComponents ) 
		{
			if ( component.GetType() == type)
			{
				return component;
			}
		}
		return null;
	}

	public RemoveComponent(component:Component):void
	{
		if (component == null)
		{
			return;
		}
		var index = mComponents.indexOf( component, 0 );
		if ( index != 0 )
		{
			mComponents.splice(index, 1);
		}
	}

	/*******************************************/
	// Update all the children
	/*******************************************/

	public Update( void ):void
	{
		UpdateChildren();
		UpdateComponents();
		Render();
	}

	private UpdateChildren( void ):void 
	{
		for ( var child in mChildren ) 
		{
			child.Update();
		}
	}

	private UpdateComponents( void ):void 
	{
		for ( var component in mComponents ) 
		{
			component.Update();
		}
	}

	private Render( void ):void 
	{
		for ( var component in mComponents ) 
		{
			if ( component.GetType() == RenderType)
			{
				component.Render( this.GetWorldPosition() );
			}
		}
	}

	/*******************************************/
	// SceneObject Parent Information
	/*******************************************/

	public GetParent( void ): SceneObject
	{
		return mParent;
	}

	public SetParent( var parent:SceneObject ):void
	{
		mParent = parent;
	}

	/*******************************************/
	// SceneObject Position Information
	/*******************************************/
	public GetPosition( void ): Point
	{
		return mPosition;
	}

	public SetPosition( var pos:Point ):void
	{
		// Set the local position
		mPosition.x = pos.x;
		mPosition.y = pos.y;

		// Cache the world position
		mWorldPosition.x = pos.x;
		mWorldPosition.y = pos.y;
		if (mParent != null)
		{
			var pos = mParent.GetWorldPosition();
			mWorldPosition.x = mPosition.x + pos.x;
			mWorldPosition.y = mPosition.y + pos.y;
		}
	}

	public GetWorldPosition( void ): Point
	{
		return mWorldPosition;
	}
}
