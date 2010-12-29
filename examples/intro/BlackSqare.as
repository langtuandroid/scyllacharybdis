package  
{
	import core.Texture;
	
	/**
	 */
	public class BlackSqare extends Texture;
	{
		
		public function BlackSqare() 
		{
			_baseclip.graphics
			_baseclip.graphics.beginFill( 0x123456 );
			_baseclip.graphics.drawRect( 0, 0, 200, 200 );
			_baseclip.graphics.endFill();
			_baseclip.z = 0;		
		}
	}
}