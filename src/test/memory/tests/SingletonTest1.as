package test.memory.tests 
{
	import sc.memory.allocate;
	import test.memory.extras.SingletonTest;
	import test.unittest.IUnitTest;

	/**
	 * ...
	 * @author 
	 */
	public class SingletonTest1 implements IUnitTest
	{
		
		public function get message():String { return "Allocate a singleton"; }

		public function runTest():Boolean 
		{
			try
			{
				allocate(SingletonTest);
			} 
			catch (error:Error)
			{
				
				// Return failed
				return false;
			}
			
			// Return success
			return true;
		}
	}

}