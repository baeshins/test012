<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.util.*"%>
<%request.setCharacterEncoding("UTF-8");%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#wrap {
		width:800px;
		margin: 0 auto;
	}
	#title li{
		list-style-type: none;
		width:15%;
		float:left;
	}
	span{display:inline-block;}
	.va {width:10%; padding-left:1%;}
	.vb {width:41%;}
	.vc {width:16%;}

	a {text-decoration:none; }
	span a {color:darkgreen;}
</style>
<SCRIPT language="javascript">
 function check(){
  with(document.msgsearch){
   if(sval.value.length == 0){
    alert("검색어를 입력해 주세요!!");
    sval.focus();
    return false;
   }	
   document.msgsearch.submit();
  }
 }
 function rimgchg(p1,p2) {
  if (p2==1) 
   document.images[p1].src= "image/open.gif";
  else
   document.images[p1].src= "image/arrow.gif";
  }

 function imgchg(p1,p2) {
  if (p2==1) 
   document.images[p1].src= "image/open.gif";
  else
   document.images[p1].src= "image/close.gif";
 }
</SCRIPT>
</head>
<body>
<div id="wrap">
<h2>자유 게시판</h2>
<hr><br><br>
	<ul id="title">
		<li>번호</li>
		<li style="width:40%">제목</li>
		<li>등록자</li>
		<li>날짜</li>
		<li>조회</li>
	</ul>
	<hr size="2">
	
