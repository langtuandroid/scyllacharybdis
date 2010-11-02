const static RenderComponent:Number=1;
const static ScriptComponent:Number=2;

/**
 * Component Baseclass. Extend this to create a new component type.
 */
class Components
{
	var mSceneObject:SceneObject = null;

	public GetSceneObject( void ): SceneObject
	{
		return mSceneObject;
	}

	public SetSceneObject( object:SceneObject ): void
	{
		mSceneObject = object;
	}

	public GetType( void ):Number 
	{
		return 0;
	}

	public Update( void ): void
	{
	}
}