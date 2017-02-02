<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,java.util.*" %>
<%	request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="freeboard.js"></script>
</head>
<body>
<% 

	int pos=0;
	String sub=null;
	String cont=null;
	int step=0;
	int rnum=0;
	int mid=0;
	int id = Integer.parseInt(request.getParameter("id"));
	
	Connection con = null;
	Statement st = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	String sql=null;
	int result = 0;
	
	String DRIVER = "com.mysql.jdbc.Driver";
	String url="jdbc:mysql://localhost:3306/fboard";
	String uid="teacher";
	String upw="1234";

	try {
		Class.forName(DRIVER);
		con=DriverManager.getConnection(url, uid, upw);
		System.out.println("DB 접속 완료");
		
		sql = "select * from freeboard where id="+id;
		st = con.createStatement();
		rs = st.executeQuery(sql);
		
		if(!(rs.next())){
			out.println("해당 내용이 없습니다");
		} else {
			cont = ">" + rs.getString("content") ;
		   	while ((pos=cont.indexOf("\n", pos)) != -1) {
			    String left=cont.substring(0, pos+1);
			    String right=cont.substring(pos+1, cont.length());
			    cont = left + ">" + right;
			    pos += 2;
		   	}
		  	
		   	sub = "Re:" + rs.getString("subject");
		   	step = rs.getInt("step");
		   	mid = rs.getInt("masterid");                                     
		   	rnum = rs.getInt("replynum"); 
%>		   
			
		   

<h3>답글쓰기</h3>
	<hr>
	<form name="msgwrite" method="post" action="freeboard_rsave.jsp?id=<%=id%>&page=<%=request.getParameter("page")%>">
		이 &nbsp;름 : <input type="text" name="name"><br>
		E-mail : <input type="text" name="email"><br>
		제 &nbsp;목 : <input type="text" name="subject" value="Re :<%=rs.getString("subject")%>"><br>
		내 &nbsp;용 : <br><textarea rows="10" cols="60" name="content">




-------------------------------------------------
<%=cont%>
		</textarea><br>
		암 &nbsp;호 : <input type="password" name="password">
		       (비밀번호를 입력하면 수정 또는 삭제가 가능합니다.)<br>
<!-- 		<input type="submit" value="저장"> --> 
		<input type="button" value="저장" onclick="check();"> 
		<input type="reset" value="취소"> 
		<A href="freeboard_list.jsp?go=<%=request.getParameter("page") %>">목록</A>
		
		<INPUT type="hidden" name="step" value="<%=step%>">
   		<INPUT type="hidden" name="mid" value="<%=mid%>">
   		<INPUT type="hidden" name="rnum" value="<%=rnum%>">
	</form>
  
<%
	st.close();
			rs.close();
		}

	} catch (Exception e) {
		e.printStackTrace();

	} finally {
		try {
			if (ps != null)
				ps.close();
			if (con != null)
				con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>
</body>
</html>