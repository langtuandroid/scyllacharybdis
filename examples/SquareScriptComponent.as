package  
{
	import components.ScriptComponent;
	import flash.events.MouseEvent;
	
	public class SquareScriptComponent extends ScriptComponent
	{
		public override function start():void 
		{
			if ( owner.getComponent( SOUND_COMPONENT ) != null ) 
			{
				trace("Load sound: aladdin_goodbye.mp3");
				owner.getComponent( SOUND_COMPONENT ).loadSound("aladdin_goodbye.mp3");
			}
		}
		
		public override function onMouseDown( e:MouseEvent ):void
		{
			trace("You just clicked on " + owner.toString());
			if ( owner.getComponent( SOUND_COMPONENT ) != null ) 
			{
				owner.getComponent( SOUND_COMPONENT ).playSound(1);
			}
		}
	}
}