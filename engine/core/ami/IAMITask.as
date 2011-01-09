package core.ami 
{
	/**
	 * ...
	 * @author 
	 */
	public interface IAMITask 
	{
		public IAMITask( results:IAMIResults );
		public function execute():void;
	}
}