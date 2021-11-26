<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html"  charset="UTF-8">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="footer.css">
<link rel="stylesheet" href="hero.css">

<title>JSP 게시판 웹 사이트</title>
<style>
table {
width:70%
}
</style>
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
     <h1 class="hero2__title">Online Community</h1>
</section>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber=1;//기본페이지 1
		if(request.getParameter("pageNumber") !=null){
			pageNumber=Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
		<center>
		<br>
		<br>
		<div>
			<table style="text-align: center; border: 7px solid pink" border-collapse:collapse;>
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					for (int i = 0; i < list.size(); i++) {
				%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분 " %></td>
					</tr>
					<%		
					}
				%>
				</tbody>
			</table>
			<%
			if (pageNumber != 1) {
		%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>"
				>이전</a>
			<%
			} if (bbsDAO.nextPage(pageNumber + 1)) {
		%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>"
				>다음</a>
			<%
			}
		%>
			<a href="write.jsp">글쓰기</a>
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