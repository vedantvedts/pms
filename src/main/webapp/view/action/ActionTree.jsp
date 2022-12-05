<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Action Tree</title>
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/plugins/HTree/HTree.css" var="HTreecss" />
<link href="${HTreecss}" rel="stylesheet" />
<spring:url value="/resources/plugins/HTree/HTree.js" var="HTreejs" />
<script src="${HTreejs}"></script>

<style type="text/css">
.action-box
{
	width: fit-content;
    min-width: 200px;
    max-width: 300px;
    height: fit-content;
    min-height: 150px;
    border: 1px solid black;
    border-radius: 5px;
}

.action-box-header
{
	display: inline-block;
    flex-wrap: wrap;
    justify-content: center;
    min-height: 75px;
    max-height: 95px;
	background: #E5D9B6;
	
	
	padding:10px;
   
    text-align:justify;
     min-width: 200px;
    max-width: 300px;
  
    
    overflow: hidden;
    
    -ms-word-break: break-word;
    -ms-hyphens: auto;
    -moz-hyphens: auto;
    -webkit-hyphens: auto;
    
    direction: ltr;
    hyphens: auto;
    word-break: break-word;
    text-overflow: ellipsis;
    overflow-wrap: break-word;
  	white-space: initial;
}


</style>

</head>
<body>
<%
	List<Object[]> actionslist = (List<Object[]>)request.getAttribute("actionslist");
	
	int startLevel = 0;
	
%>

<%=actionslist.size()%>


<%if(actionslist.size()>0){
	startLevel = Integer.parseInt(actionslist.get(0)[3].toString());
} %>

<div class="body genealogy-body genealogy-scroll">
    <div class="genealogy-tree">
        
        
        
        
        
<%if(startLevel > 0){ %> 
	<%for(Object[] action : actionslist){ %>
		<% if(Integer.parseInt(action[3].toString()) == startLevel){ %>
			<ul>
	            <li>
	                <a href="javascript:void(0);">
	                    <div class="member-view-box">
	                        <div class="member-image action-box" >
	                          	<div class="action-box-header">
	                          		
	                          		<%=action[5] %>           
	                          		
	                          	</div>
	                          	<div class="action-box-body">
	                          	
	                          	</div>
	                        </div>
	                    </div>
	                </a>
	                <ul class="active">
	                	
	                </ul>
	            </li>
	        </ul>
		<% } %>
	<% } %>
<%} %>        
        

    </div>
</div>
    
    
    
    
<!--     <ul> -->
<!--             <li> -->
<!--                 <a href="javascript:void(0);"> -->
<!--                     <div class="member-view-box"> -->
<!--                         <div class="member-image action-box" > -->
<!--                           	<div class="action-box-header"> -->
<!--                           		Dinesh -->
<!--                           	</div> -->
<!--                           	<div class="action-box-body"> -->
                          	
<!--                           	</div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </a> -->
<!--                 <ul class="active"> -->
                	
<!--                 </ul> -->
<!--             </li> -->
<!--         </ul> -->

  
</body>
</html>