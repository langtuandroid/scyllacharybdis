package examples.di 
{
	/**
	 * ...
	 * @author 
	 */
	[Singleton]
	public class TestClass 
	{
		public function TestClass( value:TestClass1, value1:TestClass1 ) 
		{
			trace("TestClass Constructor");
			trace( value + value1 );
		}
	}
}