<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="freeboard.js"></script>
<title>글 수정</title>
</head>
<body>
<%
	String sql=null;
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;
	
	int cnt = 0;
	int id = Integer.parseInt(request.getParameter("id"));
	String p = request.getParameter("page");
	
	String url = "jdbc:mysql://localhost:3306/fboard";
	String uid = "teacher";
	String upw = "1234";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
	}catch(ClassNotFoundException e){
		out.println(e);
	}
	
	try{
		con=DriverManager.getConnection(url,uid,upw);
		sql = "select * from freeboard where id="+id;
		st = con.createStatement();
		rs = st.executeQuery(sql);
		if(!(rs.next())){
			out.println("해당 내용이없습니다");
		} else {
%>
	<h3>글 수정</h3>
	<hr>
	<form name="msgwrite" method="post" action="freeboard_updatedb.jsp?id=<%=id%>&page=<%=p%>">
	       이 &nbsp;름 : <input type="text" name="name" value="<%=rs.getString("name")%>"><br>
		E-mail : <input type="text" name="email" value="<%=rs.getString("email")%>"><br>
		제 &nbsp;목 : <input type="text" name="subject" value="<%=rs.getString("subject")%>"><br>
		내 &nbsp;용 : <br><textarea rows="10" cols="60" name="content"><%=rs.getString("content") %></textarea><br>
		암 &nbsp;호 : <input type="password" name="password">
		       (비밀번호를 입력하면 수정 또는 삭제가 가능합니다.)<br>
		<hr>
<!-- 		<input type="submit" value="저장"> --> 
		<input type="button" value="저장" onclick="check();"> 
		<input type="reset" value="취소"> 
		<input type="button" value="삭제" onclick="pwcheck(<%=id%>,<%=p%>);"> 
	    <a href="freeboard_list.jsp?go=<%=request.getParameter("page")%>">목록</a>
	</form>
<%		}
	} catch(Exception e){
		e.printStackTrace();
	} finally {
		try{
			if(rs!=null) rs.close();
			if(st!=null) st.close();
			if(con!=null) con.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%>	
</body>
</html>