package com.scyllacharybdis.core.objects
{
	import com.scyllacharybdis.core.memory.deallocate;
	import com.scyllacharybdis.core.memory.DIClassDetails;
	import com.scyllacharybdis.core.memory.MemoryManager;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	
	/**
	 * BaseObject is a base object for all game elements
	 */
	public class BaseObject 
	{
		/****************************************/
		// Variables
		/****************************************/		
		private var _dependencies:Dictionary = new Dictionary(true);
		private var _classDetails:DIClassDetails;

		private var _awake:Boolean = false;
		private var _started:Boolean = false;

		/****************************************/
		// Construtor and Destructor
		/****************************************/		

		public function awake():void {}
		public function start():void {}
		public function stop():void {}
		public function destroy():void {}
		
		/****************************************/
		// Engine Construtor and Destructor
		/****************************************/		
		
		/**
		 * Awake is called at the construction of the object
		 * @private
		 */
		public function engine_awake():void 
		{ 
			if ( awaked == true ) {
				return;
			}
			awaked = true;
			
			// Call the users awake
			awake();
		}
		
		/**
		 * Start is called when the object is added to the scene
		 * @private
		 */
		public function engine_start():void  
		{ 
			if ( started == true ) {
				return;
			}
			started = true;
			
			// Call the users start
			start();
		}
		
		/**
		 * Stop is called when the object is removed from the scene
		 * @private
		 */
		public function engine_stop():void 
		{ 
			started = false;
			
			// Call the users stop
			stop();
		}
		
		
		/**
		 * Destroy is called at the removal of the object
		 * @private
		 */
		public function engine_destroy():void	 
		{ 
			awaked = false;
			
			// Call the users destroy
			destroy();

			// Destroy the components
			for each ( var dependency:* in _dependencies )
			{
				deallocate( dependency );
			}
			
			_dependencies = null;
		} 

		/****************************************/
		// Interface calls
		/****************************************/		
		
		/**
		 * Get the dependency
		 */
		public final function getDependency( type:Class ):*
		{
			return _dependencies[type];
		}


				
		/****************************************/
		// DI methods
		/****************************************/		

		/**
		 * Get the class details
		 * @return
		 * @private
		 */
		public final function getClassDetails():DIClassDetails
		{
			return _classDetails;
		}
		
		/**
		 * Set the class details
		 * @param	value
		 * @private
		 */
		public final function setClassDetails(value:DIClassDetails):void
		{
			_classDetails = value;
		}
		
		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 * @private
		 */
		public final function setDependencies( value:Dictionary ):void 
		{ 
			_dependencies = value; 
		}

		/**
		 * Has the object been awaken
		 * @private
		 */
		public function get awaked():Boolean { return _awake; }
		
		/**
		 * Set if the object has been awakened
		 * @private
		 */
		public function set awaked(value:Boolean):void  {	_awake = value;	}

		/**
		 * Has the object been started
		 * @private
		 */
		public function get started():Boolean { return _started; }
		
		/**
		 * Set if the object has been started
		 * @private
		 */
		public function set started(value:Boolean):void  {_started = value;}

	
	}
}