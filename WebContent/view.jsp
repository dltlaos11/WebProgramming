<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<meta name="viewport" content="width=device-width" >
<link rel="stylesheet">
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="footer.css">
<link rel="stylesheet" href="hero.css">
<style>
table {
width:70%
}
</style>

<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<div class="wrap">
		<header>
			<a href="index.html" class="Logo">Recipe?</a> <a href="login.jsp"
				class="login">Login</a>
			<nav class="gnb-menu">
				<ul>
					<li><a href="bbs.jsp">Community</a></li>
					<li><a href="introduction.html">Introduce</a></li>
				</ul>
			</nav>
		</header>

		<table align="center" height="100">
			<tr>
				<td>
					<div id="main" onclick="location.href='index.html'"></div>
				</td>
			</tr>
		</table>
</div>
<section class="hero2">
     <h1 class="hero__title">Online Community</h1>
</section>
  <%
  	String userID = null;
  	if (session.getAttribute("userID") != null) {
  		userID = (String) session.getAttribute("userID");
  	}
  	int bbsID = 0;
  	if (request.getParameter("bbsID") != null) {
  		bbsID = Integer.parseInt(request.getParameter("bbsID"));
  	}
  	if (bbsID == 0) {
  		PrintWriter script = response.getWriter();
  		script.println("<script>");
  		script.println("alert('유효하지 않는 글입니다.')");
  		script.println("location.href = 'bbs.jsp'");
  		script.println("history.back()");
  		script.println("</script>");
  	}
  	Bbs bbs = new BbsDAO().getBbs(bbsID);

  %>
  <center>
  <br><br>
	<div>
			<table style="text-align: center; border: 7px solid pink">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글보기</th>						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글제목</td>
						<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분 " %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></td>
						<!-- 웹보안에서 좋은 -->
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp">목록</a>
			<%
				if (userID != null && userID.equals(bbs.getUserID())) {
			%>
					<a href="update.jsp?bbsID=<%= bbsID %>">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>">삭제</a>
			<%
				}
			%>		
	</div>
	</center>
		<footer>
			<h2 class="footerLogo">Recipe</h2>
			<ul>
				<li>대표자 이현수 | 충청남도 아산시 배방읍 호서로 79번길 20</li>
				<li>사업자등록번호:123-12-12345 | 이메일:hslo1@naver.com</li>
			</ul>
			<div class="box">
				<h2>
					세상의 모든 레시피가 있다.<br> For Your Happy Recipe
				</h2>
			</div>
		</footer>
</body>
</html>