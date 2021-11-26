<%
	request.setCharacterEncoding("utf-8");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<link rel="stylesheet" href="style.css"> 
<link rel="stylesheet" href="footer.css">
<link rel="stylesheet" href="join.css">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 뷰포트 -->

<meta name="viewport" content="width=device-width">

<!-- 스타일시트 참조  -->

<title>레시피가 필요해?</title>

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
</div>
			<div class="wrap">
         <div class="form-wrap" style="padding-top: 20px;">
            <form method="post" action="joinAction.jsp" class="input-group">
               <div>
                  <input type="text" class="form-control" placeholder="아이디"
                     name="userID" maxlength="20">
               </div>
               <div>
                  <input type="password" class="form-control" placeholder="비밀번호"
                     name="userPassword" maxlength="20">
               </div>
               <div>
                  <input type="text" class="form-control" placeholder="이름"
                     name="userName" maxlength="20">
               </div>
               <div style="text-align: center;">
               </div>
               <div>
                  <input type="email" class="form-control" placeholder="이메일"
                     name="userEmail" maxlength="20">
               </div>
               <div data-toggle="buttons">
                     <label> <input
                        type="radio" name="userGender" autocomplete="off" value="남자"
                        checked>남자
                     </label>
                  </div>
                  <div data-toggle="buttons">
                     <label> <input type="radio"
                        name="userGender" autocomplete="off" value="여자" checked>여자
                     </label>
                  </div>
               <button class="submit">회원가입</button>
            </form>
         </div>
   </div>
	<footer>
  <h2 class="footerLogo">Recipe</h2>
    <ul>
      <li>대표자 이현수 | 충청남도 아산시 배방읍 호서로 79번길 20</li>
      <li>사업자등록번호:123-12-12345 | 이메일:hslo1@naver.com</li>
    </ul>
  <div class="box">
    <h2>세상의 모든 레시피가 있다.<br>
    For Your Happy Recipe</h2>
  </div>
</footer>

</body>

</html>



