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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/footer.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/board_left.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/board_list_main.css">
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
        <div id="total_search">
          <div id="total">▷ 총 ${rfbcount }개의 게시물이 있습니다.</div>
          <form action="search_list">
          <div id="search">
            <div id="select_img"><img src="${pageContext.request.contextPath}/resources/img/select_search.gif"></div>
            <div id="search_select">
              <select name="searchoption">
                <option value="title">제목</option>
                <option value="content">내용</option>
                <option value="writer">글쓴이</option>
              </select>
            </div>
            <div id="search_input"><input type="text" name="searchkey"></div>
            <div id="search_btn"><input type="image" src="${pageContext.request.contextPath}/resources/img/search_button.gif"></div>
          </div>
          </form>
        </div> <!-- total search 끝 -->
        <table>
          <tr>
            <th>번호</th>
            <th>제목</th>
            <th>글쓴이</th>
            <th>일시</th>
            <th>조회수</th>
          </tr>
          <c:forEach items="${dto }" var="fbdto">
          <tr>
   
            <td class="col1">${fbdto.rfbnum}</td>
            <td class="col2">
              <a href="board_view.html?rfbnum=${fbdto.rfbnum}">${fbdto.rfbtitle}
              <c:if test="${fbdto.rfbreplycount != 0}">
              [${fbdto.rfbreplycount }]</a></c:if>
            </td>
            <td class="col3">${fbdto.rfbname}</td>
            <td class="col4">${fbdto.rfbdate}</td>
            <td class="col5">${fbdto.rfbhit}</td>
          </tr>
          </c:forEach>
        </table> <!-- 게시판 목록 테이블 끝 -->
        <div id="buttons">
        
          <div class="col1">
          
          <!--   -->
      	  <c:if test="${pagepage>1 }">
          	<a href="board_list.html?pagepage=${pagepage-1}&pagesu=${firstgl-1 }">◀ 이전</a>
          </c:if>
	          <c:if test="${page>5 }">
	           <c:forEach begin="${firstgl }" end="${lastgl }" var="pagesu">
	          	 <c:if test="${checkpage>=pagesu}">
	          	 <c:if test="${pagesu<=page}">
	           <a href="board_list.html?pagesu=${pagesu}&pagepage=${pagepage}">${pagesu }</a>	          		      		    
       		    </c:if></c:if></c:forEach>
       		  <c:if test="${pagepage<=ppsu}">
       		   <a href="board_list.html?pagepage=${pagepage+1}&pagesu=${lastgl+1 }">다음 ▶</a>  
       		   </c:if>         
         	  </c:if>
          
          
		  <c:if test="${page<=5 }">
		  <c:forEach begin="1" end="${page}" var="pagesu">
           <a href="board_list.html?pagesu=${pagesu}">${pagesu }</a>
          </c:forEach>
		  </c:if>	
         <!-- <c:forEach begin="1" end="${page }" var="pagesu">
           <a href="board_list.html?pagesu=${pagesu}">${pagesu }</a>
          </c:forEach>
           다음 ▶  --> 
          
          </div>
          
          
          <div class="col2">
            <% if(sessionId == null) { %>
            <a href="#"><p onclick="alert('비회원을 글을 작성할 수 없습니다.')"><img src="${pageContext.request.contextPath}/resources/img/write.png"></a>
            
            <% } else { %>
            <a href="board_write.html"><img src="${pageContext.request.contextPath}/resources/img/write.png"></a>
            <% } %>
          </div>
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