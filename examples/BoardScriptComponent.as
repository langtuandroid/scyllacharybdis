package  
{
	import core.MemoryManager;
	import core.GameObject;
	import components.ScriptComponent;
	import components.TransformComponent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BoardScriptComponent extends ScriptComponent
	{
		
		protected var whitePieces:Array;
		protected var blackPieces:Array;
		
		protected var _memoryManager:MemoryManager;

		public override function awake():void 
		{
			for ( var i:int = 0; i < 16; i++ ) 
			{
				// Create a new piece
				var whitePiece:GameObject = _memoryManager.instantiate(GameObject);
				var blackPiece:GameObject = _memoryManager.instantiate(GameObject);
				
				// Add to the board
				owner.addChild( whitePiece );
				owner.addChild( blackPiece );
			
				// Add components to the peice
				whitePiece.addComponent(TransformComponent);
				whitePiece.addComponent(PieceRenderComponent);
				whitePiece.addComponent(PieceScriptComponent);
				
				blackPiece.addComponent(TransformComponent);
				blackPiece.addComponent(PieceRenderComponent);
				blackPiece.addComponent(PieceScriptComponent);
			}
		}
	}
}