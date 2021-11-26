<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport">
<title>로그인</title>
<link href="login.css" rel="stylesheet" type="text/css" />
<link href="header.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="footer.css">
<!-- 뷰포트 -->

<meta name="viewport" content="width=device-width">

<!-- 스타일시트 참조  -->
<title>jsp 게시판 웹사이트</title>

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
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber=1;
		if(request.getParameter("pageNumber") !=null){
			pageNumber=Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<div>
		<%
				if (userID == null) {
			%>

		<!-- 로그인 폼 -->
		<div>
			<div style="padding-top: 20px;">
				<!-- 로그인 정보를 숨기면서 전송post -->
				<form method="post" action="loginAction.jsp">

					<div class="wrap">
						<center>
							<div class="form-wrap">

								<form id="login" action="" class="input-group">

									<input type="text" class="input-field" placeholder="아이디를 입력하시오"
										name="userID" required> <input type="password"
										class="input-field" placeholder="비밀번호를 입력하시오"
										name="userPassword" required>
									<div>
										<br> <a href="join.jsp">회원가입</a>
									</div>
									<br>
									<button class="submit">로그인</button>
								</form>
							</div>
						</center>
					</div>

				</form>
			</div>
		</div>
		<% 		
				} else {
			%><center>
		<ul>
			<li><a href="logoutAction.jsp"><%=userID %>님이 로그인 상태입니다 로그아웃
					하실건가요 ? </a></li>
		</ul>
		</center>
		<%		
				}
			%>

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



