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
<spring:url value="/resources/js/excel.js" var="excel" />
<script src="${excel}"></script>

<spring:url value="/resources/css/master/tdList.css" var="tdList" />     
<link href="${tdList}" rel="stylesheet" />

<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>TD LIST</title>

</head>
<body>
<% 	
	List<Object[]> tdlist=(List<Object[]>) request.getAttribute("TDList");
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
			<div class="card-header">
			 <div class="row">
			   <div class="col-md-2"><h4>TD List</h4></div>
			</div>
			</div>
				<div class="card-body"> 
		               <form action="TDMaster.htm" method="POST" name="frm1">
					 <div class="data-table-area mg-b-15">
			            <div class="container-fluid">
			                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			                        <div class="sparkline13-list">
			                            <div class="sparkline13-graph">
			                                <div class="datatable-dashv1-list custom-datatable-overright">
			                    
			                <table class="table table-bordered table-hover table-striped table-condensed " id="myTable" > 
			                      <thead>
			                                         
			                           	<tr >
				                            <th class="tCol" >Select</th>
				                            <th class="tCol" >LabCode  </th>
		                                    <th class="tCol" >TD Code</th>
		                                    <th class="tCol">TD Name</th>
		                                    <th class="tCol" >TD Head Name</th>
	                                    </tr>      
			        
			                          </thead>
			                    <tbody>
	                                 <%for(Object[] obj:tdlist){ %>
	                                     <tr>
	                                         <td><input type="radio" name="tdid" value=<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()):" - "%>  ></td> 
	                                        <td><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()):" - " %></td>
	                                         <td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):" - " %></td>
	                                         <td class="text-left"><%if(obj[2]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[2].toString()) %><%}else{ %>-<%} %></td>
	                                         <td class="text-left"> <%if(obj[3]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[4].toString())+", "+StringEscapeUtils.escapeHtml4(obj[5].toString())%><%}else{ %>-<%} %></td>
	                                     </tr>
	                                 <%} %>
	                             </tbody>
				    				
				    
			                     </table>
			                      
			                   </div>
			                 </div>
			                </div>
			             </div>
			          </div>
			        </div>
			        
			 <div align="center">
	     		 <button type="submit" class="btn btn-primary btn-sm add" name="sub" value="add">ADD</button>&nbsp;&nbsp;  
		    <%if(tdlist!=null && tdlist.size()>0){ %>
		          <button type="submit" class="btn btn-warning btn-sm edit" name="sub" value="edit" onclick="Edit(frm1)"  >EDIT</button>&nbsp;&nbsp;
		     <%} %> 
		     <a class="btn btn-info btn-sm  back"   href="MainDashBoard.htm">Back</a>
   </div>	
		<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />
</form>
     </div>
	</div>

</div> 
	
</div>	
	
	</div>
	
	
<script type="text/javascript">

function Edit(myfrm){
	
	 var fields = $("input[name='tdid']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();
	return false;
	}
		  return true;
	}

</script>
<script type="text/javascript">
$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5
	});
 });
$(document).ready(function(){
	  $("#myTable1").DataTable({
	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5
	});
});
</script>

</body>
</html>