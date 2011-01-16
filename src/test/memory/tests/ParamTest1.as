package test.memory.tests 
{
	import sc.memory.allocate;
	import test.memory.extras.TestClass;
	import test.unittest.IUnitTest;
	/**
	 * ...
	 * @author 
	 */
	public class ParamTest1 implements IUnitTest
	{
		public function get message():String { return "Allocate class with the wrong parameters"; }
		
		public function runTest():Boolean 
		{
			try
			{
				allocate(TestClass);
			} 
			catch (error:Error)
			{
				// Success
				return true;
			}			
			
			// failed 
			return false;
		}
	}
}