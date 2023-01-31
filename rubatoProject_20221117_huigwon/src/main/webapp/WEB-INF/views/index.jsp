<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>클래식기타 커뮤니티</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/footer.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css">
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
		
		
      
      <article id="guestbook"> <!-- guestbook 시작 -->
        <div id="guestbook_title">
          <img src="${pageContext.request.contextPath}/resources/img/ttl_memo.gif">
        </div>
        <ul>
          <li>안녕하세요!</li>
          <li>안녕하세요!</li>
          <li>안녕하세요!</li>
          <li>안녕하세요!</li>
        </ul>
      </article> <!-- guestbook 끝 -->
    </aside>
    <main>
      <section id="main">
        <img src="${pageContext.request.contextPath}/resources/img/main_img.png">
        <section id="notice_free_youtube"> <!-- 공지사항/자유게시판/유투브 시작 -->
          <article id="notice"> <!-- 공지사항 -->
            <div class="latest_title">
              <img class="latest_img" src="${pageContext.request.contextPath}/resources/img/latest1.gif">
              <img class="more" src="${pageContext.request.contextPath}/resources/img/more.gif">
              <div class="clear"></div>
            </div>
            <div class="latest_content">
              <img class="image" src="${pageContext.request.contextPath}/resources/img/book_pen.gif">
              <ul class="list">
                <li>
                  <div class="subject">루바토 개편과 사이트 이용...</div>
                  <div class="date">2022-09-30</div>
                  <div class="clear"></div>
                </li>
                <li>
                  <div class="subject">루바토 개편과 사이트 이용...</div>
                  <div class="date">2022-09-30</div>
                  <div class="clear"></div>
                </li>
                <li>
                  <div class="subject">루바토 개편과 사이트 이용...</div>
                  <div class="date">2022-09-30</div>
                  <div class="clear"></div>
                </li>
                <li>
                  <div class="subject">루바토 개편과 사이트 이용...</div>
                  <div class="date">2022-09-30</div>
                  <div class="clear"></div>
                </li>
              </ul>
            </div>
          </article> <!-- 공지사항 끝 -->
          <article id="freeBoard"> <!-- 자유게시판 -->
            <div class="latest_title">
              <img class="latest_img" src="${pageContext.request.contextPath}/resources/img/latest2.gif">
              <a href="board_list.html"><img class="more" src="${pageContext.request.contextPath}/resources/img/more.gif"></a>
              <div class="clear"></div>
            </div>
            <div class="latest_content">
              <img class="image" src="${pageContext.request.contextPath}/resources/img/book_pen.gif">
              <ul class="list">
                <li>
                <a href="board_view.html?rfbnum=${fb01.rfbnum }">
                  <div class="subject">
                  <c:choose>
              	  	<c:when test="${fn:length(fb01.rfbtitle) >= 11}">
              	  		<c:out value="${fn:substring(fb01.rfbtitle,0,10) }"></c:out>...
              	  		<c:if test="${fb01.rfbreplycount != 0}">
             			 [${fb01.rfbreplycount }]</a></c:if>
                    </c:when>
                    <c:otherwise>
	                  <c:out value="${fb01.rfbtitle }"></c:out>
                  	</c:otherwise>
                  </c:choose>
                  </div></a>
                  <div class="date">
                  <c:choose>
              	  	<c:when test="${fn:length(fb01.rfbdate ) >= 15}">
              	  		<c:out value="${fn:substring(fb01.rfbdate,0,10) }"></c:out>
                    </c:when>
                  </c:choose>
                  </div>
                  <div class="clear"></div>
                  
                </li>
                <li>
                <a href="board_view.html?rfbnum=${fb02.rfbnum }">
                  <div class="subject">
                  <c:choose>
              	  	<c:when test="${fn:length(fb02.rfbtitle) >= 11}">
              	  		<c:out value="${fn:substring(fb02.rfbtitle,0,10) }"></c:out>...
              	  		<c:if test="${fb02.rfbreplycount != 0}">
             			 [${fb01.rfbreplycount }]</a></c:if>
                    </c:when>
                    <c:otherwise>
	                  <c:out value="${fb02.rfbtitle }"></c:out>
                  	</c:otherwise>
                  </c:choose>
                  </div></a>
                  <div class="date">
                  <c:choose>
              	  	<c:when test="${fn:length(fb02.rfbdate ) >= 15}">
              	  		<c:out value="${fn:substring(fb02.rfbdate,0,10) }"></c:out>
                    </c:when>
                  </c:choose>
                  </div>
                  <div class="clear"></div>
                  
                </li>
                <li>
                <a href="board_view.html?rfbnum=${fb03.rfbnum }">
                  <div class="subject">
                  <c:choose>
              	  	<c:when test="${fn:length(fb03.rfbtitle) >= 11}">
              	  		<c:out value="${fn:substring(fb03.rfbtitle,0,10) }"></c:out>...
              	  		<c:if test="${fb03.rfbreplycount != 0}">
             			 [${fb03.rfbreplycount }]</a></c:if>
                    </c:when>
                    <c:otherwise>
	                  <c:out value="${fb03.rfbtitle }"></c:out>
                  	</c:otherwise>
                  </c:choose>
                  </div></a>
                  <div class="date">
                  <c:choose>
              	  	<c:when test="${fn:length(fb03.rfbdate ) >= 15}">
              	  		<c:out value="${fn:substring(fb03.rfbdate,0,10) }"></c:out>
                    </c:when>
                  </c:choose>
                  </div>
                  <div class="clear"></div>
                  
                </li>
                <li>
                <a href="board_view.html?rfbnum=${fb04.rfbnum }">
                  <div class="subject">
                  <c:choose>
              	  	<c:when test="${fn:length(fb04.rfbtitle) >= 11}">
              	  		<c:out value="${fn:substring(fb04.rfbtitle,0,10) }"></c:out>...
              	  		<c:if test="${fb04.rfbreplycount != 0}">
             			 [${fb04.rfbreplycount }]</a></c:if>
                    </c:when>
                    <c:otherwise>
	                  <c:out value="${fb04.rfbtitle }"></c:out>
                  	</c:otherwise>
                  </c:choose>
                  </div></a>
                  <div class="date">
                  <c:choose>
              	  	<c:when test="${fn:length(fb04.rfbdate ) >= 15}">
              	  		<c:out value="${fn:substring(fb04.rfbdate,0,10) }"></c:out>
                    </c:when>
                  </c:choose>
                  </div>
                  <div class="clear"></div>
                  
                </li>
              </ul>
            </div>
          </article> <!-- 자유게시판 끝 -->
          <article id="youtube"> <!-- 유투브 -->
            <div class="latest_title">
              <img class="latest_img" src="${pageContext.request.contextPath}/resources/img/latest3.gif">
              <img class="more" src="${pageContext.request.contextPath}/resources/img/more.gif">
              <div class="clear"></div>
            </div>
            <img id="youtube_img" src="${pageContext.request.contextPath}/resources/img/bach.jpg">
          </article><!-- 유투브 끝 -->
        </section> <!-- 공지사항/자유게시판/유투브 끝 -->
        <section id="gallery"> <!-- 갤러리 시작 -->
          <img src="${pageContext.request.contextPath}/resources/img/latest4.gif">
          <div id="gallery_box"> <!-- gallery box 시작 -->
            <div id="gallery_list"> <!-- gallery list 시작 -->
              <div class="items">
                <ul>
                  <li><img src="${pageContext.request.contextPath}/resources/img/img1.jpg"></li>
                  <li>기타 페스티벌 4중주</li>
                </ul>
              </div>
              <div class="items">
                <ul>
                  <li><img src="${pageContext.request.contextPath}/resources/img/img1.jpg"></li>
                  <li>기타 페스티벌 4중주</li>
                </ul>
              </div>
              <div class="items">
                <ul>
                  <li><img src="${pageContext.request.contextPath}/resources/img/img1.jpg"></li>
                  <li>기타 페스티벌 4중주</li>
                </ul>
              </div>
            </div> <!-- gallery list 끝 -->
          </div> <!-- gallery box 끝 -->
        </section> <!-- 갤러리 끝 -->
      </section>
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