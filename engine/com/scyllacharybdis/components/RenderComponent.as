package com.scyllacharybdis.components
{
	import com.scyllacharybdis.core.objects.BaseObject;
	import com.scyllacharybdis.core.objects.ComponentObject;
	import com.scyllacharybdis.core.rendering.Backbuffer;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import org.casalib.math.geom.Point3d;
	
	/**
	 * 
	 */
	[Component (type="RenderComponent")]
	public class RenderComponent extends ComponentObject
	{
		/**
		 * The users constructor. 
		 * Override awake and create any variables and listeners.
		 */
		public override function awake():void
		{
		}
		
		/**
		 * The users start method. 
		 * Start runs when the game object is added to the scene.
		 */
		public override function start():void
		{
		}

		/**
		 * The users stop method.
		 * Stop runs when the game object is added to the scene.
		 */
		public override function stop():void
		{
		}

		/**
		 * The users destructor. 
		 * Override destroy to clean up any variables or listeners.
		 */
		public override function destroy():void
		{
		}
		
		/**
		 * Get the comparator used for sorting
		 * @private
		 */ 
		public function get comparator():Number { return owner.position.z }
		

		/**
		 * Add the renderable to the surface
		 * @param	surface (DisplayObjectContainer) 
		 */
		public function render( surface:Backbuffer ):void
		{
		}
	}
}