<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet">
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="footer.css">
<link rel="stylesheet" href="hero.css">

<title>레시피가 필요해?</title>
<style>
table {
width:70%
}
</style>
</head>
<body>
<div class="wrap">
	<header>
    <a href="index.html" class="Logo">Recipe?</a>
    <a href="login.jsp" class="login">Login</a>
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
	%>
		<center>
		<br><br>
	<div>
			<form method="post" action="writeAction.jsp">
				<table style="text-align: center; border: 7px solid pink">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판
								글쓰기 양식</th>

						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input  tpye="text" placeholder="글 제목" name="bbsTitle" maxlegth="50"></td>
						</tr>
						<tr>
							<td><textarea placeholder="글 내용" name="bbsContent" maxlegth="2048" style="width:1310px; height: 350px"></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" value="글 쓰기">
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