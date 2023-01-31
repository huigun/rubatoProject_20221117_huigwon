<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>클래식기타 커뮤니티</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/footer.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/board_left.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/board_view_main.css">
</head>
<body>
<% 
		String sessionId = (String) session.getAttribute("sessionId");
		
	%>
  <div id="wrap">
    <header> <!-- header 시작 -->
      <a href="index.html"><img id="logo" src="${pageContext.request.contextPath}/resources/img/logo.png"></a>
      <nav id="top_menu">
        HOME |
        <% if(sessionId == null) { %>
        	LOGIN
		<% } else { %>
			<a href="logOut">LOGOUT</a>
		<% } %>
         |
         <% if(sessionId == null) { %>
        	<a href="member_join">JOIN</a>
		<% } else { %>
			<a href="logOut">LEVEL 1</a>
		<% } %> |
           NOTICE
      </nav>
      <nav id="main_menu">
        <ul>
          <li><a href="board_list.html">자유게시판</a></li>
          <li><a href="#">기타 연주</a></li>
          <li><a href="#">공동 구매</a></li>
          <li><a href="#">연주회 안내</a></li>
          <li><a href="#">회원 게시판</a></li>
        </ul>
      </nav>
    </header> <!-- header 끝 -->
    <aside>
      <% if(sessionId == null) { %>
        	<article id="login_box"> <!-- login box 시작 -->
        <img id="login_title" src="${pageContext.request.contextPath}/resources/img/ttl_login.png">
        <form action="loginOk">
        <div id="input_button">
          <ul id="login_input">
            <li><input type="text" name="mid"></li>
            <li><input type="password" name="mpw"></li>
          </ul>
          <input type="image" id="login_btn" src="${pageContext.request.contextPath}/resources/img/btn_login.gif">
        </div>
        </form>
        <div class="clear"></div>
        <div id="join_search">
          <a href="member_join"><input type="image" src="${pageContext.request.contextPath}/resources/img/btn_join.gif" ></a>
          <img src="${pageContext.request.contextPath}/resources/img/btn_search.gif">
        </div>
      </article> <!-- login box 끝 -->
		<% } else {  %>
		
		<article id="login_box"> <!-- login box 시작 -->
        <img id="login_title" src="${pageContext.request.contextPath}/resources/img/ttl_login.png">
        <form action="loginOk">
        <div id="input_button">
        </div>
        </form>
        <div class="clear"></div>
        <div id="join_search">
        <br><%=sessionId%>님 로그인 중 입니다.
        <a href="logOut">로그아웃</a>
        </div>
      </article> <!-- login box 끝 -->
		<% } %>
      <nav id="sub_menu"> <!-- 서브 메뉴 시작 -->
        <ul>
          <li><a href="board_list.html">+ 자유 게시판</a></li>
          <li><a href="#">+ 방명록</a></li>
          <li><a href="#">+ 공지사항</a></li>
          <li><a href="#">+ 등업 요청</a></li>
          <li><a href="#">+ 포토갤러리</a></li>
        </ul>
      </nav> <!-- 서브 메뉴 끝 -->
      <article id="sub_banner">
        <ul>
          <li><img src="${pageContext.request.contextPath}/resources/img/banner1.png"></li>
          <li><img src="${pageContext.request.contextPath}/resources/img/banner2.png"></li>
          <li><img src="${pageContext.request.contextPath}/resources/img/banner3.png"></li>
        </ul>
      </article>
    </aside>
    <main>
      <section id="main">
        <img src="${pageContext.request.contextPath}/resources/img/comm.gif">
        <h2 id="board_title">자유게시판</h2>
        <div id="view_title_box">
          <span id="boardTitle">${dto.rfbtitle}</span>
          <span id="info">작성자 : ${dto.rfbname}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;조회수 : ${dto.rfbhit}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;작성일 : ${dto.rfbdate}</span>
        </div>
        <p id="view_content">
          ${dto.rfbcontent}
        </p>
      <form action="replyOk">
        	<input type="hidden" name="rfbnum" value="${dto.rfbnum } ">
        	

        	<p id="file_info">
        	|첨부된 파일 | <a href="${pageContext.request.contextPath}/resources/uploadfiles/${filedto.filename}">
        	<hr>${filedto.fileoriname }
        	</a>
        	</p>
			<c:if test="${filedto.fileextension =='jpg' or filedto.fileextension =='bmp' or filedto.fileextension =='gif' or filedto.fileextension =='png'}">
				<img width="300" src="${pageContext.request.contextPath }/resources/uploadfiles/${filedto.filename}">
			</c:if>
			
        	<hr>|댓글|<hr>
        	<!-- 댓글 리스트 시작-->
       
        	<c:forEach items="${rrlist}" var="rr">
        	<table border="1" cellpadding="1" cellspacing="0" width="750">
        		<tr>
        			<td width="100">
        				${rr.rrid }
        			</td>
        			<td width="500">
        				${rr.rrcontent } <br><br>
        				${rr.rrdate }
        			</td>
        			<td>

        	<input type="hidden" name="rrnum" value="${rr.rrnum }">
        	<input type="button" value="X" onclick="location.href='rrdelete?rrnum=${rr.rrnum }&rfbnum=${dto.rfbnum }'">  
	     			</td>
        		</tr>
        	</table>
        	</c:forEach>
      	
        	<!-- 댓글 리스트 끝 -->
        	
        	<!-- 댓글 입력란 시작 -->
        	<div id="comment_box">
          	<img id="title_comment" src="${pageContext.request.contextPath}/resources/img/title_comment.gif">
         	 <textarea name="rrcontent"></textarea>
         	 <input type="image" id="ok_ripple" src="${pageContext.request.contextPath}/resources/img/ok_ripple.gif">
        	</div>
      </form>
      <!--  댓글 입력란 끝 -->
        <div id="buttons">
        <form action="delete">
   		<input type="hidden" name="rfbnum" value="${dto.rfbnum }">
          <input type="image" src="${pageContext.request.contextPath}/resources/img/delete.png">
          </form>
          <a href="board_list.html"><img src="${pageContext.request.contextPath}/resources/img/list.png"></a>
          <a href="board_write.html"><img src="${pageContext.request.contextPath}/resources/img/write.png"></a>
        </div>
        
      </section> <!-- section main 끝 -->
    </main>
    <div class="clear"></div>
    <footer> <!-- footer 시작 -->
      <img id="footer_logo" src="${pageContext.request.contextPath}/resources/img/footer_logo.gif">
      <ul id="address">
        <li>서울시 강남구 삼성동 1234 (우) : 123-1234</li>
        <li>TEL : 02-1234-1234 Email : abc@abc.com</li>
        <li id="copyright">COPYRIGHT(C) 루바토 ALL RIGHTS RESERVED</li>
      </ul>
      <ul id="footer_sns">
        <li><img src="${pageContext.request.contextPath}/resources/img/facebook.gif"></li>
        <li><img src="${pageContext.request.contextPath}/resources/img/blog.gif"></li>
        <li><img src="${pageContext.request.contextPath}/resources/img/twitter.gif"></li>
      </ul>
    </footer> <!-- footer 끝 -->
  </div>
</body>
</html>