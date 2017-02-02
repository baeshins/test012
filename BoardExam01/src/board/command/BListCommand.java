package board.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.DO.BoardDao;
import board.DO.BoardDto;

public class BListCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
		BoardDao dao = new BoardDao();
		ArrayList<BoardDto> dtos = dao.list();
		request.setAttribute("list", dtos);
	}
}