package com.scyllacharybdis.core.xml 
{

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
		public override function success(data:*):void
		{
			task.invoker.xmlLoadSuccess( data );
		}
		
		/**
		 * Override to implement task failed
		 * @param	data
		 */
		public override function failed(data:*):void
		{
			task.invoker.xmlLoadError( data );
		}		
	}
}