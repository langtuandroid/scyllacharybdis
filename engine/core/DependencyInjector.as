package di
{
	import flash.utils.Dictionary;
	import components.*;
	import core.*;
	import di.*;
	import events.*;
	import handlers.*;
	
	public class DependencyInjector
	{
		private var _descriptions:Dictionary = new Dictionary();
		
		public function DependencyInjector():void
		{
			registerEngineDependencies();
		}
		
		public function registerClass( type:Class ):void
		{
			// Is it already registered
			if ( _descriptions.indexOf( type ) ) 
			{
				return;
			}
			_descriptions[type] = type.desctiption();
			_dependencies[type] = type.dependencies();
		}

		public function get description( type:Class ):Description
		{
			return _descriptions[type];
		}
		
		public function get dependencies( type:Class ):Dependencies
		{
			return _dependencies[type];
		}
	}
}