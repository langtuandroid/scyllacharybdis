package com.scyllacharybdis.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface IComponent 
	{
		function awake( owner:* ):void;
		function update():void;
		function destroy():void;
	}
	
}