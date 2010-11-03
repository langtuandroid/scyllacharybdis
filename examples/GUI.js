
/*******************************************/
// Example Components
/*******************************************/

/**
 * Example script object.
 */
class GUIScript extends ScriptComponent
{
	public Update( void ): void
	{
		// Move the stupid thing around
		var pos:Point = this.GetSceneObject().GetGetPosition();
		pos.x+1;
		this.GetSceneObject().SetPosition(pos);
	}

	public OnMouseDown( void ): void
	{
		trace("I got clicked");
	}
}


/**
 * Example widget class. It allows you to offset the gui element
 * from the center of its world position.
 */
class GUIWidget extends RenderComponent
{
	public GUIWidget(var movieClip:MovieClip, var pos:Point ):void  
	{
		SetMovieClip( movieClip );
		mPosition.x = pos.x;
		mPosition.y = pos.y;
	}
}

/**
 * Example code
 */
class MyExampleScene
{
	private var	mRoot:GUISceneNode = null;
	MyExampleScene():void
	{
		// Root scene node for the complete gui
		mRoot = new SceneObject();

		// Create some branches
		mBranch1 = new SceneObject();
		mBranch2 = new SceneObject();
		
		// Add the branches to the root
		mRoot.AddChildren(mBranch1);
		mRoot.AddChildren(mBranch2);

		// Add components to the node
		branch1.AddComponent( new GUIScript() );
		branch1.AddComponent( new GUIWidget(new MovieClip(), new Vector( 0,0 ) ) );

		// Add them to another node
		branch2.AddComponent( new GUIScript() );
		branch2.AddComponent( new GUIWidget(new MovieClip(), new Vector( 0,0 ) ) );
	}
}

