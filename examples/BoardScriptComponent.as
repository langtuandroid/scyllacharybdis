package   
{
	import core.BaseObject;
	import core.GameObject;
	import core.MemoryManager;
	import components.ScriptComponent;
	import components.TransformComponent;
	import flash.geom.Point;
	import org.casalib.math.geom.Point3d;

	/**
	 */
	public class BoardScriptComponent extends ScriptComponent
	{
		
		protected var whitePieces:Array;
		protected var blackPieces:Array;
		
		public override function engine_start():void 
		{
			super.engine_start();
			
			var depth:int = 1;
			var size:int = 50;
			var startingX:int = 800 / 2.0 - ( 8 * size / 2.0 );
			var startingY:int = 600 / 2.0 - ( 8 * size / 2.0 );
			
			for ( var i:int = 0; i < 8; i++ ) 
			{
				for ( var j:int = 0; j < 8; j++ )
				{
					var piece:GameObject = MemoryManager.instantiate(GameObject, GameObject.dependencies);
					
					owner.addChild( piece );
					
					piece.addComponent(PieceScriptComponent);
					piece.addComponent(TransformComponent);
					piece.addComponent( ( i % 2 == j % 2 ) ? WhiteRenderComponent : BlackRenderComponent );
					
					piece.getComponent( BaseObject.TRANSFORM_COMPONENT ).dimensions = new Point( size, size );
					piece.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( startingX + i * size, 
																								 startingY + j * size, 
																								 depth );	
				}
			}
		}
	}
}