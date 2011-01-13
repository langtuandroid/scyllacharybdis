package core.ami 
{
	/**
	 * ...
	 * @author 
	 */
	public class AMIFileLoadAction extends AMIAction
	{
		private var _fileName:String;
		
		public function AMIFileLoadAction( fileName:String ) 
		{
			_fileName = fileName;
		}
		
		protected function get fileName():String { return _fileName; }
		
		protected function set fileName(value:String):void 
		{
			_fileName = value;
		}
		
	}

}