package components 
{
	import engine.components.Component;
	import flash.utils.Dictionary;
	import state.State;
	
	/**
	 * ...
	 * @author ...
	 */
	public class StateComponent extends Component 
	{
		public override function get type():String { _return STATE_COMPONENT; }
		
		// Current state of the game object
		protected var _currentState:State = null;
		
		public function get currentState():State
		{
			return _currentState;
		}
		
		public function set currentState( value:State ):void
		{
			_currentState.exit( _owner );
			_currentState = value;
			_currentState.enter( _owner );
		}
		
		public function StateComponent() 
		{
			
		}
		
		public override function awake():void
		{
			super.awake();
			
			_currentState = new State();
		}
		
		public override function update():void
		{
			_currentState.update( _owner );
		}	
	}
}