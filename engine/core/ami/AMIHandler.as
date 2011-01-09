package core.ami 
{
	import core.objects.BaseObject;
	/**
	 * ...
	 * @author 
	 */
	[Singleton]
	public class AMIHandler extends BaseObject
	{
		public function fireMessage( task:IAMITask ):void
		{
			task.execute();
		}
	}
}