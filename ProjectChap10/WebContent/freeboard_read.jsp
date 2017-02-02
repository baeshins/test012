<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.util.*"%>
<% request.setCharacterEncoding("UTF-8");%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	int id = Integer.parseInt(request.getParameter("id"));
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	String sql=null;
	
	String DRIVER = "com.mysql.jdbc.Driver";
	String url="jdbc:mysql://localhost:3306/fboard";
	String uid="teacher";
	String upw="1234";

	try {
		Class.forName(DRIVER);
		con=DriverManager.getConnection(url, uid, upw);
		System.out.println("DB 접속 완료");
		
		sql="select * from freeboard where id=?";
		ps = con.prepareStatement(sql);
		ps.setInt(1, id);
		rs = ps.executeQuery();
		out.println("<h3>글읽기</h3>");
		if (!(rs.next())) {
			out.println("해당 내용이 없습니다");
		} else {
			out.println("<hr>");
			out.println("제목 : " + rs.getString("subject") + "<br>");
			out.println("글쓴이 : " + rs.getString("name") + "<br>");
			out.println("작성일 : " + rs.getString("inputdate") + "<br>");
			out.println("조회 : " + rs.getString("readcount") + "<br>");
			out.println("<hr>");
			out.println("<pre>" + rs.getString("content") + "</pre><br>");
			out.println("<hr>");
			out.println("<a href='freeboard_list.jsp?go="+ request.getParameter("page") + "'>[목록]</a>  ");
			out.println("<a href='freeboard_update.jsp?id="+id+"&page="+ request.getParameter("page")+ "'>[수정]</a> ");
			out.println("<a href='freeboard_rwrite.jsp?id="+id+"&page="+ request.getParameter("page")+ "'>[답글]</a> ");
			
			sql = "update freeboard set readcount= readcount + 1 where id= ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ps.executeUpdate();
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs!=null) rs.close();
			if(ps!=null) ps.close();
			if(con!=null) con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>
</body>
</html>