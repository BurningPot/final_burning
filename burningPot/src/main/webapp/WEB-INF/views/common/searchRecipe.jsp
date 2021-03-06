<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<title>burningPot</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400">
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="icon" href="${pageContext.request.contextPath}/resources/img/smile.png" type="image/lg-icon">
</head>
<body style="font-family: 'Nanum Gothic', sans-serif;">
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<div style="height: 15%;"></div>
	<div id="fakeLoader"></div>
	<div class="b-seg" id="b-seg">
		<div class="searchResultAndsearchBtnB">
			<div class="searchRecipeCountArea">
				<b>"${searchRecipeWord}"</b>으로 검색한 결과 입니다.<br>
				총 <b>${searchTotalCount}</b>개의 맛있는 레시피가 있습니다.
			</div>
			<div class="searchBtn">
				<ul class="searchBtnUl">
		          <li><button type="button" class="searchBtnA1" onclick="inquiry();">조회</button></li>
		          <li><button type="button" class="searchBtnA2" onclick="recommand();">추천</button></li>
		          <li><button type="button" class="searchBtnA3" onclick="levelAndTime();">난이도</button></li>
		        </ul>
			</div>
		</div>
		<ul class="recipeList">
			<c:forEach items="${searchRecipeList}" var="searchRecipe">
	            <li>
	               <div class='like_and_aver_area'>
	                  <div class='like_btn_area'>
	                     <button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>
	                        <c:if test="${searchRecipe.rcCheck == searchRecipe.rNum}">
	                        	<i class='fas fa-thumbs-up'></i>
	                        </c:if>
	                        <c:if test="${searchRecipe.rcCheck != searchRecipe.rNum}">
	                        	<i class='far fa-thumbs-up'></i>
	                        </c:if>
	                     </button>
                         <input id="recipeMNum" type="hidden"  value="${searchRecipe.mNum}"/>
           				 <input id="recipeRNum" type="hidden" value="${searchRecipe.rNum}"/>
                     	 <input id="recipeRRecommend" type="hidden" value="${searchRecipe.rRecommend}"/>
                     	 <input id="rcCheck" type="hidden" value="${searchRecipe.rcCheck}"/>
	                  </div>
	                  <div class='aver_btn_area'>
                     	<c:choose>
							<c:when test="${searchRecipe.grade == 0}">
								0점
							</c:when>
							<c:otherwise>
								${searchRecipe.grade}점
							</c:otherwise>
						</c:choose>
	                  </div>
	               </div>
					<div class='recipe_img_area'>
						<img class='food_img img-thumbnail'
							src='${pageContext.request.contextPath}/resources/img/recipeContent/${searchRecipe.rImg}'>
						<div class='img_hover_area'>
							<a class="recipe_move_detail" style="color: palegreen;" onclick="location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=${searchRecipe.rNum}'">
								<c:if test="${fn:length(searchRecipe.rName)<= 6}">
									${fn:substring(searchRecipe.rName,0, 9)}
								</c:if>
								<c:if test="${fn:length(searchRecipe.rName) > 6}">
									${fn:substring(searchRecipe.rName,0, 15)} . . .
								</c:if>
							</a>
						</div>
					</div>
					<div class='recipe_levle_and_time_and_writer_area'>
						<div class='recipe_level'>
							<c:if test="${4 eq searchRecipe.rLevel}">
   								고급
   							</c:if>
   							<c:if test="${3 eq searchRecipe.rLevel}">
   								중급
   							</c:if>
   							<c:if test="${2 eq searchRecipe.rLevel}">
   								초급
   							</c:if>
   							<c:if test="${1 eq searchRecipe.rLevel}">
   								아무나
   							</c:if>
						</div>
						<div class='recipe_time'>
	   							<c:if test="${1 eq searchRecipe.rTime}">
	   								10분 이내
	   							</c:if>
	   							<c:if test="${2 eq searchRecipe.rTime}">
	   								20분 이내
	   							</c:if>
	   							<c:if test="${3 eq searchRecipe.rTime}">
	   								30분 이내
	   							</c:if>
	   							<c:if test="${4 eq searchRecipe.rTime}">
	   								60분 이내
	   							</c:if>
	   							<c:if test="${5 eq searchRecipe.rTime}">
	   								60분 이상
	   							</c:if>
	   						</div>
	   						<div class='recipe_quantity'>
	   							<c:if test="${1 eq searchRecipe.quantity}">
	   								1인분
	   							</c:if>
	   							<c:if test="${2 eq searchRecipe.quantity}">
	   								2인분
	   							</c:if>
	   							<c:if test="${3 eq searchRecipe.quantity}">
	   								3인분
	   							</c:if>
	   							<c:if test="${4 eq searchRecipe.quantity}">
	   								4인분
	   							</c:if>
	   							<c:if test="${5 eq searchRecipe.quantity}">
	   								5인분
	   							</c:if>
	   							<c:if test="${6 eq searchRecipe.quantity}">
	   								5인분 이상
	   							</c:if>
	   						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
	</div>

	<script>
		var TrueAndFalse1 = true;
		var AscAndDesc1 = "DESC";
		
		var TrueAndFalse2 = true;
		var AscAndDesc2 = "DESC";
		
		var TrueAndFalse3 = true;
		var AscAndDesc3 = "DESC";
		
		var count = 9;
		var keyWord = '${searchRecipeWord}';
		var num = '${searchTotalCount}';
		var searchRecipeList = '${searchRecipeList}';
			
		$(document).mouseup(function(e){
		    var container = $('.menuContainer');
		    if(!container.is(e.target) && container.has(e.target).length === 0){
		    	container.hide();
		    }
		});
		$(window).bind("scroll", infinityScrollFunction); // 하나만 있어도 스크롤 관련된 부분이 다 처리됨
		
		function infinityScrollFunction() {
			
			
			//현재문서의 높이를 구함.
            var documentHeight = $(document).height();
            //console.log("documentHeight : " + documentHeight);

            //scrollTop() 메서드는 선택된 요소의 세로 스크롤 위치를 설정하거나 반환    
            //스크롤바가 맨 위쪽에 있을때 , 위치는 0
            //console.log("window의 scrollTop() : " + $(window).scrollTop());
            //height() 메서드는 브라우저 창의 높이를 설정하거나 반환
            //console.log("window의 height() : " + $(window).height());

            //세로 스크롤위치 max값과 창의 높이를 더하면 현재문서의 높이를 구할수있음.
            //세로 스크롤위치 값이 max이면 문서의 끝에 도달했다는 의미
            var scrollHeight = $(window).scrollTop() + $(window).height();
            //console.log("scrollHeight : " + scrollHeight);
    
            if (scrollHeight == documentHeight) {  //문서의 맨끝에 도달했을때 내용 추가 
          
	            $.ajax({
	            	url : "${pageContext.request.contextPath}/home/searchRecipeObject.do",
	            	type : "GET",
	            	data : {
	            		number : count,
	            		keyWord : keyWord
	            	},success: function(data){
	               		count += 9;
	               		var level = "";
	               		var rTime = "";
	               		var quantity = "";
	               		var rName = "";
	            		var rNameSub ="";
	            		var grade = "";
						var gradeC ="";
	            		for(var i = 0; i < data.length; i++){
	            			
	            			rName = data[i].rName;
	            			grade = data[i].grade;
	            			
	            			
	            			if(data[i].rLevel == 1){
	                			level="아무나";
	                		} else if(data[i].rLevel == 2){
	                			level="초급";
	                		} else if(data[i].rLevel == 3) {
	                			level="중급";
	                		} else {
	                			level="고급";
	                		}
	            			if(data[i].rTime == 1){
	            				rTime="10분 이내";
	                		} else if(data[i].rTime == 2){
	                			rTime="20분 이내";
	                		} else if(data[i].rTime == 3) {
	                			rTime="30분 이내";
	                		} else if(data[i].rTime == 4) {
	                			rTime="60분 이내";
	                		} else {
	                			rTime="60분 이상";
	                		}
	            			if(data[i].quantity == 1){
	            				quantity = "1인분";
	                		} else if(data[i].quantity == 2){
	                			quantity = "2인분";
	                		} else if(data[i].quantity == 3) {
	                			quantity = "3인분";
	                		} else if(data[i].quantity == 4) {
	                			quantity = "4인분";
	                		} else if(data[i].quantity == 5) {
	                			quantity = "5인분";
	                		} else {
	                			quantity = "5인분 이상";
	                		}
	            			if(rName.length <= 6){
		               			rNameSub = rName.substring(0, 9);
	            			} else {
	            				rNameSub = rName.substring(0, 15) + " . . .";
	            			}
	            			if( grade == 0){
	            				gradeC = "0점";
	            			} else {
	            				gradeC = parseFloat(grade).toFixed(1) + "점";
	            			}
	            			
	            			if(data[i].rcCheck == data[i].rNum ){
	            			$("<li>" + 
	               				"<div class='like_and_aver_area'>" +
	               					"<div class='like_btn_area'>" +
	               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
	               						"<i class='fas fa-thumbs-up'></i>" +
	               						"</button>" +
	               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
		          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
	        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
	        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
	               					"</div>" + 
	               					"<div class='aver_btn_area'>" + 
	               						gradeC+
	               					"</div> " +
	               				"</div>" + 
	               				"<div class='recipe_img_area'>" +
	               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
	               					"<div class='img_hover_area'>" +
		               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
			               					rNameSub +
		    							"</a>" +
	               					"</div>" +
	               				"</div>" +
	               				"<div class='recipe_levle_and_time_and_writer_area'>" +
	               					"<div class='recipe_level'>" + level + "</div>" +
	               					"<div class='recipe_time'>" + data[i].rTime + "분" + "</div>" +
	               					"<div class='recipe_quantity'>" + data[i].quantity + "인분" + "</div>" +
	               				"</div>" +
	               			"</li>").appendTo(".recipeList");
	            			
	            			} else if(data[i].rcCheck != data[i].rNum ){
	            				$("<li>" + 
	    	               				"<div class='like_and_aver_area'>" +
	    	               					"<div class='like_btn_area'>" +
	    	               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
	    	               						"<i class='far fa-thumbs-up'></i>" +
	    	               						"</button>" +
	    	               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
	    		          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
	    	        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
	    	        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
	    	               					"</div>" + 
	    	               					"<div class='aver_btn_area'>" + 
	    	               						gradeC+
	    	               					"</div> " +
	    	               				"</div>" + 
	    	               				"<div class='recipe_img_area'>" +
	    	               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
	    	               					"<div class='img_hover_area'>" +
		    	               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
					               					rNameSub +
				    							"</a>" +
	    	               					"</div>" +
	    	               				"</div>" +
	    	               				"<div class='recipe_levle_and_time_and_writer_area'>" +
	    	               					"<div class='recipe_level'>" + level + "</div>" +
	    	               					"<div class='recipe_time'>" + data[i].rTime + "분" + "</div>" +
	    	               					"<div class='recipe_quantity'>" + data[i].quantity + "인분" + "</div>" +
	    	               				"</div>" +
	    	               			"</li>").appendTo(".recipeList");
	            			}
                       
		            		}
	            		
	            	}, error : function(data){
	            		console.log("검색 후 레시피 불러오기를 실패하였습니다.");
	            	}
	            });       
			}
        }
		
	
		/* 조회수로 정렬하는 메소드 */
		function inquiry() {
			
			count = 9;
			var keyWord = '${searchRecipeWord}';
			var str1 = "★채우는 공간";   
            var str2 = "Recipe !";
			console.log("inquiry 버튼 클릭 시 keyWord : " + keyWord);
			console.log("TnF : " + TrueAndFalse1);
			if(TrueAndFalse1 == true){
				$.ajax({
					url : "${pageContext.request.contextPath}/home/inquiryBefore.do",
					dataType : "json",
					type : "GET",
					data : {
						keyWord : keyWord,
						TrueAndFalse : TrueAndFalse1,
						AscAndDesc : AscAndDesc1
					}, success : function(data){
						console.log("조회순서로 정렬 성공!");
						var level = "";
	               		var rTime = "";
	               		var quantity = "";
	               		var rName = "";
	            		var rNameSub ="";
	            		var grade = "";
						var gradeC ="";
						// 기존 scroll이벤트 제거
						$(window).unbind("scroll");
						$(".recipeList").empty();
						
	            		for(var i = 0; i < data.length; i++){
	            			
	            			rName = data[i].rName;
	            			grade = data[i].grade;
	            			
	            			if(data[i].rLevel == 1){
	                			level="아무나";
	                		} else if(data[i].rLevel == 2){
	                			level="초급";
	                		} else if(data[i].rLevel == 3) {
	                			level="중급";
	                		} else {
	                			level="고급";
	                		}
	            			if(data[i].rTime == 1){
	            				rTime="10분 이내";
	                		} else if(data[i].rTime == 2){
	                			rTime="20분 이내";
	                		} else if(data[i].rTime == 3) {
	                			rTime="30분 이내";
	                		} else if(data[i].rTime == 4) {
	                			rTime="60분 이내";
	                		} else {
	                			rTime="60분 이상";
	                		}
	            			if(data[i].quantity == 1){
	            				quantity = "1인분";
	                		} else if(data[i].quantity == 2){
	                			quantity = "2인분";
	                		} else if(data[i].quantity == 3) {
	                			quantity = "3인분";
	                		} else if(data[i].quantity == 4) {
	                			quantity = "4인분";
	                		} else if(data[i].quantity == 5) {
	                			quantity = "5인분";
	                		} else {
	                			quantity = "5인분 이상";
	                		}
	            			if(rName.length <= 6){
		               			rNameSub = rName.substring(0, 9);
	            			} else {
	            				rNameSub = rName.substring(0, 15) + " . . .";
	            			}
	            			if( grade == 0){
	            				gradeC = "0점";
	            			} else {
	            				gradeC = parseFloat(grade).toFixed(1) + "점";
	            			}
	            			
	            			if(data[i].rcCheck == data[i].rNum ){
		            			$("<li>" + 
		               				"<div class='like_and_aver_area'>" +
		               					"<div class='like_btn_area'>" +
		               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
		               						"<i class='fas fa-thumbs-up'></i>" +
		               						"</button>" +
		               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
			          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
		        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
		        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
		               					"</div>" + 
		               					"<div class='aver_btn_area'>" + 
		               						gradeC +
		               					"</div> " +
		               				"</div>" + 
		               				"<div class='recipe_img_area'>" +
		               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
		               					"<div class='img_hover_area'>" + 
			               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
				               					rNameSub +
			    							"</a>" +
		               					"</div>" +
		               				"</div>" +
		               				"<div class='recipe_levle_and_time_and_writer_area'>" +
		               					"<div class='recipe_level'>" + level + "</div>" +
		               					"<div class='recipe_time'>" + rTime + "</div>" +
		               					"<div class='recipe_quantity'>" + quantity + "</div>" +
		               				"</div>" +
		               			"</li>").appendTo(".recipeList");
		            			
		            			} else if(data[i].rcCheck != data[i].rNum ){
		            				$("<li>" + 
		    	               				"<div class='like_and_aver_area'>" +
		    	               					"<div class='like_btn_area'>" +
		    	               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
		    	               						"<i class='far fa-thumbs-up'></i>" +
		    	               						"</button>" +
		    	               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
		    		          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
		    	        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
		    	        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
		    	               					"</div>" + 
		    	               					"<div class='aver_btn_area'>" + 
		    	               						gradeC +
		    	               					"</div> " +
		    	               				"</div>" + 
		    	               				"<div class='recipe_img_area'>" +
		    	               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
		    	               					"<div class='img_hover_area'>" + 
			    	               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
						               					rNameSub +
					    							"</a>" +
		    	               					"</div>" +
		    	               				"</div>" +
		    	               				"<div class='recipe_levle_and_time_and_writer_area'>" +
		    	               					"<div class='recipe_level'>" + level + "</div>" +
		    	               					"<div class='recipe_time'>" + rTime + "</div>" +
		    	               					"<div class='recipe_quantity'>" + quantity + "</div>" +
		    	               				"</div>" +
		    	               			"</li>").appendTo(".recipeList");
		            			}
	            		}
	            		
	            		$(window).bind("scroll", inquiryInfinityScrollFunction);
	            		
	            		TrueAndFalse1 = false;
	    				AscAndDesc1 = "ASC";
	    				
	    				//console.log("if TrueAndFalse : " + TrueAndFalse);
	    				//console.log("if AscAndDesc : " + AscAndDesc);
	            		
					}, error : function(data){
						console.log("조회 순서로 정렬 실패!");
					}
				});
				
			} else {
				$.ajax({
					url : "${pageContext.request.contextPath}/home/inquiryBefore.do",
					dataType : "json",
					type : "GET",
					data : {
						keyWord : keyWord,
						TrueAndFalse : TrueAndFalse1,
						AscAndDesc : AscAndDesc1
					}, success : function(data){
						console.log("조회순서로 정렬 성공!");
						var level = "";
	               		var rTime = "";
	               		var quantity = "";
	               		var rName = "";
	            		var rNameSub ="";
	            		var grade = "";
						var gradeC ="";
						// 기존 scroll이벤트 제거
						$(window).unbind("scroll");
						$(".recipeList").empty();
						
	            		for(var i = 0; i < data.length; i++){

	            			rName = data[i].rName;
	            			grade = data[i].grade;
	            			
	            			if(data[i].rLevel == 1){
	                			level="아무나";
	                		} else if(data[i].rLevel == 2){
	                			level="초급";
	                		} else if(data[i].rLevel == 3) {
	                			level="중급";
	                		} else {
	                			level="고급";
	                		}
	            			if(data[i].rTime == 1){
	            				rTime="10분 이내";
	                		} else if(data[i].rTime == 2){
	                			rTime="20분 이내";
	                		} else if(data[i].rTime == 3) {
	                			rTime="30분 이내";
	                		} else if(data[i].rTime == 4) {
	                			rTime="60분 이내";
	                		} else {
	                			rTime="60분 이상";
	                		}
	            			if(data[i].quantity == 1){
	            				quantity = "1인분";
	                		} else if(data[i].quantity == 2){
	                			quantity = "2인분";
	                		} else if(data[i].quantity == 3) {
	                			quantity = "3인분";
	                		} else if(data[i].quantity == 4) {
	                			quantity = "4인분";
	                		} else if(data[i].quantity == 5) {
	                			quantity = "5인분";
	                		} else {
	                			quantity = "5인분 이상";
	                		}
	            			if(rName.length <= 6){
		               			rNameSub = rName.substring(0, 9);
	            			} else {
	            				rNameSub = rName.substring(0, 15) + " . . .";
	            			}
	            			if( grade == 0){
	            				gradeC = "0점";
	            			} else {
	            				gradeC = parseFloat(grade).toFixed(1) + "점";
	            			}
	            			
	            			if(data[i].rcCheck == data[i].rNum ){
		            			$("<li>" + 
		               				"<div class='like_and_aver_area'>" +
		               					"<div class='like_btn_area'>" +
		               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
		               						"<i class='fas fa-thumbs-up'></i>" +
		               						"</button>" +
		               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
			          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
		        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
		        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
		               					"</div>" + 
		               					"<div class='aver_btn_area'>" + 
		               						gradeC +
		               					"</div> " +
		               				"</div>" + 
		               				"<div class='recipe_img_area'>" +
		               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
		               					"<div class='img_hover_area'>" +
			               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
				               					rNameSub +
			    							"</a>" +
		               					"</div>" +
		               				"</div>" +
		               				"<div class='recipe_levle_and_time_and_writer_area'>" +
		               					"<div class='recipe_level'>" + level + "</div>" +
		               					"<div class='recipe_time'>" + rTime + "</div>" +
		               					"<div class='recipe_quantity'>" + quantity + "</div>" +
		               				"</div>" +
		               			"</li>").appendTo(".recipeList");
		            			
		            			} else if(data[i].rcCheck != data[i].rNum ){
		            				$("<li>" + 
		    	               				"<div class='like_and_aver_area'>" +
		    	               					"<div class='like_btn_area'>" +
		    	               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
		    	               						"<i class='far fa-thumbs-up'></i>" +
		    	               						"</button>" +
		    	               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
		    		          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
		    	        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
		    	        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
		    	               					"</div>" + 
		    	               					"<div class='aver_btn_area'>" + 
		    	               						gradeC +
		    	               					"</div> " +
		    	               				"</div>" + 
		    	               				"<div class='recipe_img_area'>" +
		    	               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
		    	               					"<div class='img_hover_area'>" + 
			    	               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
						               					rNameSub +
					    							"</a>" +
		    	               					"</div>" +
		    	               				"</div>" +
		    	               				"<div class='recipe_levle_and_time_and_writer_area'>" +
		    	               					"<div class='recipe_level'>" + level + "</div>" +
		    	               					"<div class='recipe_time'>" + rTime + "</div>" +
		    	               					"<div class='recipe_quantity'>" + quantity + "</div>" +
		    	               				"</div>" +
		    	               			"</li>").appendTo(".recipeList");
		            			}
		            		}
		            		
		            		$(window).bind("scroll", inquiryInfinityScrollFunction);
		            		
		            		TrueAndFalse1 = true;
		    				AscAndDesc1 = "DESC";
		    				
		    				//console.log("else TrueAndFalse : " + TrueAndFalse);
		    				//console.log("else AscAndDesc : " + AscAndDesc);
		            		
						}, error : function(data){
							console.log("조회 순서로 정렬 실패!");
						}
					});
				}
				
				
			}
		
		/* 추천수로 정렬하는 메소드  */
		function recommand() {
			
			count = 9;
			var keyWord = '${searchRecipeWord}';
			var str1 = "★채우는 공간";   
            var str2 = "Recipe !";
			console.log("keyWord : " + keyWord);
			console.log("recommend TnF : " + TrueAndFalse2);
			if(TrueAndFalse2 == true) {
				$.ajax({
					url : "${pageContext.request.contextPath}/home/recommandBefore.do",
					dataType : "json",
					type : "GET",
					data : {
						keyWord : keyWord,
						TrueAndFalse : TrueAndFalse2,
						AscAndDesc : AscAndDesc2
					}, success : function(data){
						console.log("조회순서로 정렬 성공!");
						var level = "";
	               		var rTime = "";
	               		var quantity = "";
	               		var rName = "";
	            		var rNameSub ="";
	            		var grade = "";
						var gradeC ="";
						// 기존 scroll이벤트 제거
						$(window).unbind("scroll");
						$(".recipeList").empty();
						
	            		for(var i = 0; i < data.length; i++){

	            			rName = data[i].rName;
	            			grade = data[i].grade;
	            			
	            			if(data[i].rLevel == 1){
	                			level="아무나";
	                		} else if(data[i].rLevel == 2){
	                			level="초급";
	                		} else if(data[i].rLevel == 3) {
	                			level="중급";
	                		} else {
	                			level="고급";
	                		}
	            			if(data[i].rTime == 1){
	            				rTime="10분 이내";
	                		} else if(data[i].rTime == 2){
	                			rTime="20분 이내";
	                		} else if(data[i].rTime == 3) {
	                			rTime="30분 이내";
	                		} else if(data[i].rTime == 4) {
	                			rTime="60분 이내";
	                		} else {
	                			rTime="60분 이상";
	                		}
	            			if(data[i].quantity == 1){
	            				quantity = "1인분";
	                		} else if(data[i].quantity == 2){
	                			quantity = "2인분";
	                		} else if(data[i].quantity == 3) {
	                			quantity = "3인분";
	                		} else if(data[i].quantity == 4) {
	                			quantity = "4인분";
	                		} else if(data[i].quantity == 5) {
	                			quantity = "5인분";
	                		} else {
	                			quantity = "5인분 이상";
	                		}
	            			
	            			if(rName.length <= 6){
		               			rNameSub = rName.substring(0, 9);
	            			} else {
	            				rNameSub = rName.substring(0, 15) + " . . .";
	            			}
	            			if( grade == 0){
	            				gradeC = "0점";
	            			} else {
	            				gradeC = parseFloat(grade).toFixed(1) + "점";
	            			}
	            			
	            			if(data[i].rcCheck == data[i].rNum ){
		            			$("<li>" + 
		               				"<div class='like_and_aver_area'>" +
		               					"<div class='like_btn_area'>" +
		               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
		               						"<i class='fas fa-thumbs-up'></i>" +
		               						"</button>" +
		               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
			          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
		        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
		        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
		               					"</div>" + 
		               					"<div class='aver_btn_area'>" + 
		               						gradeC +
		               					"</div> " +
		               				"</div>" + 
		               				"<div class='recipe_img_area'>" +
		               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
		               					"<div class='img_hover_area'>" + 
			               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
				               					rNameSub +
			    							"</a>" +
		               					"</div>" +
		               				"</div>" +
		               				"<div class='recipe_levle_and_time_and_writer_area'>" +
		               					"<div class='recipe_level'>" + level + "</div>" +
		               					"<div class='recipe_time'>" + rTime + "</div>" +
		               					"<div class='recipe_quantity'>" + quantity + "</div>" +
		               				"</div>" +
		               			"</li>").appendTo(".recipeList");
		            			
		            			} else if(data[i].rcCheck != data[i].rNum ){
		            				$("<li>" + 
		    	               				"<div class='like_and_aver_area'>" +
		    	               					"<div class='like_btn_area'>" +
		    	               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
		    	               						"<i class='far fa-thumbs-up'></i>" +
		    	               						"</button>" +
		    	               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
		    		          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
		    	        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
		    	        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
		    	               					"</div>" + 
		    	               					"<div class='aver_btn_area'>" + 
		    	               						gradeC +
		    	               					"</div> " +
		    	               				"</div>" + 
		    	               				"<div class='recipe_img_area'>" +
		    	               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
		    	               					"<div class='img_hover_area'>" + 
			    	               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
						               					rNameSub +
					    							"</a>" +
		    	               					"</div>" +
		    	               				"</div>" +
		    	               				"<div class='recipe_levle_and_time_and_writer_area'>" +
		    	               					"<div class='recipe_level'>" + level + "</div>" +
		    	               					"<div class='recipe_time'>" + rTime + "</div>" +
		    	               					"<div class='recipe_quantity'>" + quantity + "</div>" +
		    	               				"</div>" +
		    	               			"</li>").appendTo(".recipeList");
		            			}
	            		}
	            		
	            		$(window).bind("scroll", recommandInfinityScrollFunction);
	            		
	            		TrueAndFalse2 = false;
	    				AscAndDesc2 = "ASC";
	    				
					}, error : function(data){
						console.log("조회 순서로 정렬 실패!");
					}
				});
				
			} else {
				$.ajax({
					url : "${pageContext.request.contextPath}/home/recommandBefore.do",
					dataType : "json",
					type : "GET",
					data : {
						keyWord : keyWord,
						TrueAndFalse : TrueAndFalse2,
						AscAndDesc : AscAndDesc2
					}, success : function(data){
						console.log("조회순서로 정렬 성공!");
						var level = "";
	               		var rTime = "";
	               		var quantity = "";
	               		var rName = "";
	            		var rNameSub ="";
	            		var grade = "";
						var gradeC ="";
						// 기존 scroll이벤트 제거
						$(window).unbind("scroll");
						$(".recipeList").empty();
						
	            		for(var i = 0; i < data.length; i++){

	            			rName = data[i].rName;
	            			grade = data[i].grade;
	            			
	            			if(data[i].rLevel == 1){
	                			level="아무나";
	                		} else if(data[i].rLevel == 2){
	                			level="초급";
	                		} else if(data[i].rLevel == 3) {
	                			level="중급";
	                		} else {
	                			level="고급";
	                		}
	            			if(data[i].rTime == 1){
	            				rTime="10분 이내";
	                		} else if(data[i].rTime == 2){
	                			rTime="20분 이내";
	                		} else if(data[i].rTime == 3) {
	                			rTime="30분 이내";
	                		} else if(data[i].rTime == 4) {
	                			rTime="60분 이내";
	                		} else {
	                			rTime="60분 이상";
	                		}
	            			if(data[i].quantity == 1){
	            				quantity = "1인분";
	                		} else if(data[i].quantity == 2){
	                			quantity = "2인분";
	                		} else if(data[i].quantity == 3) {
	                			quantity = "3인분";
	                		} else if(data[i].quantity == 4) {
	                			quantity = "4인분";
	                		} else if(data[i].quantity == 5) {
	                			quantity = "5인분";
	                		} else {
	                			quantity = "5인분 이상";
	                		}
	            			if(rName.length <= 6){
		               			rNameSub = rName.substring(0, 9);
	            			} else {
	            				rNameSub = rName.substring(0, 15) + " . . .";
	            			}
	            			if( grade == 0){
	            				gradeC = "0점";
	            			} else {
	            				gradeC = parseFloat(grade).toFixed(1) + "점";
	            			}
	            			if(data[i].rcCheck == data[i].rNum ){
		            			$("<li>" + 
		               				"<div class='like_and_aver_area'>" +
		               					"<div class='like_btn_area'>" +
		               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
		               						"<i class='fas fa-thumbs-up'></i>" +
		               						"</button>" +
		               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
			          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
		        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
		        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
		               					"</div>" + 
		               					"<div class='aver_btn_area'>" + 
		               						gradeC +
		               					"</div> " +
		               				"</div>" + 
		               				"<div class='recipe_img_area'>" +
		               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
		               					"<div class='img_hover_area'>" + 
			               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
				               					rNameSub +
			    							"</a>" +
		               					"</div>" +
		               				"</div>" +
		               				"<div class='recipe_levle_and_time_and_writer_area'>" +
		               					"<div class='recipe_level'>" + level + "</div>" +
		               					"<div class='recipe_time'>" + rTime + "</div>" +
		               					"<div class='recipe_quantity'>" + quantity + "</div>" +
		               				"</div>" +
		               			"</li>").appendTo(".recipeList");
		            			
		            			} else if(data[i].rcCheck != data[i].rNum ){
		            				$("<li>" + 
		    	               				"<div class='like_and_aver_area'>" +
		    	               					"<div class='like_btn_area'>" +
		    	               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
		    	               						"<i class='far fa-thumbs-up'></i>" +
		    	               						"</button>" +
		    	               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
		    		          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
		    	        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
		    	        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
		    	               					"</div>" + 
		    	               					"<div class='aver_btn_area'>" + 
		    	               						gradeC +
		    	               					"</div> " +
		    	               				"</div>" + 
		    	               				"<div class='recipe_img_area'>" +
		    	               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
		    	               					"<div class='img_hover_area'>" + 
			    	               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
						               					rNameSub +
					    							"</a>" +
		    	               					"</div>" +
		    	               				"</div>" +
		    	               				"<div class='recipe_levle_and_time_and_writer_area'>" +
		    	               					"<div class='recipe_level'>" + level + "</div>" +
		    	               					"<div class='recipe_time'>" + rTime + "</div>" +
		    	               					"<div class='recipe_quantity'>" + quantity + "</div>" +
		    	               				"</div>" +
		    	               			"</li>").appendTo(".recipeList");
		            			}
		            		}
		            		
		            		$(window).bind("scroll", recommandInfinityScrollFunction);
		            		
		            		TrueAndFalse2 = true;
		    				AscAndDesc2 = "DESC";
		            		
						}, error : function(data){
							console.log("조회 순서로 정렬 실패!");
						}
					});
				}
		}
		
		function levelAndTime(){
		
			count = 9;
			var keyWord = '${searchRecipeWord}';
			var str1 = "★채우는 공간";   
            var str2 = "Recipe !";
			console.log("keyWord : " + keyWord);
			console.log("levelAndTime TnF : " + TrueAndFalse3);
			if(TrueAndFalse3 == true) {
				$.ajax({
					url : "${pageContext.request.contextPath}/home/levelAndTimeBefore.do",
					dataType : "json",
					type : "GET",
					data : {
						keyWord : keyWord,
						TrueAndFalse : TrueAndFalse3,
						AscAndDesc : AscAndDesc3
					}, success : function(data){
						console.log("조회순서로 정렬 성공!");
						var level = "";
	               		var rTime = "";
	               		var quantity = "";
	               		var rName = "";
	            		var rNameSub ="";
	            		var grade = "";
						var gradeC ="";
						// 기존 scroll이벤트 제거
						$(window).unbind("scroll");
						$(".recipeList").empty();
						
	            		for(var i = 0; i < data.length; i++){

	            			rName = data[i].rName;
	            			grade = data[i].grade;
	            			
	            			if(data[i].rLevel == 1){
	                			level="아무나";
	                		} else if(data[i].rLevel == 2){
	                			level="초급";
	                		} else if(data[i].rLevel == 3) {
	                			level="중급";
	                		} else {
	                			level="고급";
	                		}
	            			if(data[i].rTime == 1){
	            				rTime="10분 이내";
	                		} else if(data[i].rTime == 2){
	                			rTime="20분 이내";
	                		} else if(data[i].rTime == 3) {
	                			rTime="30분 이내";
	                		} else if(data[i].rTime == 4) {
	                			rTime="60분 이내";
	                		} else {
	                			rTime="60분 이상";
	                		}
	            			if(data[i].quantity == 1){
	            				quantity = "1인분";
	                		} else if(data[i].quantity == 2){
	                			quantity = "2인분";
	                		} else if(data[i].quantity == 3) {
	                			quantity = "3인분";
	                		} else if(data[i].quantity == 4) {
	                			quantity = "4인분";
	                		} else if(data[i].quantity == 5) {
	                			quantity = "5인분";
	                		} else {
	                			quantity = "5인분 이상";
	                		}
	            			if(rName.length <= 6){
		               			rNameSub = rName.substring(0, 9);
	            			} else {
	            				rNameSub = rName.substring(0, 15) + " . . .";
	            			}
	            			if( grade == 0){
	            				gradeC = "0점";
	            			} else {
	            				gradeC = parseFloat(grade).toFixed(1) + "점";
	            			}
	            			if(data[i].rcCheck == data[i].rNum ){
		            			$("<li>" + 
		               				"<div class='like_and_aver_area'>" +
		               					"<div class='like_btn_area'>" +
		               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
		               						"<i class='fas fa-thumbs-up'></i>" +
		               						"</button>" +
		               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
			          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
		        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
		        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
		               					"</div>" + 
		               					"<div class='aver_btn_area'>" + 
		               						gradeC +
		               					"</div> " +
		               				"</div>" + 
		               				"<div class='recipe_img_area'>" +
		               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
		               					"<div class='img_hover_area'>" + 
			               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
				               					rNameSub +
			    							"</a>" +
		               					"</div>" +
		               				"</div>" +
		               				"<div class='recipe_levle_and_time_and_writer_area'>" +
		               					"<div class='recipe_level'>" + level + "</div>" +
		               					"<div class='recipe_time'>" + rTime + "</div>" +
		               					"<div class='recipe_quantity'>" + quantity + "</div>" +
		               				"</div>" +
		               			"</li>").appendTo(".recipeList");
		            			
		            			} else if(data[i].rcCheck != data[i].rNum ){
		            				$("<li>" + 
		    	               				"<div class='like_and_aver_area'>" +
		    	               					"<div class='like_btn_area'>" +
		    	               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
		    	               						"<i class='far fa-thumbs-up'></i>" +
		    	               						"</button>" +
		    	               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
		    		          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
		    	        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
		    	        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
		    	               					"</div>" + 
		    	               					"<div class='aver_btn_area'>" + 
		    	               						gradeC +
		    	               					"</div> " +
		    	               				"</div>" + 
		    	               				"<div class='recipe_img_area'>" +
		    	               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
		    	               					"<div class='img_hover_area'>" + 
			    	               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
						               					rNameSub +
					    							"</a>" +
		    	               					"</div>" +
		    	               				"</div>" +
		    	               				"<div class='recipe_levle_and_time_and_writer_area'>" +
		    	               					"<div class='recipe_level'>" + level + "</div>" +
		    	               					"<div class='recipe_time'>" + rTime + "</div>" +
		    	               					"<div class='recipe_quantity'>" + quantity + "</div>" +
		    	               				"</div>" +
		    	               			"</li>").appendTo(".recipeList");
		            			}
	            		}
	            		
	            		$(window).bind("scroll", levelAndTimeInfinityScrollFunction);
	            		
	            		TrueAndFalse3 = false;
	    				AscAndDesc3 = "ASC";
	    				
					}, error : function(data){
						console.log("조회 순서로 정렬 실패!");
					}
				});
				
			} else {
				$.ajax({
					url : "${pageContext.request.contextPath}/home/levelAndTimeBefore.do",
					dataType : "json",
					type : "GET",
					data : {
						keyWord : keyWord,
						TrueAndFalse : TrueAndFalse3,
						AscAndDesc : AscAndDesc3
					}, success : function(data){
						console.log("조회순서로 정렬 성공!");
						var level = "";
	               		var rTime = "";
	               		var quantity = "";
	               		var rName = "";
	            		var rNameSub ="";
	            		var grade = "";
						var gradeC ="";
						// 기존 scroll이벤트 제거
						$(window).unbind("scroll");
						$(".recipeList").empty();
						
	            		for(var i = 0; i < data.length; i++){

	            			rName = data[i].rName;
	            			grade = data[i].grade;
	            			
	            			if(data[i].rLevel == 1){
	                			level="아무나";
	                		} else if(data[i].rLevel == 2){
	                			level="초급";
	                		} else if(data[i].rLevel == 3) {
	                			level="중급";
	                		} else {
	                			level="고급";
	                		}
	            			if(data[i].rTime == 1){
	            				rTime="10분 이내";
	                		} else if(data[i].rTime == 2){
	                			rTime="20분 이내";
	                		} else if(data[i].rTime == 3) {
	                			rTime="30분 이내";
	                		} else if(data[i].rTime == 4) {
	                			rTime="60분 이내";
	                		} else {
	                			rTime="60분 이상";
	                		}
	            			if(data[i].quantity == 1){
	            				quantity = "1인분";
	                		} else if(data[i].quantity == 2){
	                			quantity = "2인분";
	                		} else if(data[i].quantity == 3) {
	                			quantity = "3인분";
	                		} else if(data[i].quantity == 4) {
	                			quantity = "4인분";
	                		} else if(data[i].quantity == 5) {
	                			quantity = "5인분";
	                		} else {
	                			quantity = "5인분 이상";
	                		}
	            			if(rName.length <= 6){
		               			rNameSub = rName.substring(0, 9);
	            			} else {
	            				rNameSub = rName.substring(0, 15) + " . . .";
	            			}
	            			if( grade == 0){
	            				gradeC = "0점";
	            			} else {
	            				gradeC = parseFloat(grade).toFixed(1) + "점";
	            			}
	            			if(data[i].rcCheck == data[i].rNum ){
		            			$("<li>" + 
		               				"<div class='like_and_aver_area'>" +
		               					"<div class='like_btn_area'>" +
		               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
		               						"<i class='fas fa-thumbs-up'></i>" +
		               						"</button>" +
		               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
			          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
		        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
		        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
		               					"</div>" + 
		               					"<div class='aver_btn_area'>" + 
		               						gradeC +
		               					"</div> " +
		               				"</div>" + 
		               				"<div class='recipe_img_area'>" +
		               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
		               					"<div class='img_hover_area'>" + 
			               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
				               					rNameSub +
			    							"</a>" +
		               					"</div>" +
		               				"</div>" +
		               				"<div class='recipe_levle_and_time_and_writer_area'>" +
		               					"<div class='recipe_level'>" + level + "</div>" +
		               					"<div class='recipe_time'>" + rTime  + "</div>" +
		               					"<div class='recipe_quantity'>" + quantity + "</div>" +
		               				"</div>" +
		               			"</li>").appendTo(".recipeList");
		            			
		            			} else if(data[i].rcCheck != data[i].rNum ){
		            				$("<li>" + 
		    	               				"<div class='like_and_aver_area'>" +
		    	               					"<div class='like_btn_area'>" +
		    	               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
		    	               						"<i class='far fa-thumbs-up'></i>" +
		    	               						"</button>" +
		    	               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
		    		          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
		    	        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
		    	        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
		    	               					"</div>" + 
		    	               					"<div class='aver_btn_area'>" + 
		    	               						 gradeC +
		    	               					"</div> " +
		    	               				"</div>" + 
		    	               				"<div class='recipe_img_area'>" +
		    	               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
		    	               					"<div class='img_hover_area'>" +
			    	               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
						               					rNameSub +
					    							"</a>" +
		    	               					"</div>" +
		    	               				"</div>" +
		    	               				"<div class='recipe_levle_and_time_and_writer_area'>" +
		    	               					"<div class='recipe_level'>" + level + "</div>" +
		    	               					"<div class='recipe_time'>" + rTime  + "</div>" +
		    	               					"<div class='recipe_quantity'>" + quantity + "</div>" +
		    	               				"</div>" +
		    	               			"</li>").appendTo(".recipeList");
		            			}
		            		}
		            		
		            		$(window).bind("scroll", levelAndTimeInfinityScrollFunction);
		            		
		            		TrueAndFalse3 = true;
		    				AscAndDesc3 = "DESC";
		    			
						}, error : function(data){
							console.log("조회 순서로 정렬 실패!");
						}
					});
				}
			
		}
		
		/* 조회수 스크롤 페이징 */
		function inquiryInfinityScrollFunction() {
			//var endCount = ${inquiryEndCount};
			//console.log("endCount : " + endCount);
			//if(endCount <= num){
			//현재문서의 높이를 구함.
            var documentHeight = $(document).height();
            //console.log("documentHeight : " + documentHeight);

            //scrollTop() 메서드는 선택된 요소의 세로 스크롤 위치를 설정하거나 반환    
            //스크롤바가 맨 위쪽에 있을때 , 위치는 0
            //console.log("window의 scrollTop() : " + $(window).scrollTop());
            //height() 메서드는 브라우저 창의 높이를 설정하거나 반환
            //console.log("window의 height() : " + $(window).height());

            //세로 스크롤위치 max값과 창의 높이를 더하면 현재문서의 높이를 구할수있음.
            //세로 스크롤위치 값이 max이면 문서의 끝에 도달했다는 의미
            var scrollHeight = $(window).scrollTop() + $(window).height();
            //console.log("scrollHeight : " + scrollHeight);
    
            if (scrollHeight == documentHeight) { //문서의 맨끝에 도달했을때 내용 추가 
            
            	 var str1 = "★채우는 공간";   
                 var str2 = "Recipe !";
                console.log("count : " + count);
                $.ajax({
	            	url : "${pageContext.request.contextPath}/home/inquiryAfter.do",
	            	dataType : "json",
	            	type : "GET",
	            	data : {
	            		number : count,
	            		keyWord : keyWord,
	            		TrueAndFalse : TrueAndFalse1,
						AscAndDesc : AscAndDesc1
	            	},success: function(data){
	               		count += 9;
	               		
	               		console.log("조회수 정렬 스크롤 페이징 실행 성공!");
	               		//console.log("정렬 후 count : " + count)
	               		var level = "";
	               		var rTime = "";
	               		var quantity = "";
	               		var rName = "";
	            		var rNameSub ="";
	            		var grade = "";
						var gradeC ="";
						$(window).unbind("scroll");
	            		$(".recipeList").remove("li");
	            		for(var i = 0; i < data.length; i++){
	            			
	            			rName = data[i].rName;
	            			grade = data[i].grade;
	            			
	            			if(data[i].rLevel == 1){
	                			level="아무나";
	                		} else if(data[i].rLevel == 2){
	                			level="초급";
	                		} else if(data[i].rLevel == 3) {
	                			level="중급";
	                		} else {
	                			level="고급";
	                		}
	            			if(data[i].rTime == 1){
	            				rTime="10분 이내";
	                		} else if(data[i].rTime == 2){
	                			rTime="20분 이내";
	                		} else if(data[i].rTime == 3) {
	                			rTime="30분 이내";
	                		} else if(data[i].rTime == 4) {
	                			rTime="60분 이내";
	                		} else {
	                			rTime="60분 이상";
	                		}
	            			if(data[i].quantity == 1){
	            				quantity = "1인분";
	                		} else if(data[i].quantity == 2){
	                			quantity = "2인분";
	                		} else if(data[i].quantity == 3) {
	                			quantity = "3인분";
	                		} else if(data[i].quantity == 4) {
	                			quantity = "4인분";
	                		} else if(data[i].quantity == 5) {
	                			quantity = "5인분";
	                		} else {
	                			quantity = "5인분 이상";
	                		}
	            			if(rName.length <= 6){
		               			rNameSub = rName.substring(0, 9);
	            			} else {
	            				rNameSub = rName.substring(0, 15) + " . . .";
	            			}
	            			if( grade == 0){
	            				gradeC = "0점";
	            			} else {
	            				gradeC = parseFloat(grade).toFixed(1) + "점";
	            			}
	            			if(data[i].rcCheck == data[i].rNum ){
		            			$("<li>" + 
		               				"<div class='like_and_aver_area'>" +
		               					"<div class='like_btn_area'>" +
		               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
		               						"<i class='fas fa-thumbs-up'></i>" +
		               						"</button>" +
		               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
			          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
		        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
		        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
		               					"</div>" + 
		               					"<div class='aver_btn_area'>" + 
		               						gradeC +
		               					"</div> " +
		               				"</div>" + 
		               				"<div class='recipe_img_area'>" +
		               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
		               					"<div class='img_hover_area'>" + 
			               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
				               					rNameSub +
			    							"</a>" +
		               					"</div>" +
		               				"</div>" +
		               				"<div class='recipe_levle_and_time_and_writer_area'>" +
		               					"<div class='recipe_level'>" + level + "</div>" +
		               					"<div class='recipe_time'>" + rTime + "</div>" +
		               					"<div class='recipe_quantity'>" + quantity + "</div>" +
		               				"</div>" +
		               			"</li>").appendTo(".recipeList");
		            			
		            			} else if(data[i].rcCheck != data[i].rNum ){
		            				$("<li>" + 
		    	               				"<div class='like_and_aver_area'>" +
		    	               					"<div class='like_btn_area'>" +
		    	               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
		    	               						"<i class='far fa-thumbs-up'></i>" +
		    	               						"</button>" +
		    	               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
		    		          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
		    	        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
		    	        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
		    	               					"</div>" + 
		    	               					"<div class='aver_btn_area'>" + 
		    	               						gradeC +
		    	               					"</div> " +
		    	               				"</div>" + 
		    	               				"<div class='recipe_img_area'>" +
		    	               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
		    	               					"<div class='img_hover_area'>" + 
			    	               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
						               					rNameSub +
					    							"</a>" +
		    	               					"</div>" +
		    	               				"</div>" +
		    	               				"<div class='recipe_levle_and_time_and_writer_area'>" +
		    	               					"<div class='recipe_level'>" + level + "</div>" +
		    	               					"<div class='recipe_time'>" + rTime + "</div>" +
		    	               					"<div class='recipe_quantity'>" + quantity + "</div>" +
		    	               				"</div>" +
		    	               			"</li>").appendTo(".recipeList");
		            			}
	            		}
	            		
	            		 /* Top 버튼 */
	           		   $(document).ready(function () {
	           				$(window).scroll(function () {
	           					var _scrollTop = $(this).scrollTop(),
	           						$gotopBtn = $('.top_btn');
	           					if (_scrollTop > 10) { $gotopBtn.fadeIn(); }
	           					else { $gotopBtn.fadeOut(); }
	           				})
	           				$('.click').bind("click", function () {
	           					/* $('.click').css('text-decoration', 'none'); */
	           					$('html, body').animate({
	           						"scrollTop": 0
	           					}, 300);
	           				});
	           			});
	            		
	            		$(window).bind("scroll", inquiryInfinityScrollFunction);
	            		
					}, error : function(data){
						console.log("조회 순서로 정렬 실패!");
					}
				});
			}
			}
			
            /* 추천수 스크롤 페이징 */
            function recommandInfinityScrollFunction() {
				//var endCount = ${inquiryEndCount};
				//console.log("endCount : " + endCount);
				//if(endCount <= num){
				//현재문서의 높이를 구함.
	            var documentHeight = $(document).height();
	            //console.log("documentHeight : " + documentHeight);

	            //scrollTop() 메서드는 선택된 요소의 세로 스크롤 위치를 설정하거나 반환    
	            //스크롤바가 맨 위쪽에 있을때 , 위치는 0
	            //console.log("window의 scrollTop() : " + $(window).scrollTop());
	            //height() 메서드는 브라우저 창의 높이를 설정하거나 반환
	            //console.log("window의 height() : " + $(window).height());

	            //세로 스크롤위치 max값과 창의 높이를 더하면 현재문서의 높이를 구할수있음.
	            //세로 스크롤위치 값이 max이면 문서의 끝에 도달했다는 의미
	            var scrollHeight = $(window).scrollTop() + $(window).height();
	     
	            if (scrollHeight == documentHeight) { //문서의 맨끝에 도달했을때 내용 추가 
	            
	            	 var str1 = "★채우는 공간";   
	                 var str2 = "Recipe !";
	                 
	                $.ajax({
		            	url : "${pageContext.request.contextPath}/home/recommandAfter.do",
		            	dataType : "json",
		            	type : "GET",
		            	data : {
		            		number : count,
		            		keyWord : keyWord,
		            		TrueAndFalse : TrueAndFalse2,
							AscAndDesc : AscAndDesc2
		            	},success: function(data){
		               		count += 9;
		               		
		               		var level = "";
		               		var rTime = "";
		               		var quantity = "";
		               		var rName = "";
		            		var rNameSub ="";
		            		var grade = "";
							var gradeC ="";
							$(window).unbind("scroll");
		               		$(".recipeList").remove("li");
		            		for(var i = 0; i < data.length; i++){
		            			
		            			rName = data[i].rName;
		            			grade = data[i].grade;
		            			
		            			if(data[i].rLevel == 1){
		                			level="아무나";
		                		} else if(data[i].rLevel == 2){
		                			level="초급";
		                		} else if(data[i].rLevel == 3) {
		                			level="중급";
		                		} else {
		                			level="고급";
		                		}
		            			if(data[i].rTime == 1){
		            				rTime="10분 이내";
		                		} else if(data[i].rTime == 2){
		                			rTime="20분 이내";
		                		} else if(data[i].rTime == 3) {
		                			rTime="30분 이내";
		                		} else if(data[i].rTime == 4) {
		                			rTime="60분 이내";
		                		} else {
		                			rTime="60분 이상";
		                		}
		            			if(data[i].quantity == 1){
		            				quantity = "1인분";
		                		} else if(data[i].quantity == 2){
		                			quantity = "2인분";
		                		} else if(data[i].quantity == 3) {
		                			quantity = "3인분";
		                		} else if(data[i].quantity == 4) {
		                			quantity = "4인분";
		                		} else if(data[i].quantity == 5) {
		                			quantity = "5인분";
		                		} else {
		                			quantity = "5인분 이상";
		                		}
		            			if(rName.length <= 6){
			               			rNameSub = rName.substring(0, 9);
		            			} else {
		            				rNameSub = rName.substring(0, 15) + " . . .";
		            			}
		            			if( grade == 0){
		            				gradeC = "0점";
		            			} else {
		            				gradeC = parseFloat(grade).toFixed(1) + "점";
		            			}
		            			if(data[i].rcCheck == data[i].rNum ){
			            			$("<li>" + 
			               				"<div class='like_and_aver_area'>" +
			               					"<div class='like_btn_area'>" +
			               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
			               						"<i class='fas fa-thumbs-up'></i>" +
			               						"</button>" +
			               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
				          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
			        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
			        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
			               					"</div>" + 
			               					"<div class='aver_btn_area'>" + 
			               						gradeC +
			               					"</div> " +
			               				"</div>" + 
			               				"<div class='recipe_img_area'>" +
			               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
			               					"<div class='img_hover_area'>" + 
				               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
					               					rNameSub +
				    							"</a>" +
			               					"</div>" +
			               				"</div>" +
			               				"<div class='recipe_levle_and_time_and_writer_area'>" +
			               					"<div class='recipe_level'>" + level + "</div>" +
			               					"<div class='recipe_time'>" + rTime + "</div>" +
			               					"<div class='recipe_quantity'>" + quantity + "</div>" +
			               				"</div>" +
			               			"</li>").appendTo(".recipeList");
			            			
			            			} else if(data[i].rcCheck != data[i].rNum ){
			            				$("<li>" + 
			    	               				"<div class='like_and_aver_area'>" +
			    	               					"<div class='like_btn_area'>" +
			    	               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
			    	               						"<i class='far fa-thumbs-up'></i>" +
			    	               						"</button>" +
			    	               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
			    		          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
			    	        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
			    	        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
			    	               					"</div>" + 
			    	               					"<div class='aver_btn_area'>" + 
			    	               						gradeC +
			    	               					"</div> " +
			    	               				"</div>" + 
			    	               				"<div class='recipe_img_area'>" +
			    	               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
			    	               					"<div class='img_hover_area'>" +
				    	               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
							               					rNameSub +
						    							"</a>" +
			    	               					"</div>" +
			    	               				"</div>" +
			    	               				"<div class='recipe_levle_and_time_and_writer_area'>" +
			    	               					"<div class='recipe_level'>" + level + "</div>" +
			    	               					"<div class='recipe_time'>" + rTime + "</div>" +
			    	               					"<div class='recipe_quantity'>" + quantity + "</div>" +
			    	               				"</div>" +
			    	               			"</li>").appendTo(".recipeList");
			            			}
		            		}
		            		
		            		 /* Top 버튼 */
		           		   $(document).ready(function () {
		           				$(window).scroll(function () {
		           					var _scrollTop = $(this).scrollTop(),
		           						$gotopBtn = $('.top_btn');
		           					if (_scrollTop > 10) { $gotopBtn.fadeIn(); }
		           					else { $gotopBtn.fadeOut(); }
		           				})
		           				$('.click').bind("click", function () {
		           					/* $('.click').css('text-decoration', 'none'); */
		           					$('html, body').animate({
		           						"scrollTop": 0
		           					}, 300);
		           				});
		           			});
		            		
		            		$(window).bind("scroll", recommandInfinityScrollFunction);
		            		
						}, error : function(data){
							console.log("추천 순서로 정렬 실패!");
						}
					});
				}
								
			}
			
			function levelAndTimeInfinityScrollFunction() {
				//현재문서의 높이를 구함.
	            var documentHeight = $(document).height();

	            //scrollTop() 메서드는 선택된 요소의 세로 스크롤 위치를 설정하거나 반환    
	            //스크롤바가 맨 위쪽에 있을때 , 위치는 0
	            //height() 메서드는 브라우저 창의 높이를 설정하거나 반환

	            //세로 스크롤위치 max값과 창의 높이를 더하면 현재문서의 높이를 구할수있음.
	            //세로 스크롤위치 값이 max이면 문서의 끝에 도달했다는 의미
	            var scrollHeight = $(window).scrollTop() + $(window).height();
	         
	            if (scrollHeight == documentHeight) { //문서의 맨끝에 도달했을때 내용 추가 
	            
	            	 var str1 = "★채우는 공간";   
	                 var str2 = "Recipe !";
	                 
	                $.ajax({
		            	url : "${pageContext.request.contextPath}/home/levelAndTimeAfter.do",
		            	dataType : "json",
		            	type : "GET",
		            	data : {
		            		number : count,
		            		keyWord : keyWord,
		            		TrueAndFalse : TrueAndFalse3,
							AscAndDesc : AscAndDesc3
		            	},success: function(data){
		               		count += 9;

		               		var level = "";
		               		var rTime = "";
		               		var quantity = "";
		               		var rName = "";
		            		var rNameSub ="";
		            		var grade = "";
							var gradeC ="";
							$(window).unbind("scroll");
		               		$(".recipeList").remove("li");
		            		for(var i = 0; i < data.length; i++){
		            			
		            			rName = data[i].rName;
		            			grade = data[i].grade;
		            			
		            			if(data[i].rLevel == 1){
		                			level="아무나";
		                		} else if(data[i].rLevel == 2){
		                			level="초급";
		                		} else if(data[i].rLevel == 3) {
		                			level="중급";
		                		} else {
		                			level="고급";
		                		}
		            			if(data[i].rTime == 1){
		            				rTime="10분 이내";
		                		} else if(data[i].rTime == 2){
		                			rTime="20분 이내";
		                		} else if(data[i].rTime == 3) {
		                			rTime="30분 이내";
		                		} else if(data[i].rTime == 4) {
		                			rTime="60분 이내";
		                		} else {
		                			rTime="60분 이상";
		                		}
		            			if(data[i].quantity == 1){
		            				quantity = "1인분";
		                		} else if(data[i].quantity == 2){
		                			quantity = "2인분";
		                		} else if(data[i].quantity == 3) {
		                			quantity = "3인분";
		                		} else if(data[i].quantity == 4) {
		                			quantity = "4인분";
		                		} else if(data[i].quantity == 5) {
		                			quantity = "5인분";
		                		} else {
		                			quantity = "5인분 이상";
		                		}
		            			if(rName.length <= 6){
			               			rNameSub = rName.substring(0, 9);
		            			} else {
		            				rNameSub = rName.substring(0, 15) + " . . .";
		            			}
		            			if( grade == 0){
		            				gradeC = "0점";
		            			} else {
		            				gradeC = parseFloat(grade).toFixed(1) + "점";
		            			}
		            			if(data[i].rcCheck == data[i].rNum ){
			            			$("<li>" + 
			               				"<div class='like_and_aver_area'>" +
			               					"<div class='like_btn_area'>" +
			               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
			               						"<i class='fas fa-thumbs-up'></i>" +
			               						"</button>" +
			               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
				          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
			        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
			        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
			               					"</div>" + 
			               					"<div class='aver_btn_area'>" + 
			               						gradeC +
			               					"</div> " +
			               				"</div>" + 
			               				"<div class='recipe_img_area'>" +
			               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
			               					"<div class='img_hover_area'>" + 
				               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
					               					rNameSub +
				    							"</a>" +
			               					"</div>" +
			               				"</div>" +
			               				"<div class='recipe_levle_and_time_and_writer_area'>" +
			               					"<div class='recipe_level'>" + level + "</div>" +
			               					"<div class='recipe_time'>" + rTime + "</div>" +
			               					"<div class='recipe_quantity'>" + quantity + "</div>" +
			               				"</div>" +
			               			"</li>").appendTo(".recipeList");
			            			
			            			} else if(data[i].rcCheck != data[i].rNum ){
			            				$("<li>" + 
			    	               				"<div class='like_and_aver_area'>" +
			    	               					"<div class='like_btn_area'>" +
			    	               						"<button onfocus=this.blur() type='button' class='like_btn' onclick='likeClicked(this);'>" +
			    	               						"<i class='far fa-thumbs-up'></i>" +
			    	               						"</button>" +
			    	               						"<input id='recipeMNum' type='hidden' value='"+ data[i].mNum +"' />" +
			    		          						"<input id='recipeRNum' type='hidden' value='"+ data[i].rNum +"'  />" + 
			    	        							"<input id='recipeRRecommend' type='hidden' value='"+ data[i].rRecommend +"' />" +
			    	        							"<input id='rcCheck' type='hidden' value='" + data[i].rcCheck +"' />" +
			    	               					"</div>" + 
			    	               					"<div class='aver_btn_area'>" + 
			    	               						gradeC +
			    	               					"</div> " +
			    	               				"</div>" + 
			    	               				"<div class='recipe_img_area'>" +
			    	               				"<img class='food_img img-thumbnail' src='${pageContext.request.contextPath}/resources/img/recipeContent/" + data[i].rImg + "'>" +
			    	               					"<div class='img_hover_area'>" + 
				    	               					"<a class='recipe_move_detail' style='color: palegreen;' onclick=\"location.href='${pageContext.request.contextPath}/recipe/recipeDetail.do?rNum=" + data[i].rNum+ "'\">" +
							               					rNameSub +
						    							"</a>" +
			    	               					"</div>" +
			    	               				"</div>" +
			    	               				"<div class='recipe_levle_and_time_and_writer_area'>" +
			    	               					"<div class='recipe_level'>" + level + "</div>" +
			    	               					"<div class='recipe_time'>" + rTime + "</div>" +
			    	               					"<div class='recipe_quantity'>" + quantity + "</div>" +
			    	               				"</div>" +
			    	               			"</li>").appendTo(".recipeList");
			            			}
		            		}
		            		
		            		 /* Top 버튼 */
		           		   $(document).ready(function () {
		           				$(window).scroll(function () {
		           					var _scrollTop = $(this).scrollTop(),
		           						$gotopBtn = $('.top_btn');
		           					if (_scrollTop > 10) { $gotopBtn.fadeIn(); }
		           					else { $gotopBtn.fadeOut(); }
		           				})
		           				$('.click').bind("click", function () {
		           					/* $('.click').css('text-decoration', 'none'); */
		           					$('html, body').animate({
		           						"scrollTop": 0
		           					}, 300);
		           				});
		           			});
		            		
		            		$(window).bind("scroll", levelAndTimeInfinityScrollFunction);
		            		
						}, error : function(data){
							console.log("조회 순서로 정렬 실패!");
						}
					});
				}
				}	
				
	        function likeClicked(obj) {
	           
	        	/* 멤버 정보를 받아와야해 
	        	
	        		1.로그인이 안되어 있을 경우
					  	-> 로그인 창이 뜨게 처리  : 해결
					
					2. 로그인이 되어있을 경우					   
					   	-> 버튼 클릭시 RECIPE 테이블의 recommand 수 +1
					  
					   RECOMMAND 테이블에 로그인한 멤버 번호 mNum과 레시피 번호인 rNum 을 insert
					
					3. 다시 클릭했을 경우 반대로 처리한다.(DLELTE)

	        	*/
	        	
	        	 /* 로그인했을 때 */ 
	      		  if ('${m.mId}' != "") {
	        		console.log("따봉 버튼 메소드 실행");
	        		console.log("멤버 값 : " + '${m.mId}');
	        		
	        		var mId = '${m.mId}'; // 로그인한 멤버 id
	        		var classs = $(obj).children().attr('class');
	        		var mNum = '${m.mNum}'; // 로그인한 멤버 번호
	        		var recipeMNum = $(obj).siblings('#recipeMNum').val(); // 레시피를 등록한 멤버 번호
	        		var recipeRNum = $(obj).siblings('#recipeRNum').val(); // 등록한 레시피 번호
	        		var recipeRRecommend = $(obj).siblings('#recipeRRecommend').val(); // 등록된 레시피의 추천수
	        		
	        		console.log("mId : " + mId);
	        		console.log("mNum : " + mNum);
	        		console.log("classs : " + classs);
	        		console.log("인덱스 : " + classs.indexOf(mNum));
	        		console.log("recipeMNum : " + $(obj).siblings('#recipeMNum').val());
	        		console.log("recipeRNum : " + $(obj).siblings('#recipeRNum').val());
	        		console.log("recipeRRecommend : " + $(obj).siblings('#recipeRRecommend').val());
	        		console.log("sdf:"+$(obj).siblings('#rcCheck').val());
	        		
	        		 if ($(obj).children().hasClass('far fa-thumbs-up')) {
			                $(obj).children().removeClass('far fa-thumbs-up').addClass('fas fa-thumbs-up');
			                
			                if(classs.indexOf(mNum) != 0)	{
			                     $.ajax({
			                    	 url : "${pageContext.request.contextPath}/home/likeBtnCheck.do",
			                    	 type: "GET",
			                    	 dataType : "json",
			                    	 data : {
			                    	
			                    		 mNum : mNum,
			                    		 recipeRNum : recipeRNum,
			                    		 recipeRRecommend : recipeRRecommend
			                    		 
			                    	 }, success : function(data){
			                    		 
			                    		console.log("ajax에서 추천 성공!");
			                    		
			                    		
			                    	 }, error : function(data){
			                    		 
			                    		 console.log("ajax 찜목록 진입 실패!");
			                    		 
			                    	 }
		                     	});
			                } 
	        		 	}
			            else if ($(obj).children().hasClass('fas fa-thumbs-up')) {
			                $(obj).children().removeClass('fas fa-thumbs-up').addClass('far fa-thumbs-up');
			                
			                if(classs.indexOf(mNum) != 0)	{
			                     $.ajax({
			                    	 url : "${pageContext.request.contextPath}/home/likeBtnCancel.do",
			                    	 type: "GET",
			                    	 dataType : "json",
			                    	 data : {
			                    	
			                    		 mNum : mNum,
			                    		 recipeRNum : recipeRNum,
			                    		 recipeRRecommend : recipeRRecommend
			                    		 
			                    	 }, success : function(data){
			                    		 
			                    		console.log("ajax에서 추천 성공!");
			                    		
			                    		
			                    	 }, error : function(data){
			                    		 
			                    		 console.log("ajax 찜목록 진입 실패!");
			                    		 
			                    	 }
		                     	});
			                } 
			                
			            }

	      		  } else {
		      			swal("로그인을 해야 합니다.", "", "warning").then((value) => {
		   					$("#loginModal").modal();
		   				});
	      		  }
	           
			}
		
	    </script>
	</body>
</html>