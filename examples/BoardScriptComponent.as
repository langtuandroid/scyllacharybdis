package   
{
	import core.BaseObject;
	import core.GameObject;
	import core.MemoryManager;
	import components.ScriptComponent;
	import components.TransformComponent;
	import core.Scene;
	import org.casalib.math.geom.Point3d;

	/**
	 */
	public class BoardScriptComponent extends ScriptComponent
	{
		
		protected var whitePieces:Array;
		protected var blackPieces:Array;
		
		public override function engine_start():void 
		{
			for ( var i:int = 0; i < 16; i++ ) 
			{
				// Create a new piece
				var whitePiece:GameObject = MemoryManager.instantiate(GameObject);
				var blackPiece:GameObject = MemoryManager.instantiate(GameObject);
				
				// Add to the board
				//owner.addChild( whitePiece );
				//owner.addChild( blackPiece );
			
				// Add components to the peice
				whitePiece.addComponent(PieceScriptComponent);
				whitePiece.addComponent(WhiteRenderComponent);
				whitePiece.addComponent(TransformComponent);

				whitePiece.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( i*25, 100, i );
				whitePiece.getComponent( BaseObject.TRANSFORM_COMPONENT ).rotate = 45;
				
				blackPiece.addComponent(PieceScriptComponent);
				blackPiece.addComponent(BlackRenderComponent);
				blackPiece.addComponent(TransformComponent);
				
				whitePiece.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( i*10, 200, i );
				whitePiece.getComponent( BaseObject.TRANSFORM_COMPONENT ).rotate = 45;

				var scene:Scene = getDependency(Scene);
				if ( scene == null ) {
					trace("scene is null");
					return;
				}
				scene.addGameObject( whitePiece );
				scene.addGameObject( blackPiece );

			}
		}
	}
}