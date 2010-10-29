/**
 * RenderComponent is the renderable attached to scene object.
 * It defines the rendering.
 */
class RenderComponent extends Components
{
	private var mMovieClip:MovieClip = null;
	private var mPosition:Point = new Point(0.0f, 0.0f);

	public SetMovieClip( clip:MovieClip ) 
	{
		mMovieClip = clip;
		SetupEvents();
	}

	public GetType( void ):Number 
	{
		return RenderComponent;
	}

	// Render at the world position
	public Render( position:Point ):void
	{
		mMovieClip.SetPosition(mPosition.x + position.x, mPosition.y + position.y);	
	}

	// Helper function to pass the events to the script controller
	private SetupEvents( void ): void 
	{
		var tempComp = this.GetSceneObject().GetComponent(ScriptType);
		if (tempComp != null)
		{
			// Define the callbacks
			//mMovieClip.onMouseDown = tempComp.OnMouseDown();
			//mMovieClip.onMouseUp = tempComp.OnMouseUp();
		
			// If the other way didn't work try this:
			mMovieClip.onMouseDown = function() 
			{
				tempComp.OnMouseDown();
			}
			mMovieClip.onMouseUp =  = function() 
			{
				tempComp.OnMouseUp();
			}
		}
	}
}
