package com.scyllacharybdis.graphics.rendering 
{
	import com.scyllacharybdis.graphics.scenegraph.SceneGraph;
	import com.scyllacharybdis.interfaces.IBaseObject;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	
	/**
	 */
	[Singleton]
	public final class Renderer implements IBaseObject
	{
		private var _sceneGraph:SceneGraph = null;
		private var _window:Window = null;
		private var _dirty:Boolean = true;
		
		/**
		 * Constructor
		 */
		public function Renderer(sceneGraph:SceneGraph, window:Window):void
		{
			_sceneGraph = sceneGraph;
			_window = window;
		}
		
		/**
		 * Destructor
		 */
		public function destroy():void
		{
			_sceneGraph = null;
			_window = null;
		}		
		
		/**
		 * Render the frame
		 */
		public final function render():void
		{
			// Get the renderables array
			var renderables:Array = _sceneGraph.renderables;
			
			// Sort the renderables array (bigger numbers are closer to the screen) 
			renderables.sortOn( "comparator", Array.NUMERIC );
			
			_window.beginRendering();
			_window.surface.clear(0x00000000);
			
			// Render children in order
			for ( var i:int = 0; i < renderables.length; i++ )
			{
				renderables[i].render(_window.surface);
			}
			
			_window.endRendering();
		}
	}
}