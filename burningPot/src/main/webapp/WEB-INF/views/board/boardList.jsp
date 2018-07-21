<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysDate"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /></c:set> 

<c:import url="/WEB-INF/views/common/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
<!-- custom css -->
<link
	href="${pageContext.request.contextPath }/resources/css/board/board.css"
	rel="stylesheet">
</head>
<body>
	<div style="height: 20%;"></div>

	<div class="contatiner">
		<br />
		<div class="text-center">
			<h2>
				<i class="fas fa-utensils"></i>  게시판
			</h2>
		</div>
		<div class="container containerTop">
			<div class="row col-sm-12 custyle justify-content-sm-center">
				<!-- 검색 영역 -->
				<div class="col col-sm-2">
					<select class="form-control" id="searchCondition">
						<option selected>선택하기</option>
						<option value="sId">내용으로 검색</option>
						<option value="sName">작성자로 검색</option>
					</select>
				</div>
				<div class="col-sm-6">
					<div class="input-group">
						<input type="search" class="form-control" placeholder=" 검색 하기 " id="keyword" onkeyup="enterKey();"> 
						<span class="input-group-btn"><button class="btn btn-secondary" type="button" onclick="search();">검색</button></span>
					</div>
				</div>
			</div>
			<br />
			<div class="row">
				<div class="col-sm-4 text-left">
					<p>총 ${totalContents}건의 게시물이 있습니다.</p>
				</div>
				<div class="col-sm-8 text-right">
					<button class="btn btn-info" onclick="insertBoard();">글쓰기</button>
					<input type="hidden" id="mNum" value="${m.mNum}"/>
				</div>
			</div>
				
				<!-- 검색 끝 -->
				<table
					class="table table-striped custab table-hover tableList table-responsive-sm"
					id="tbl-board">
					<thead>
						<tr>
							<th>No</th>
							<th>구분</th>
							<th class="text-center">제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>답변여부</th>
							<th>조회수</th>
						</tr>
					</thead>
					<c:forEach items="${list}" var="b">
						<tr id="${b.bNum}">
							<td>${b.bNum}</td>
							<c:if test="${b.category eq '공지사항'}">
								<td>[${b.category}]</td>
							</c:if>
							<c:if test="${b.category ne '공지사항'}">
								<c:if test="${b.category eq 'QNA'}">
									<td>Q&A</td>
								</c:if>
								<c:if test="${b.category ne 'QNA'}">
									<td>${b.category}</td>
								</c:if>	
							</c:if>
							
							<td>
								<c:if test="${fn:length(b.bTitle)>30}">
									${fn:substring(b.bTitle,0,30)} . . .
								</c:if>
								<c:if test="${fn:length(b.bTitle)<=30}">
									${b.bTitle}
								</c:if>
								<c:if test="${sysDate eq b.bDate}">
									<sup><span style="font-size:18px; color:red; text-shadow:2px 2px white;">new</span></sup>
								</c:if>
							</td>
							<td>
								<c:if test="${fn:length(b.mId)>6}">
									${fn:substring(b.mId,0,5)} . . .
								</c:if>
								<c:if test="${fn:length(b.mId)<=5}">
									${b.mId}
								</c:if>
							</td>
							<td>${b.bDate}</td>
							<td>${b.reply}</td>
							<td>${b.bCount}</td>
						</tr>
					</c:forEach>
				</table>
				
				 <%-- 페이지바를 위한 Utils의 정적메소드 사용 --%> 
				   <% 
				      int totalContents = Integer.parseInt(String.valueOf(request.getAttribute("totalContents")));
				      int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
				      
				      //파라미터 cPage가 null이거나 "" 일 때에는 기본값 1로 세팅함.  
				      String cPageTemp = request.getParameter("cPage");
				      int cPage = 1;
				      try{
				    	  
				         cPage = Integer.parseInt(cPageTemp);
				         
				      } catch(NumberFormatException e){
				    	  
				      }
				      
				   %>
				   <%= com.kh.pot.common.util.Utils.getPageBar(totalContents, cPage, numPerPage, "boardList.do") %>
		</div>
	</div>
<script>
	
	   $("tr[id]").on("click",function(){
	      var boardNo = $(this).attr("id");
	      location.href = "${pageContext.request.contextPath}/board/boardDetail.do?no="+boardNo;
	   }).hover(function(){
		   $(this).css('cursor','pointer');
	   });
	function insertBoard(){
		if( $('#mNum').val() == null ||$('#mNum').val() ==""){
			alert('로그인 후 이용하실 수 있습니다.');
			$("#loginModal").modal();
		}else location.href='${pageContext.request.contextPath}/board/insertBoard.do';
	}
</script>
</body>
</html>