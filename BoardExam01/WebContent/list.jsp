<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,board.DO.*"%>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="list" scope="request" class="java.util.ArrayList" />
<body>
<table width="500" cellpadding="0" cellspacing="0" border="1">
		<tr>
			<td>번호</td>
			<td>이름</td>
			<td>제목</td>
			<td>날짜</td>
			<td>히트</td>
		</tr>
		
		   <%
				for(BoardDto  dto : (ArrayList<BoardDto>)list) {
			%>	
		<tr>
			<td><%=dto.getId() %></td>
			<td><%=dto.getName() %></td>
			<td>
				
				<a href="content_view.do?bId=<%=dto.getId() %>"><%=dto.getTitle() %></a></td>
			<td><%=dto.getDate() %></td>
			<td><%=dto.getHit() %></td>
		</tr>
		 <%
				}
		%>
		<tr>
			<td colspan="5"> <a href="write_view.do">글작성</a> </td>
		</tr>
	</table>
	
</body>
</html>