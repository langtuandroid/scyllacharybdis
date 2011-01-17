package com.scyllacharybdis.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface IRenderComponent extends IComponent
	{
		function get comparator():Number;
		function render( surface:Backbuffer ):void
	}
	
}