package test.memory.extras 
{
	/**
	 * ...
	 * @author 
	 */
	[Singleton]
	public class SingletonTest
	{
		private static var count:int = 0;
		public function SingletonTest() 
		{
			count++;
			if ( count > 1 ) 
			{
				throw new Error("Created more then one singleton");
			}
		}
		
	}

}