package test.memory.tests 
{
	import sc.memory.allocate;
	import test.memory.extras.SingletonTest;
	import test.unittest.IUnitTest;

	/**
	 * ...
	 * @author 
	 */
	public class SingletonTest2 implements IUnitTest
	{
		
		public function get message():String { return "Try allocate a singleton for the second time"; }
		
		public function runTest():Boolean 
		{
			try
			{
				allocate(SingletonTest);
			} 
			catch (error:Error)
			{
				trace( error.message );

				return false;
			}
			
			// Return failed
			return true;
		}
	}

}