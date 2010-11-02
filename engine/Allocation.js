var static SceneObjects:Array = new Array();

/**
 * Instanciate a scene object 
 */
function Instantiate( void ): SceneObject
{
	return Instanciate("");
}

/**
 * Instanciate a scene object 
 * @param String Name Name of the scene object
 */
function Instantiate( name:String ): SceneObject
{
	var object:SceneObject;
	if ( name )
	{
		object = new SceneObject( name );
	} 
	else 
	{
		object = new SceneObject();
	}

	object.Awake();
	return object;
}

/**
 * Destroy the scene object 
 */
function Destroy( var object:SceneObject ): void 
{
	if ( object )
	{
		object.Destroy();
		delete object;
	}
}

function FindSceneObjectByName( var name:String ): void
{

}