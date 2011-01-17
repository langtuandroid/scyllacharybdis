			var test:UnitTester = new UnitTester("Allocation Tests");
			
			test.addTest(new ParamTest1());
			test.addTest(new ParamTest2());
			test.addTest(new SingletonTest1());
			test.addTest(new SingletonTest2());
			
			test.startTest();