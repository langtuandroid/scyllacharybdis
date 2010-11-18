package   
{
	import core.BaseObject;
	import core.GameObject;
	import core.MemoryManager;
	import components.ScriptComponent;
	import components.TransformComponent;
	import org.casalib.math.geom.Point3d;

	/**
	 */
	public class BoardScriptComponent extends ScriptComponent
	{
		
		protected var whitePieces:Array;
		protected var blackPieces:Array;
		
		public override function engine_start():void 
		{
			var depth:int = 1000;
			
			for ( var i:int = 0; i < 8; i++ ) 
			{
				for ( var j:int = 0; j < 8; j++ )
				{
					var piece:GameObject = MemoryManager.instantiate(GameObject, GameObject.dependencies);
					
					piece.addComponent(PieceScriptComponent);
					piece.addComponent(TransformComponent);
					piece.addComponent( ( i % 2 == j % 2 ) ? WhiteRenderComponent : BlackRenderComponent );
					
					piece.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( i * 25, j * 25, depth );
					depth++;
					
					owner.addChild( piece );
				}
			}
		}
	}
}