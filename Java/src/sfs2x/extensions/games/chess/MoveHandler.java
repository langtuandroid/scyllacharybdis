package sfs2x.extensions.games.chess;

import sfs2x.extensions.games.chess.SFSChess;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;

public class ReadyHandler extends BaseClientRequestHandler
{
	@Override
	public void handleClientRequest(User user, ISFSObject params)
	{
		SFSChess gameExt = (SFSChess) getParentExtension();
		
		if ( !user.isPlayer() ) {
			return ;
		}
	
		if ( getWhoseTurn() != user ) {
			return ;
		}

		if ( ! gameExt.isStarted() ) {
			
		}

		String to = params.getString("to");
		String from = params.getString("from");
		
		gameExt.move(to, from); 
		
	}
}