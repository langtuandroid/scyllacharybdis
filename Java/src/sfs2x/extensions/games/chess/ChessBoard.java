package sfs2x.extensions.games.chess;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.smartfoxserver.v2.entities.data.ISFSArray;
import com.smartfoxserver.v2.entities.data.SFSArray;

public class ChessBoard {
	
	private Map<String, Long> mBoard  = new HashMap<String, Long>();
	
	public ChessBoard() 
	{
		InitializeBoard();
		ResetBoard();
	}
	
	public void InitializeBoard() {
		mBoard.put("whitePieces", (long) 255);
		mBoard.put("blackPieces", (long) 255 >>> 4);
	}
	
	public void ResetBoard() 
	{
		mBoard.put("whitePieces", (long) 255);
		mBoard.put("blackPieces", (long) 255 >>> 4);
	}
	
	public ISFSArray GetBoardArray() 
	{
		ISFSArray boardArray = new SFSArray();
		
		Iterator<String> iterator = mBoard.keySet().iterator();
		while( iterator.hasNext() ) {
		  String key   = iterator.next();
		  Long value = mBoard.get(key);
		  boardArray.addLong(value);
		}
		return boardArray;
	}

	public ISFSArray GetPredictionsArray()
	{
		ISFSArray predictionsArray = new SFSArray();
		for ( int i = 0; i < 16; i++ ) {
			predictionsArray.addLong((long) 0);
		}
	}
}
