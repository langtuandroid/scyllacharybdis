package core.loaders 
{
	/**
	 * ...
	 * @author 
	 */
	public class TextureResults extends AMIResults
	{
		/**
		 * Override to implement task success
		 * @param	data
		 */
		public function success(data:*):void
		{
			task.invoker.textureLoadSuccess( data );
		}
		
		/**
		 * Override to implement task failed
		 * @param	data
		 */
		public function failed(data:*):void
		{
			task.invoker.textureLoadError( data );
		}			
	}

}