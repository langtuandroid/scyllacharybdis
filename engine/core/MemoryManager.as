package core 
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import flash.utils.describeType;

	import core.BaseObject;
	import core.AllocationDetails;
	
	/**
	 * MemoryManager
	 */
	public class MemoryManager extends BaseObject 
	{
		private var _allocations:Dictionary = new Dictionary();
		
		/**
		* Instantiate an object
		* @param type (Class) The type of object to create
		*/
		public function instantiate( type:Class ):*
		{
			// Setup all the details but don't init anything
			setupAllocationDetails(type);
			
			if ( _allocations[type].singleton == true ) {
				
				if ( _allocations[type].object != null ) {
					
					// Return the current object
					return _allocations[type].object;
				} 
			}

			// Allocate the object
			_allocations[type].object = new type();
			
			// Setup its dependencies
			setupDependencies( _allocations[type] );
			
			// Increase the debugging counter
			incrementCounter( _allocations[type] );
			
			// Awaken the object
			_allocations[type].object.awake();
			
			// Return the object
			return _allocations[type].object;
		}
		
		/**
		 * Destroy the scene object 
		 * @param object (SceneObject) The scene object to be destroyed
		 */
		public function destroyObject( obj:* ): void 
		{
			if ( _allocations[getQualifiedClassName(obj)].singleton == true ) 
			{
				trace("You can't destory a singleton");
				return;
			}
			
			// Run its destructor
			obj.destroy();
			
			var alloc:AllocationDetails = _allocations[getQualifiedClassName(obj)];

			// Reduce the debugging counter
			decrementCounter( alloc );
			
			// Set the object to null
			alloc.object = null;
		}
		
		/**
		 * Get the object counter
		 * @param type (Class) The class type
		 * @return int 
		 */
		public function getObjectCount(type:Class):int
		{
			return _allocations[type].getCounter();
		}	
		
		/**
		 * Debugging Helper Function
		 * @param type (BaseObject) The created object
		 */
		private function incrementCounter( alloc:AllocationDetails ):void
		{
			alloc.incrementCounter();
		}
		
		/**
		 * Debugging Helper Function
		 * @param type (BaseObject) The destroyed object
		 */
		private function decrementCounter( alloc:AllocationDetails ):void
		{
			alloc.decrementCounter();
		}
		
		
		private function setupAllocationDetails(type:Class):void
		{
			// Has it already been setup
			if ( _allocations[type] ) {
				return;
			}
			_allocations[type] = new AllocationDetails();
			
			var typeInfo:XML = describeType(type);

			var metaData:XMLList = typeInfo..metadata;
			
			for each ( var value:XML in metaData )
			{
				// Is it a singleton
				if (value.attribute("name") == "Singleton" ) {
					_allocations[type].singleton = true;
				}
				
				// Get the requirements
				if (value.attribute("name") == "Requires" ) 
				{
					var list:Array = new Array();
					for each ( var req:XML in value.arg ) 
					{
						list.push(req.attribute("value"));
					}
					_allocations[type].requirements = list;
				}
				
				// Get the component type
				if (value.attribute("name") == "Component" ) 
				{
					for each ( var com:XML in value.arg ) 
					{
						_allocations[type].componentType = getQualifiedClassName(com.attribute("value"));
					}
				}				
			}			
		}
		
		private function setupDependencies( alloc:AllocationDetails ):void
		{
			var depList:Dictionary = new Dictionary();
			
			// Loop through all the dependencies
			for each ( var dep:Class in alloc.requirements ) 
			{
				// Add the deps to a dictionary
				depList[dep] = this.instantiate(dep);
			}
			
			alloc.object.setDependencies( depList );
		}

	}
}

