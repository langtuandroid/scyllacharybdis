package core.loaders 
{
	import core.ami.AMIResults;
	/**
	 * ...
	 * @author 
	 */
	public class RendererResults extends AMIResults
	{
		/**
		 * Override to implement task success
		 * @param	data
		 */
		public function success(data:*):void
		{
			invoker.parseXML( data );
		}
		
		/**
		 * Override to implement task failed
		 * @param	data
		 */
		public function failed(data:*):void
		{
			trace( data );
		}		
	}
}