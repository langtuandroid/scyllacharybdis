package Engine 
{
	/**
	 */
	public class ScriptComponent extends Component
	{
		public override function get type():Number { return SCRIPT_COMPONENT; }

		/**
		* Awake is called at the construction of the object
		*/
		public override function awake():void
		{
		}

		/**
		* Start is called when the object is added to the scene
		*/
		public override function start():void		
		{
		}

		/**
		* Stop is called when the object is removed from the scene
		*/
		public override function stop():void
		{
		}

		/**
		* Destroy is called at the removal of the object
		*/
		public override function destroy():void		
		{
		} 

		/**
		 * Update each frame
		 */
		public override function update():void
		{
		}
	}
}