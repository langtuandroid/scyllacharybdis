package engine.di 
{
	/**
	 */
	public class DependencyInjector
	{
		private var _descriptions:Dictionary = new Dictionary();
		private var _dependencies:Dictionary = new Dictionary();
		
		public DependencyInjector()
		{
			registerEngineDependencies();
		}
		
		public registerClass( type:Class ) 
		{
			// Is it already registered
			if ( _descriptions.indexOf( type ) ) 
			{
				return;
			}
			_descriptions[type] = type.desctiption();
			_dependencies[type] = type.dependencies();
		}
		
		private registerEngineDependencies() 
		{
			registerClass(BaseObject); 
			registerClass(GameObject); 

			registerClass(MemoryManager); 
			registerClass(NetworkManager); 
			registerClass(RenderManager); 
			registerClass(SceneGraph); 
			
			registerClass(NetworkComponent); 
			registerClass(RenderComponent); 
			registerClass(ScriptComponent); 
			registerClass(StateComponent); 
			registerClass(TransformComponent); 
			registerClass(StateComponent); 
			
			registerClass(ConnectionHandler); 
			registerClass(LoginHandler); 
			registerClass(RoomHandler); 
		}
	}
}