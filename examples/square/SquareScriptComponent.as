package square
{
	import components.ScriptComponent;
	import flash.events.MouseEvent;

	[Component (ScriptComponent)]
	public class SquareScriptComponent extends ScriptComponent
	{
		
		public function SquareScriptComponent() 
		{
			
		}
		
		public override function onMouseDown( e:MouseEvent ):void
		{
			trace("You just clicked on " + owner.toString());
		}
	}
}