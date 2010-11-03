package sfs2x.extensions.games.chess;

import sfs2x.extensions.games.chess.ReadyHandler;
import sfs2x.extensions.games.chess.ChessBoard;
//import sfs2x.extensions.games.chess.MoveHandler;
//import sfs2x.extensions.games.chess.OnUserGoneHandler;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.SFSExtension;

public class SFSChess extends SFSExtension {

	private final String version = "0.5";
	private ChessBoard mGameBoard;
	private volatile boolean mGameStarted;
	private User mWhoseTurn;
	
	
	@Override
	public void init() {
		trace("SFSChess Extension started, rel. " + version);
		
		mGameBoard = new ChessBoard();

	    addRequestHandler("ready", ReadyHandler.class);
	    //addRequestHandler("move", MoveHandler.class);
	    
	    //addEventHandler(SFSEventType.USER_DISCONNECT, OnUserGoneHandler.class);
	    //addEventHandler(SFSEventType.USER_LEAVE_ROOM, OnUserGoneHandler.class);
	}

	boolean isGameStarted()
	{
		return mGameStarted;
	}
	
	User getWhoseTurn()
    {
	    return mWhoseTurn;
    }
	
	void setTurn(User user)
	{
		mWhoseTurn = user;
	}
	
	public void startGame() 
	{
		if (mGameStarted) 
		{
			throw new IllegalStateException("Game is already started!");
		}

		mGameStarted = true;
		mGameBoard.ResetBoard();
		
		User player1 = getParentRoom().getUserByPlayerId(1);
		User player2 = getParentRoom().getUserByPlayerId(2);
		
		// No turn assigned? Let's start with player 1
		if (mWhoseTurn == null)
			mWhoseTurn = player1;
		
		// Send START event to client
		ISFSObject resObj = new SFSObject();
		
		// Send who's turn it is
		resObj.putInt("turn", mWhoseTurn.getPlayerId());
		
		// Send player 1s information
		resObj.putUtfString("player1Name", player1.getName());
		resObj.putInt("player1Id", player1.getId());
		
		// Send player 2s information
		resObj.putUtfString("player2Name", player2.getName());
		resObj.putInt("player2Id", player2.getId());
		
		// Send information to all the clients
		send("start", resObj, getParentRoom().getUserList());		
	}
}	
