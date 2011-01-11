package core.loaders 
{
	import core.ami.AMIResults;
	/**
	 * ...
	 * @author 
	 */
	public class XMLResults extends AMIResults
	{
		/**
		 * Override to implement task success
		 * @param	data
		 */
		public function success(data:*):void
		{
			task.invoker.xmlLoadSuccess( data );
		}
		
		/**
		 * Override to implement task failed
		 * @param	data
		 */
		public function failed(data:*):void
		{
			task.invoker.xmlLoadError( data );
		}		
	}
}