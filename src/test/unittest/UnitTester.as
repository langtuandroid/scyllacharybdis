package test.unittest 
{
	import test.unittest.IUnitTest;
	/**
	 * ...
	 * @author 
	 */
	public class UnitTester 
	{
		private var _testList:Array = new Array();
		private var _name:String;

		public function UnitTester( name:String ):void
		{
			_name = name;
		}
		
		public function addTest( test:IUnitTest ):void
		{
			_testList.push( test );
		}
		
		public function startTest():void
		{
			var count:int = 0;
			var failed:int = 0;

			trace();
			trace("*******************************************");
			trace(_name);
			trace("*******************************************");
			trace();
			for each ( var test:IUnitTest in _testList )
			{
				count++;
				var results:Boolean = test.runTest();
				var message:String = test.message;
				if ( results )
				{
					message = message + ": Passed";
				} 
				else 
				{
					failed++;
					message = message + ": Failed";
				}
				trace(message);
			}
			trace();
			trace("Total Test: " + count + " - Success: " + (count - failed) + " Failed: " + failed );
			trace("*******************************************");
		}
	}

}