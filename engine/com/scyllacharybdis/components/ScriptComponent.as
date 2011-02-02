package com.scyllacharybdis.components 
{
	import adobe.utils.CustomActions;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import com.scyllacharybdis.core.objects.BaseObject;
	import com.scyllacharybdis.core.objects.ComponentObject;
	import com.scyllacharybdis.core.objects.GameObject;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	/**
	 */
	[Component (type="ScriptComponent")]
	public class ScriptComponent extends ComponentObject
	{
		/** 
		 * Engine constructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			super.engine_awake();
		}
		
		/** 
		 * Engine start
		 * @private
		 */
		public final override function engine_start():void
		{
			super.engine_start();
		}
		
		/** 
		 * Engine stop
		 * @private
		 */
		public final override function engine_stop():void
		{
			super.engine_stop();
		}

		/** 
		 * Engine destructor
		 * @private
		 */
		public final override function engine_destroy():void
		{
			super.engine_destroy();
		}

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
		 * The users update method. 
		 * @param	event
		 */
		public override function update(event:TimerEvent):void
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
			//trace( "clicked" );
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