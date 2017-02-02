package board.DO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BoardDao {

	DataSource ds ;
	Connection con = null;
	PreparedStatement ps = null;
	
	public BoardDao() {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
			System.out.println("Driver 로딩완료");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	void connect() {
		try {
			con = ds.getConnection();
			System.out.println("DB 연결 완료");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	void disConnect() {
		try {
			ps.close();
			con.close();
			System.out.println("연결 해제 완료");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<BoardDto> list() {
		connect();
		
		ArrayList<BoardDto> dtos = new ArrayList<BoardDto>();
		ResultSet resultSet = null;
		
		try {
			con = ds.getConnection();
			
			String query = "select * from mvc_board";
			ps = con.prepareStatement(query);
			resultSet = ps.executeQuery();
			
			while (resultSet.next()) {
				int id = resultSet.getInt("id");
				String name = resultSet.getString("name");
				String title = resultSet.getString("title");
				String content = resultSet.getString("content");
				Timestamp date = resultSet.getTimestamp("date");
				int hit = resultSet.getInt("hit");
				int group = resultSet.getInt("group");
				int step = resultSet.getInt("step");
				int indent = resultSet.getInt("indent");
				
				BoardDto dto = new BoardDto(id, name, title, content, date, hit, group, step, indent);
				dtos.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnect();
		}
		return dtos;
	}
	
}
