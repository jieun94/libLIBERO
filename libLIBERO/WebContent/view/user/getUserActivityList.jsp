<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<jsp:include page="/common/cdn.jsp"></jsp:include>
		<!--  ///////////////////////// CSS ////////////////////////// -->
		<link rel="stylesheet" href="../resources/css/common.css">
		<script type="text/javascript">
			function fncGetUserList(currentPage) {
			$("#currentPage").val(currentPage);
			$("form").attr("method", "POST").attr("action", "/libero/user/getUserActivityList").submit();	
			}
			

			$(function() {
				
				$("#myPost").on("click", function() {
		            $("#myPost").css("display", "block");
		            $("#myComment").css("display", "none");
		            $("#myQna").css("display", "none");
		            
		        })

		        $("#myComment").on("click", function() {
		            $("#myComment").css("display", "block");
		            $("#myPost").css("display", "none");
		            $("#myQna").css("display", "none");
		          
		        })
		        
		        $("#myQna").on("click", function() {
		        	 $("#myQna").css("display", "block");
		             $("#myPost").css("display", "none");
		             $("#myComment").css("display", "none");
		          
		        })
				
			});
				
		</script>
	</head>
	<body>
		<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="../toolbar.jsp" />
	   	<!-- ToolBar End /////////////////////////////////////-->
	   	
	   	<!-- //////////// Bootstrap Container Start////////////////// -->
	   	<div class="container">
	   		<jsp:include page="topButton.jsp"></jsp:include>
	   		<div class="row">
		   		<div class="col-lg-2">
		   			<a href="/libero/user/getUserActivityList?menu=post" 
		   				class="btn btn-outline-default waves-effect btn-block" role="button" 
		   				aria-pressed="true" style="margin-bottom: 10px">작성한 글</a>
		   				
		   			<a href="/libero/user/getUserActivityList?menu=comment" 
		   				class="btn btn-outline-default waves-effect btn-block" role="button" 
		   				aria-pressed="true" style="margin-bottom: 10px">작성한 댓글</a>
		   				
		   			<a href="#" 
		   				class="btn btn-outline-default waves-effect btn-block" role="button" 
		   				aria-pressed="true" style="margin-bottom: 10px">리뷰</a>
		   				
		   			<a href="/libero/user/getUserActivityList?menu=qna" 
		   				class="btn btn-outline-default waves-effect btn-block" role="button" 

		   				aria-pressed="true" style="margin-bottom: 10px">나의 문의</a>
		   		</div>
		   		<div class="col-lg-9">
		<c:if test="${param.menu=='post'}"> 	
		   		<table class="table table-hover" id="myPost" style="font-size: 14px;text-align: center;">
	            <thead>
	                <tr>
	                	<th align="center">No</th>
	                    <th align="left" >제목</th>
	                    <th align="left" >닉네임</th>
	                    <th align="left" >작성일</th>
	                    <th align="left" >조회수</th>
	       
	                </tr>
	            </thead>
            	<tbody>
              
			   		<c:set var="i" value="0" />
				  	<c:forEach var="post" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					
					
                    <tr>
                        
                  		<td align="center" onClick = "location.href='/libero/community/getPost?postNo=${post.postNo}'">${ i }</td>
                        <c:set var="postName" value="${post.postName}" />
                        <td align="left">${fn:substring(postName,0,20)}
                            <c:if test="${fn:length(postName)>20}">
                                ......
                            </c:if>
                            <%-- <font color='red'>(${post.comments})</font>--%>     
                        </td>
                        <input type="hidden" value="${post.postNo}"/>
                        <td>${user.nickname}</td>
                        <td>${post.regDate}</td>
                        <td>
                        	1
                        </td>
 
                    </tr>
                    
                    
                	</c:forEach>
                	<c:if test="${ empty list}">
		                <tr>
		                    <td colspan="6" style="padding: 40px;">아직 작성한 글이 없습니다</td>
		                </tr>
		            </c:if>
                	
                </tbody>
                </table>
        </c:if>
                <%-- ///////////////////////////////////////////////////////////////////////////// --%> 
		<c:if test="${param.menu=='comment'}">                
                <table class="table table-hover" id="myComment" style="font-size: 14px;text-align: center;">
	            <thead>
	                <tr>
	                	<th align="center">No</th>
	                    <th align="left" >내용</th>
	                    <th align="left" >닉네임</th>
	                    <th align="left" >작성일</th>
	                    <th align="left" >조회수</th>
	       
	                </tr>
	            </thead>
            	<tbody>
              
			   		<c:set var="i" value="0" />
				  	<c:forEach var="comment" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					
					
                    <tr>
                        
                  		<td align="center" onClick = "location.href='/libero/community/getPost?postNo=${comment.postNo}'">${ i }</td>
                        <c:set var="commentContent" value="${comment.commentContent}" />
                        <td align="left">${fn:substring(commentContent,0,20)}
                            <c:if test="${fn:length(commentContent)>20}">
                                ......
                            </c:if>
                            <%-- <font color='red'>(${post.comments})</font>--%>     
                        </td>
                        <input type="hidden" value="${comment.postNo}"/>
                        
                        <td>${user.nickname}</td>
                        <td>${comment.regDate}</td>
                        <td>
                        	1
                        </td>
 
                    </tr>
                    
                    
                	</c:forEach>
                	<c:if test="${ empty list}">
		                <tr>
		                    <td colspan="6" style="padding: 40px;">아직 작성한 댓글이 없습니다</td>
		                </tr>
		            </c:if>
                	
                </tbody>
                </table>
		</c:if>
		
		
				</div> <%-- col9 --%>
				</div> <%-- row --%>
</div> <%-- container--%>
<jsp:include page="../../common/pageNavigator_new.jsp"/>        
	</body>
	
	
	
	
</html>