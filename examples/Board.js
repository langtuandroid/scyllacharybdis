
/*******************************************/
// Example Components
/*******************************************/

class PawnScript extends ScriptComponent
{
	private var mSqareSize:float = 10;
	private var mColor:int = 0; 
	private var mRow:int = 0;
	private var mCol:int = 0;
	private var mSelected:boolean = false;

	public PawnScript( var color, var row:int, var col:int ): void
	{
		mColor = color;
		mRow = row;
		mCOl = col;
	}

	public Update( void ): void
	{
		if (mSelected == true)
		{
			Animate();
		}
	}

	public OnMouseDown( void ): void
	{
		ClearBoard();
	}

	public OnMouseUp( void ): void
	{

		mSelected = true;
	}

	public MovePiece( row:int, col:int ) : void
	{
		// Validate move

		// Set its position
		SetPosition( row, col );
	}
	
	private SetPosition( row:int, col:int ) : void
	{
		var renderer = this.GetSceneObject.GetComponent(RenderType);
		var x:float = mRow * mSqareSize;
		var y:float = mCol * mSquareSize;
		render.SetPosition( x, y );
	}
	private ClearBoard( void ): void
	{
		// Do something here
		// Need to be able to search for other pieces
	}

	private Animate( void ): void
	{
		// Do some animations
	}
}


class PawnRenderComponent extends RenderComponent
{
	public PawnRenderComponent(var movieClip:MovieClip ):void  
	{
		SetMovieClip( movieClip );
	}
}

class BoardComponent extends RenderComponent
{
	public BoardComponent(var movieClip:MovieClip ):void  
	{
		SetMovieClip( movieClip );
	}
}

/**
 * Example code
 */
class MyBoardScene
{
	private var	mRoot:GUISceneNode = null;

	MyExampleScene():void
	{
		// Root scene node for the complete gui
		mRoot = new SceneObject();
		mRoot.AddComponent( new BoardComponent(new MovieClip() ) );

		for ( int i = 1; i < 8; i++)
		{
			var:SceneObject pawn = new SceneObject();
			// Color 1 = white, Row 2 and Colomn I
			pawn.AddComponent( new PawnScript(1, 2, i ) );
			pawn.AddComponent( new PawnRenderComponent(new MovieClip()) );
			mRoot.AddChildren(pawn);
		}

		for ( int i = 1; i < 8; i++)
		{
			var:SceneObject pawn = new SceneObject();
			// Color 2 = black, Row 2 and Colomn I
			pawn.AddComponent( new PawnScript(2, 7, i ) );
			pawn.AddComponent( new PawnRenderComponent(new MovieClip()) );
			mRoot.AddChildren(pawn);
		}
	}
}