package base
{
	import flash.utils.Dictionary;
	
	/**
	 * BaseObject is a base object for all game elements
	 */
	public class BaseObject
	{
		/**
		* Awake is called at the construction of the object
		*/
		public function awake( ):void { return; }
		
		/**
		* Start is called when the object is added to the scene
		*/
		public function start( ):void  { return; }
		
		/**
		* Stop is called when the object is removed from the scene
		*/
		public function stop( ):void { return; }
		
		/**
		* Destroy is called at the removal of the object
		*/
		public function destroy( ):void	 { return; } 
	}
}