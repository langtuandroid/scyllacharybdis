package test.memory.tests 
{
	import sc.memory.allocate;
	import test.memory.extras.DepClass;
	import test.memory.extras.TestClass;
	import test.unittest.IUnitTest;

	/**
	 * ...
	 * @author 
	 */
	public class ParamTest2 implements IUnitTest
	{
		public function get message():String { return "Allocate class with the right parameters"; }
		
		public function runTest():Boolean 
		{
			try
			{
				allocate(TestClass, new DepClass(), new DepClass());
			} 
			catch (error:Error)
			{
				trace( error.message );
				return false;
			}	
			
			return true;
		}
	}
}