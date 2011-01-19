package com.scyllacharybdis.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface IBaseComponent 
	{
		function awake( owner:* ):void;
		function update():void;
		function destroy():void;
	}
	
}