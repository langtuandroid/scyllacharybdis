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
			registerClass(EngineEvent.class); 
			registerClass(GameObject.class); 
			registerClass(Component.class); 
			registerClass(NetworkComponent.class); 
			registerClass(RenderComponent.class); 
			registerClass(ScriptComponent.class); 
			registerClass(StateComponent.class); 
			registerClass(TransformComponent.class); 
			registerClass(BaseObject.class); 
			registerClass(ComponentManager.class); 
			registerClass(GameObjectManager.class); 
			registerClass(MemoryManager.class); 
			registerClass(NetworkManager.class); 
			registerClass(RenderManager.class); 
			registerClass(SceneGraph.class); 
			registerClass(State.class); 
			registerClass(ClassList.class); 
			registerClass(Dependencies.class); 
			registerClass(Description.class); 
			registerClass(ConnectionHandler.class); 
			registerClass(Handler.class); 
			registerClass(LoginHandler.class); 
			registerClass(RoomHandler.class); 
		}
	}
}