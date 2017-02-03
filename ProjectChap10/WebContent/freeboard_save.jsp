<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.util.*, java.text.*"%>
<% 
	request.setCharacterEncoding("UTF-8");

	String name 	= request.getParameter("name");
	String email 	= request.getParameter("email");
	String subject 	= request.getParameter("subject");
	String content 	= request.getParameter("content");
	String password = request.getParameter("password");
	
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-dd h:mm a");
	String ymd = myformat.format(yymmdd);
		
	int id=1;
	
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
		
		sql = "select max(id) from freeboard";
		st = con.createStatement();
		rs = st.executeQuery(sql);
		
		if(!(rs.next())){
			id = 1;
		} else {
			id = rs.getInt(1) + 1;  //max id를 받아서  +1해서 현재저장할 id를 생성
			st.close();
			rs.close();
		}
	
		sql="insert into freeboard values (?,?,?,?,?,?,?,?,0,0,0)";
		ps = con.prepareStatement(sql);
		ps.setInt(1,id);
		ps.setString(2,name);
		ps.setString(3,password);
		ps.setString(4,email);
		ps.setString(5,subject);
		ps.setString(6,content);
		ps.setString(7,ymd);
		ps.setInt(8,id);
		
		result = ps.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
	
	 } finally {
		try {
			if(ps!=null) ps.close();
			if(con!=null) con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	if(result>0)
		out.println("데이터가 성공적으로 입력되었습니다."+"<br>");
	else
		out.println("데이터가 입력되지 않았습니다."+"<br>");
%>
<a href="freeboard_write.html">새글쓰기</a>
<jsp:forward page="freeboard_list_search.jsp"></jsp:forward>