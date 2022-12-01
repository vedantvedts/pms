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
    height: fit-content;
    min-height: 150px;
    border: 1px solid black;
    border-radius: 5px;
}

.action-box-header
{
    min-height: 75px;
	background: #E5D9B6;
}

</style>

</head>
<body>
<%
	List<Object[]> actionslist = (List<Object[]>)request.getAttribute("actionslist");
%>

<%=actionslist.size()%>


<div class="body genealogy-body genealogy-scroll">
    <div class="genealogy-tree">
        <ul>
            <li>
                <a href="javascript:void(0);">
                    <div class="member-view-box">
                        <div class="member-image action-box" >
                          	<div class="action-box-header">
                          		Dinesh
                          	</div>
                          	<div class="action-box-body">
                          	
                          	</div>
                        </div>
                    </div>
                </a>
                <ul class="active">
                    <li>
                        <a href="javascript:void(0);">
                            <div class="member-view-box">
                                <div class="member-view-box">
			                        <div class="member-image action-box" >
			                           Dinesh 1-1
			                        </div>
			                    </div>
                            </div>
                        </a>
                        <ul >
                            <li>
                                <a href="javascript:void(0);">
                                    <div class="member-view-box">
                                         <div class="member-view-box">
					                        <div class="member-image action-box" >
					                           Dinesh 1-2
					                        </div>
					                    </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:void(0);">
                                    <div class="member-view-box">
                                        <div class="member-image">
                                            <img src="view/images/authority.png" alt="Member">
                                            <div class="member-details">
                                                <h5>Member 1-2</h5>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:void(0);">
                                    <div class="member-view-box">
                                        <div class="member-image">
                                            <img src="view/images/authority.png" alt="Member">
                                            <div class="member-details">
                                                <h5>Member 1-3</h5>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                                <ul>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <div class="member-view-box">
                                                <div class="member-image">
                                                    <img src="view/images/authority.png" alt="Member">
                                                    <div class="member-details">
                                                        <h5>Member 1-3-1</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <div class="member-view-box">
                                                <div class="member-image">
                                                    <img src="view/images/authority.png" alt="Member">
                                                    <div class="member-details">
                                                        <h5>Member 1-3-2</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <div class="member-view-box">
                                                <div class="member-image">
                                                    <img src="view/images/authority.png" alt="Member">
                                                    <div class="member-details">
                                                        <h5>Member 1-3-3</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="javascript:void(0);">
                                    <div class="member-view-box">
                                        <div class="member-image">
                                            <img src="view/images/authority.png" alt="Member">
                                            <div class="member-details">
                                                <h5>Member 1-4</h5>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:void(0);">
                                    <div class="member-view-box">
                                        <div class="member-image">
                                            <img src="view/images/authority.png" alt="Member">
                                            <div class="member-details">
                                                <h5>Member 1-5</h5>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:void(0);">
                                    <div class="member-view-box">
                                        <div class="member-image">
                                            <img src="view/images/authority.png" alt="Member">
                                            <div class="member-details">
                                                <h5>Member 1-6</h5>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:void(0);">
                                    <div class="member-view-box">
                                        <div class="member-image">
                                            <img src="view/images/authority.png" alt="Member">
                                            <div class="member-details">
                                                <h5>Member 1-7</h5>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                                <ul>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <div class="member-view-box">
                                                <div class="member-image">
                                                    <img src="view/images/authority.png" alt="Member">
                                                    <div class="member-details">
                                                        <h5>Member 1-7-1</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <div class="member-view-box">
                                                <div class="member-image">
                                                    <img src="view/images/authority.png" alt="Member">
                                                    <div class="member-details">
                                                        <h5>Member 1-7-2</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                        <ul>
                                            <li>
                                                <a href="javascript:void(0);">
                                                    <div class="member-view-box">
                                                        <div class="member-image">
                                                            <img src="view/images/authority.png" alt="Member">
                                                            <div class="member-details">
                                                                <h5>Member 1-7-2-1</h5>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void(0);">
                                                    <div class="member-view-box">
                                                        <div class="member-image">
                                                            <img src="view/images/authority.png" alt="Member">
                                                            <div class="member-details">
                                                                <h5>Member 1-7-2-2</h5>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void(0);">
                                                    <div class="member-view-box">
                                                        <div class="member-image">
                                                            <img src="view/images/authority.png" alt="Member">
                                                            <div class="member-details">
                                                                <h5>Member 1-7-2-3</h5>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <div class="member-view-box">
                                                <div class="member-image">
                                                    <img src="view/images/authority.png" alt="Member">
                                                    <div class="member-details">
                                                        <h5>Member 1-7-3</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript:void(0);">
                            <div class="member-view-box">
                                <div class="member-image">
                                    <img src="view/images/authority.png" alt="Member">
                                    <div class="member-details">
                                        <h5>Member 2</h5>
                                    </div>
                                </div>
                            </div>
                        </a>
                        <ul>
                            <li>
                                <a href="javascript:void(0);">
                                    <div class="member-view-box">
                                        <div class="member-image">
                                            <img src="view/images/authority.png" alt="Member">
                                            <div class="member-details">
                                                <h5>John Doe</h5>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                              <ul>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <div class="member-view-box">
                                                <div class="member-image">
                                                    <img src="view/images/authority.png" alt="Member">
                                                    <div class="member-details">
                                                        <h5>John Doe</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <div class="member-view-box">
                                                <div class="member-image">
                                                    <img src="view/images/authority.png" alt="Member">
                                                    <div class="member-details">
                                                        <h5>John Doe</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <div class="member-view-box">
                                                <div class="member-image">
                                                    <img src="view/images/authority.png" alt="Member">
                                                    <div class="member-details">
                                                        <h5>John Doe</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="javascript:void(0);">
                                    <div class="member-view-box">
                                        <div class="member-image">
                                            <img src="view/images/authority.png" alt="Member">
                                            <div class="member-details">
                                                <h5>John Doe</h5>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                                <ul>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <div class="member-view-box">
                                                <div class="member-image">
                                                    <img src="view/images/authority.png" alt="Member">
                                                    <div class="member-details">
                                                        <h5>John Doe</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <div class="member-view-box">
                                                <div class="member-image">
                                                    <img src="view/images/authority.png" alt="Member">
                                                    <div class="member-details">
                                                        <h5>John Doe</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <div class="member-view-box">
                                                <div class="member-image">
                                                    <img src="view/images/authority.png" alt="Member">
                                                    <div class="member-details">
                                                        <h5>John Doe</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="javascript:void(0);">
                                    <div class="member-view-box">
                                        <div class="member-image">
                                            <img src="view/images/authority.png" alt="Member">
                                            <div class="member-details">
                                                <h5>John Doe</h5>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                              <ul>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <div class="member-view-box">
                                                <div class="member-image">
                                                    <img src="view/images/authority.png" alt="Member">
                                                    <div class="member-details">
                                                        <h5>John Doe</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <div class="member-view-box">
                                                <div class="member-image">
                                                    <img src="view/images/authority.png" alt="Member">
                                                    <div class="member-details">
                                                        <h5>John Doe</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <div class="member-view-box">
                                                <div class="member-image">
                                                    <img src="view/images/authority.png" alt="Member">
                                                    <div class="member-details">
                                                        <h5>John Doe</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</div>
    

  
</body>
</html>