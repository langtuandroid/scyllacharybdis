package com.scyllacharybdis.components 
{
	import adobe.utils.CustomActions;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import com.scyllacharybdis.interfaces.IScriptComponent;
	import com.scyllacharybdis.objects.GameObject;
	import flash.utils.Dictionary;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	/**
	 */
	public class ScriptComponent implements IScriptComponent
	{
		public function awake(owner:*):void
		{
		}

		/**
		 * The users update method. 
		 * @param	event
		 */
		public function update():void
		{
		}

		/**
		 * The users destructor. 
		 * Override destroy to clean up any variables or listeners.
		 */
		public function destroy():void
		{
		}
		
		/*
		 * Handler mouse down 
		 * Override to define your own behaviour
		 */
		public function onMouseDown( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler mouse up
		 * Override to define your own behaviour
		 */
		public function onMouseUp( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler click
		 * Override to define your own behaviour
		 */
		public function onClick( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler double click
		 * Override to define your own behaviour
		 */
		public function onDoubleClick( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler mouse move
		 * Override to define your own behaviour
		 */
		public function onMouseMove( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler mouse lost focus
		 * Override to define your own behaviour
		 */
		public function onMouseOut( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler mouse over
		 * Override to define your own behaviour
		 */
		public function onMouseOver( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler wheel mouse
		 * Override to define your own behaviour
		 */
		public function onMouseWheel( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler roll over
		 * Override to define your own behaviour
		 */
		public function onRollOver( e:MouseEvent ):void
		{
			
		}

		/*
		 * Handler roll out (Whatever that is)
		 * Override to define your own behaviour
		 */
		public function onRollOut( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler key down
		 * Override to define your own behaviour
		 */
		public function onKeyDown( e:KeyboardEvent ):void
		{
		}
		
		/*
		 * Handler key up
		 * Override to define your own behaviour
		 */
		public function onKeyUp( e:KeyboardEvent ):void
		{
		}
		
		/**
		 * A colision has happened
		 * @param	obj (GameObject) The game object that you colided with
		 */
		public function onBeginContact( obj:GameObject ):void
		{
		}

		/**
		 * A colision has stoped
		 * @param	obj (GameObject) The game object that you colided with
		 */
		public function onEndContact( obj:GameObject ):void
		{
		}
	}
}