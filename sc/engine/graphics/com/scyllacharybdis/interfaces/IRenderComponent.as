package com.scyllacharybdis.interfaces 
{
	import com.scyllacharybdis.graphics.rendering.Backbuffer;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IRenderComponent extends IBaseComponent
	{
		function get comparator():Number;
		function render( surface:Backbuffer ):void
	}
	
}