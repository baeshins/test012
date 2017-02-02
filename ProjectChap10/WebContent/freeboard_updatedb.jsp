<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.util.*, java.text.*"%>
<% 
	request.setCharacterEncoding("UTF-8");

	int id 	= Integer.parseInt(request.getParameter("id"));
	int ppage 	= Integer.parseInt(request.getParameter("page"));
	
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
			out.println("해당 DATA가 존재하지 않습니다.");
		} else {
			String pwd = rs.getString("password");
			
			if(pwd.equals(request.getParameter("password"))) {
				sql = "update freeboard set name=?, email=?, subject=?, content=? where id=?";
				ps = con.prepareStatement(sql);
				ps.setString(1,request.getParameter("name"));
				ps.setString(2,request.getParameter("email"));
				ps.setString(3,request.getParameter("subject"));
				ps.setString(4,request.getParameter("content"));
				ps.setInt(5,id);
				
				result=ps.executeUpdate();
			} else {
				//out.println("비밀번호가 틀립니다");
				out.println("<script>alert('비밀번호가 틀립니다.');</script>");
				out.println("<script>history.go(-1);</script>");
			}  //end if
		}//end if
	} catch (Exception e) {
		e.printStackTrace();
	
	 } finally {
		try {
			if(rs!=null) rs.close();
			if(st!=null) st.close();
			if(ps!=null) ps.close();
			if(con!=null) con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	if(result>0){
		out.println("데이터가 성공적으로 수정되었습니다."+"<br>");%>
		<jsp:forward page="freeboard_list.jsp"></jsp:forward>
	<% }	else {
		//out.println("데이터가 수정되지 않았습니다."+"<br>");
		out.println("<script>alert('데이터가 수정되지 않았습니다.');</script>");
	    out.println("<script>history.go(-1);</script>");
	}%> 
<!-- <a href="freeboard_list.jsp">목록보기</a> -->
<%-- <jsp:forward page="freeboard_list.jsp"></jsp:forward> --%>