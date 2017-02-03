<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="freeboard_upd.js"></script>
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
	String url = "jdbc:mysql://localhost:3306/fboard"; //hkit부분 수정
	String uid = "root";
	String upw = "rootpw";
	
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
		}else{
%>
	<form name="msgwrite" method="post"
		action="freeboard_upddb.jsp?id=<%=id%>&page=<%=p%>">
		<table>
			<tr>
				<td colspan="2">글수정</td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name" id="myText"
					value="<%=rs.getString("name")%>"></td>
			</tr>
			<tr>
				<td>E-mail</td>
				<td><input type="email" name="email"
					value="<%=rs.getString("email")%>"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="subject"
					value="<%=rs.getString("subject")%>"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea cols="65" rows="10" name="content"
						maxlength="2000"><%=rs.getString("content") %></textarea></td>
			</tr>
			<tr>
				<td>암호</td>
				<td><input type="password" name="password">(비밀번호를 입력하면
					수정 또는 삭제가 가능합니다.)</td>
			</tr>
			<tr>
				<td><input type="button" value="저장" onClick="check();"></td>
				<td><input type="reset" value="취소"></td>
				<td><a
					href="freeboard_list.jsp?go=<%=request.getParameter("page")%>"></a></td>
			</tr>
		</table>
	</form>
	<%
		}
	}catch(SQLException e){
		out.println(e);
	}finally{
		try{
			rs.close();
			st.close();
			con.close();
		}catch(SQLException e){
			out.println(e);
		}
	}
	
%>
</body>
</html>