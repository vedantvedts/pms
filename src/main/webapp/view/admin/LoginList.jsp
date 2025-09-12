<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/admin/LoginList.css" var="loginList" />
<link href="${loginLisdt}" rel="stylesheet" />

<title>LOGIN LIST</title>
</head>
<body>


<%List<Object[]> LoginTypeList=(List<Object[]>)request.getAttribute("LoginTypeList"); %>


	
<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>

<br>	


	
<div class="container-fluid">		
	<div class="row">

		<div class="col-md-12">
			<div class="card shadow-nohover" >
				<h4 class="card-header">
					Login List
				</h4>
			</div>
		</div>
				
		<div class="card-body"> 
		
					 
			                                    <table id="table" data-toggle="table" data-pagination="true" data-search="true" data-show-columns="true" data-show-pagination-switch="true" data-show-refresh="true" data-key-events="true" data-show-toggle="true" data-resizable="true" data-cookie="true"
			                                        data-cookie-id-table="saveId" data-show-export="true" data-click-to-select="true" data-toolbar="#toolbar">
			                                        <thead class="text-center">
			                                         
			                                            <tr>
			                                             	
			                                                <th >Username</th>
			                                                <th >Employee</th>
			                                                <th >Division</th>
			                                                <th  >Form Role </th>
			                                                <th>Action</th>
			                                                     
			                                            </tr>
			                                        </thead>
			                                        <tbody>
													   <%for(Object[] 	obj:LoginTypeList){ %>
													   
													    <tr>
													 
													   <td ><%if(obj[0]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[0].toString()) %><%}else{ %>-<%} %></td>
													   <td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></td>
													 	<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
													     <td ><%if(obj[3]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[3].toString()) %><%}else{ %>-<%} %></td>
														
													<td  class="left width">
													
														
											              <form action="LoginTypeEditRevoke.htm" method="POST" name="myfrm"  class="d-inline">
															<button  class="editable-click" name="sub" value="edit">
																<div class="cc-rockmenu">
																 <div class="rolling">	
											                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
											                        <span>Edit</span>
											                      </div>
											                     </div>
											                  </button>   
											                  <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />   
											               
											              
											        		<button  class="editable-click" name="sub" value="revoke" >
																<div class="cc-rockmenu">
																 <div class="rolling">	
											                        <figure class="rolling_icon"><img src="view/images/remove.png" ></figure>
											                        <span>Revoke</span>
											                      </div>
											                     </div>
											                  </button>   
															
															<input type="hidden" name="LoginId" value="<%=obj[4] %>"/>
															<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														
															</form>
														</td>

													  </tr>
 												<%} %>
											</tbody>
				    					
			    
	                                    </table>
		                      
	                                </div>
	                            </div>
	
	
	
</div>	
	
	
	
	
<script type="text/javascript">

$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})


function Prints(myfrm){
	
	 var fields = $("input[name='btSelectItem']").serializeArray();

	 
	  if (fields.length === 0){
		  myalert();
	 event.preventDefault();
	return false;
	}
	  return true;
}

/* 
$(document).ready(function(){
	
	$("#table").DataTable({
		"pageLength": 5
	})
})
 */


</script>
</body>
</html>