<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.util.*"%>
<%request.setCharacterEncoding("UTF-8");%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
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
   /* if(sval.value.length == 0){
    alert("검색어를 입력해 주세요!!");
    sval.focus();
    return false;
   } */	
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
<%
	String cond = null;
	int what = 0;
	String val = "";
	boolean chkAll = false;
	
	if (request.getParameter("stype") != null && request.getParameter("sval")!="") {
		//검색옵션 파라메타 저장
		what = Integer.parseInt(request.getParameter("stype"));
		val = request.getParameter("sval");
		//옵션에 따라 query문의 조건절을 완성하고 select의 내용을 완성
		switch(what){
			case 1: 
				cond = " where name like '%" + val + "%'";
				break;
			case 2: 
				cond = " where subject like '%" + val + "%'";
				break;
			case 3:
				cond = " where content  like '%" + val + "%'";
				break;
			case 4:
				cond = " where name  like '%" + val + "%'";
				cond = cond + " or  subject  like '%" + val + "%'";
				break;
			case 5: 
				cond = " where name  like '%" + val + "%'";
				cond = cond + " or  content  like '%" + val + "%'";
				break;
			case 6: 
				cond = " where subject  like '%" + val + "%'";
				cond = cond + " or  content  like '%" + val + "%'";
				break;
			case 7:
				cond = " where name  like '%" + val + "%'";
				cond = cond + " or  subject  like '%" + val + "%'";
				cond = cond + " or  content  like '%" + val + "%'";
				break;
			default:
				chkAll = true;
				cond = " order by masterid desc, replynum, step, id";
		}
	} else {
		chkAll = true;
		cond = " order by masterid desc, replynum, step, id";
	}
%>
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
		
		sql="select * from freeboard" + cond;
		if(!chkAll)
			sql = sql + " order by id desc";
		
		st = con.createStatement();
		rs = st.executeQuery(sql);
		
		if(!(rs.next())) {
			out.println("등록된 글이 없습니다. <br>");
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
		out.print("[<A href=freeboard_list_search.jsp?gogroup=1"); 
		  out.print("&stype="+ what+"&sval=" + val +">처음</A>]");
		  out.print("[<A href=freeboard_list_search.jsp?gogroup="+priorgroup);
		  out.print("&stype="+ what+"&sval=" + val +">이전</A>]");
	} else {
		out.println("[처음]");
		out.println("[이전]");
	}
	//*****추가********
	//페이지 번호를 출력
	for(int jj=startpage; jj<=endpage; jj++){
		if(jj==where)
			out.println("["+jj+"]");
		else{
			out.print("[<A href=freeboard_list_search.jsp?go="+jj);
		    out.print("&stype="+ what+"&sval=" + val +">" + jj + "</A>]") ;
		}
	}
	//***************
	
	//현재페이지가 마지막 페이지가 아닐경우
	if (wheregroup < totalgroup) {
		 out.print("[<A href=freeboard_list_search.jsp?gogroup="+ nextgroup);
		  out.print("&stype="+ what+"&sval=" + val +">다음</A>]");
		  out.print("[<A href=freeboard_list_search.jsp?gogroup="+totalgroup); 
		  out.print("&stype="+ what+"&sval=" + val +">마지막</A>]");
	} else {
		out.println("[다음]");
		out.println("[마지막]");
	}
	out.println(where + "/" + totalpages);
	out.println("검색된 글 수 :"+totalrows);
	
%>

<FORM method="post" name="msgsearch" action="freeboard_list_search.jsp">
<TABLE border=0 width=100% cellpadding=0 cellspacing=0>
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
   </SELECT>
  </TD>
  <TD width="127" align="center">
   <INPUT type=text size="17" name="sval" value="<%=val%>" >
  </TD>
  <TD width="115">&nbsp;<a href="#" onClick="check();"><img src="image/serach.gif" border="0" align='absmiddle'></A></TD>
  <TD align=right valign=bottom width="117">
  	<A href="freeboard_list_search.jsp">[전체목록]</A>
  	<A href="freeboard_write.html">[글쓰기]</A>
  </TD>
 </TR>
</TABLE>
</FORM>
</div>

<script>
	document.msgsearch.stype.options[<%=what-1%>].selected = true; 
</script>

</body>
</html>