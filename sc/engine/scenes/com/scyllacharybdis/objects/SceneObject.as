package com.scyllacharybdis.objects 
{
	import com.scyllacharybdis.core.composite.GameObject;
	import com.scyllacharybdis.graphics.scenegraph.SceneGraph;
	import com.scyllacharybdis.interfaces.IBaseObject;

	/**
	 */
	public class SceneObject implements IBaseObject
	{

		/****************************************/
		// Class Details
		/****************************************/
		
		private var _initialized:Boolean = false;
		private var _rootGameObject:GameObject;
		private var _sceneGraph:SceneGraph;
		
		public function SceneObject(sceneGraph:SceneGraph):void
		{
			_sceneGraph = sceneGraph;
		}
		
		public function awake():void
		{
		}
		
		public function destroy():void
		{
			_sceneGraph = null;
		}
		
		public function hide():void 
		{
			
		}
		/**
		 * Add game object to scene helper function.
		 * @param	gameObj
		 */
		protected function addToScene( gameObj:GameObject ):void
		{
			_sceneGraph.addGameObjectToScene( gameObj );
		}

		/**
		 * Remove game object from the scene helper function.
		 * @param	gameObj
		 */
		protected function removeFromScene( gameObj:GameObject ):void
		{
			_sceneGraph.removeGameObjectToScene( gameObj );
		}
	}
}