<%
	Vector dbid = new Vector();
	Vector name = new Vector();
	Vector inputdate = new Vector();
	Vector email = new Vector();
	Vector subject = new Vector();
	Vector rcount = new Vector();
	Vector step=new Vector();
	
	int where=1;  //현재 Page번호
	//*****추가*****
	int totalgroup=0;
	int maxpages=3;   //화면에 보여지는 최대 페이지번호수
	int startpage=1;  
	int endpage=startpage+maxpages-1;
	int wheregroup=1;
	
	if(request.getParameter("go") !=null){
		where = Integer.parseInt(request.getParameter("go"));
		wheregroup = (where-1)/maxpages +1;
		startpage = (wheregroup-1) * maxpages + 1;
		endpage = startpage + maxpages -1;
	} else if (request.getParameter("gogroup")!=null){
		wheregroup = Integer.parseInt(request.getParameter("gogroup"));
		startpage = (wheregroup-1) * maxpages + 1;
		where = startpage;
		endpage = startpage + maxpages -1;
	}
	
	int nextgroup = wheregroup + 1;
	int priorgroup = wheregroup - 1;
		
	
	/* if(request.getParameter("go") !=null)
		where = Integer.parseInt(request.getParameter("go")); */
	
	//*************
	int nextpage=where+1;
	int priorpage = where-1;
	int startrow=0; //현재 page에 보여줄 첫 레코드
	int endrow=0;   //현재 page에 보여줄 마지막 레코드
	int maxrows=5;  //한페이지에 보여줄 데이터(레코드) 갯수
	int totalrows=0;  //전체 데이터갯수
	int totalpages=0; //전제 페이지 수

	int id = 0;
	
	Connection con = null;
	Statement st = null;
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
		
		sql="select * from freeboard order by masterid desc, replynum, step, id";
		st = con.createStatement();
		rs = st.executeQuery(sql);
		
		if(!(rs.next())) {
			out.println("등록된 글이 없습니다.");
		} else {
			do{
				dbid.addElement(new Integer(rs.getInt("id")));
				name.addElement(rs.getString("name"));
				email.addElement(rs.getString("email"));
				String idate  = rs.getString("inputdate");
				idate = idate.substring(0,8);
				inputdate.addElement(idate);
				subject.addElement(rs.getString("subject"));
				rcount.addElement(new Integer(rs.getInt("readcount")));
				step.addElement(new Integer(rs.getInt("step")));
			}while(rs.next());
			
			totalrows=name.size(); //전제 데이터갯수
			//*전체페이지수 = 전체데이터수 / 한페이지에 보여줄최대데이터갯수
			//*if(전체데이터수 % 한페이지에 보여줄최대데이터갯수>0)면
			//*전체페이지수 1 증가시킴
			//totalpages=(totalrows-1)/maxrows +1;
			//totalpages=(totalrows/maxrows) +1; //오류
			
			totalpages= totalrows/maxrows;
			if(totalrows % maxrows > 0)
				totalpages++;
			
			startrow = (where-1) * maxrows;
			endrow = startrow + maxrows-1;
			if(endrow >= totalrows)
				endrow = totalrows-1; 
			//*****추가***** 
			totalgroup = totalpages / maxpages;
			if(totalpages % maxpages >0)
				totalgroup++;
			
			if(endpage > totalpages)
				endpage = totalpages;
			//**************
			for(int j=startrow; j<=endrow; j++){
				//id=totalrows-j;
				out.print("<span class='va'>"+dbid.elementAt(j)+"</span>");
				out.print("<span class='vb'>");
				int stepi= ((Integer)step.elementAt(j)).intValue();
			    int imgcount = j-startrow; 
			    if (stepi > 0 ) {
			     
				 for(int count=0; count < stepi; count++)
				      out.print("&nbsp;&nbsp;");
			     out.print("<IMG name=icon"+imgcount+ " src=image/arrow.gif>");
			     out.print("<A href=freeboard_read.jsp?id=");
			     out.print(dbid.elementAt(j) + "&page=" + where );
			     out.print(" onmouseover=\"rimgchg(" + imgcount + ",1)\"");
			     out.print(" onmouseout=\"rimgchg(" + imgcount + ",2)\">");
			    } else {
			     out.print("<IMG name=icon"+imgcount+ " src=image/close.gif>");
			     out.print("<A href=freeboard_read.jsp?id=");
			     out.print(dbid.elementAt(j) + "&page=" + where );
			     out.print(" onmouseover=\"imgchg(" + imgcount + ",1)\"");
			     out.print(" onmouseout=\"imgchg(" + imgcount + ",2)\">");
			    }
			    
				out.print("  "+ subject.elementAt(j) + "</a></span>");
				out.print("<span class='vc'>"+name.elementAt(j) + "</span>");
				out.print("<span class='vc'>"+inputdate.elementAt(j) + "</span>");
				out.print("<span class='va'>"+rcount.elementAt(j) + "</span><br>");
				out.print("<hr>");
			}
			
		}
	} catch (Exception e) {
		e.printStackTrace();
	
	 } finally {
		try {
			if(rs!=null) rs.close();
			if(st!=null) st.close();
			if(con!=null) con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//현재 페이지가 처음페이지가 아닐경우
	if (wheregroup > 1) {
		out.println("[<A href=\"freeboard_list.jsp?go=1\">처음</A>]");
		out.println("[<A href=\"freeboard_list.jsp?gogroup=" + priorgroup + "\">이전</A>]");
	} else {
		out.println("[처음]");
		out.println("[이전]");
	}
	//*****추가********
	//페이지 번호를 출력
	for(int jj=startpage; jj<=endpage; jj++){
		if(jj==where)
			out.println("["+jj+"]");
		else
			out.println("[<A href=\"freeboard_list.jsp?go=" + jj + "\">"+jj+"</A>]");
	}
	//***************
	
	//현재페이지가 마지막 페이지가 아닐경우
	if (wheregroup < totalgroup) {
		out.println("[<A href=\"freeboard_list.jsp?gogroup=" + nextgroup + "\">다음</A>]");
		out.println("[<A href=\"freeboard_list.jsp?gogroup=" + totalgroup + "\">마지막</A>]");
	} else {
		out.println("[다음]");
		out.println("[마지막]");
	}
	out.println(where + "/" + totalpages);
%>

<FORM method="post" name="msgsearch" action="freeboard_search.jsp">
<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
 <TR>
  <TD align=right width="241"> 
   <SELECT name=stype >
    <OPTION value=1 >이름
    <OPTION value=2 >제목
    <OPTION value=3 >내용
    <OPTION value=4 >이름+제목
    <OPTION value=5 >이름+내용
    <OPTION value=6 >제목+내용
    <OPTION value=7 >이름+제목+내용
   </SELECT>0
  </TD>
  <TD width="127" align="center">
   <INPUT type=text size="17" name="sval" >
  </TD>
  <TD width="115">&nbsp;<a href="#" onClick="check();"><img src="image/serach.gif" border="0" align='absmiddle'></A></TD>
  <TD align=right valign=bottom width="117"><A href="freeboard_write.htm"><img src="image/write.gif" border="0"></TD>
 </TR>
</TABLE>
</FORM>

<input type="button" value="글쓰기" onClick="location='freeboard_write.html'"/>
</div>
</body>
</html>