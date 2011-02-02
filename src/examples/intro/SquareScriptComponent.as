package examples.intro 
{
	import com.scyllacharybdis.components.ScriptComponent;
	import com.scyllacharybdis.components.SoundComponent;
	import flash.events.MouseEvent;
	
	[Component (type="ScriptComponent")]
	public class SquareScriptComponent extends ScriptComponent
	{
		public override function start():void 
		{
			if ( owner.getComponent(SoundComponent) != null ) 
			{
				trace("Load sound: aladdin_goodbye.mp3");
				owner.getComponent( SoundComponent ).loadSound("aladdin_goodbye.mp3");
			}
		}
		
		public override function onMouseDown( e:MouseEvent ):void
		{
			//if ( owner.getComponent( SoundComponent ) != null ) 
			//{
				//owner.getComponent( SoundComponent ).playSound(1);
			//}
		}
	}
}