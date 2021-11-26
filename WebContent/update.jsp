<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet">
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="footer.css">
<link rel="stylesheet" href="hero.css">

<title>JSP 게시판 웹 사이트</title>
<style>
table {
	width: 70%
}
</style>
</head>
<body>
	<div class="wrap">
		<header>
			<a href="index.html" class="Logo">Recipe?</a> <a href="login.html"
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
	<%
		String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("history.back()");
		script.println("</script>");
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
	if (!userID.equals(bbs.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
	<section class="hero2">
		<h1 class="hero__title">Online Community</h1>
	</section>
	<center>
		<br>
		<br>
		<div>
			<form method="post" action="updateAction.jsp?bbsID=<%=bbsID%>">
				<table style="text-align: center; border: 7px solid pink">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">게시판
								글 수정 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" placeholder="글 제목" name="bbsTitle"
								maxlength="50" value="<%=bbs.getBbsTitle()%>"></td>
						</tr>
						<tr>
							<td><textarea placeholder="글 내용" name="bbsContent"
									maxlength="2048" style="width: 1310px; height: 350px"><%=bbs.getBbsContent()%></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" value="글수정">
			</form>
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