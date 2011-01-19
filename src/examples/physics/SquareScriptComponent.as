package examples.physics 
{
	import com.scyllacharybdis.components.SoundComponent;
	import com.scyllacharybdis.interfaces.IScriptComponent;
	import flash.events.MouseEvent;
	
	public class SquareScriptComponent implements IScriptComponent
	{
		private var _owner:*;
		
		public function awake(owner:*):void
		{
			_owner = owner;
			if ( owner.getComponent(SoundComponent) != null ) 
			{
				trace("Load sound: aladdin_goodbye.mp3");
				owner.getComponent( SoundComponent ).loadSound("aladdin_goodbye.mp3");
			}			
		}
		
		public function update():void
		{
			
		}
		
		public function destroy():void
		{
			
		}
		
		public function onMouseDown( e:MouseEvent ):void
		{
			trace("You just clicked on " + _owner.toString());
			if ( _owner.getComponent( SoundComponent ) != null ) 
			{
				_owner.getComponent( SoundComponent ).playSound(1);
			}
		}
	}
}