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
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>EXTERNAL OFFICER DETAILS</title>
<spring:url value="/resources/css/master/officerExtList.css" var="officerExtList" />     
<link href="${officerExtList}" rel="stylesheet" />

</head>
<body>

<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");

List<Object[]> OfficerList=(List<Object[]>) request.getAttribute("OfficerList");

%>


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


<div class="container-fluid">		
<div class="col-md-12">

 <div class="card shadow-nohover" >
  <div class="card-header">
	<div><h4><b>External Officer List</b></h4></div>
  </div>
<div class="card-body"> 
    <form action="OfficerExtEdit.htm" method="POST" name="frm1">

 <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
	   <thead  class="theader">
	   <tr>
	   <th>Select</th>
	  <th>Lab</th>
	  <th>Employee No</th>
	  <th>Employee Name</th>
	  <th>Designation</th>
	  <th>Extension No</th>
	  <th>Lab Email</th>
	  <th>Division</th>
	  <th>Active Status</th>
	  </tr>
	   </thead>
        <tbody>
	       <%for(Object[] obj:OfficerList){ %>
	         <tr>
	             <td align="center"><input type="radio" name="Did" value=<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()):"-"%>  ></td> 
	             <td><%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()):"-"  %></td>
	             <td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-"  %></td>
	             <td  align="left"    ><%if(obj[2]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[2].toString()) %><%}else{ %>-<%} %></td>
	             <td align="left"> <%if(obj[3]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[3].toString()) %><%}else{ %>-<%} %></td>
	             <td align="left"><%if(obj[4]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[4].toString()) %><%}else{ %>-<%} %></td>
	             <td><%if(obj[5]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[5].toString()) %><%}else{ %>-<%} %></td>
	   	          <%-- <td><%if(obj[5]!=null){%><%=obj[6] %><%}else{ %>-<%} %></td>  --%>
	   	          <td><% if (obj[5] != null) { %><%= (obj[6] != null) ? StringEscapeUtils.escapeHtml4(obj[6].toString()) : '-' %><% } else { %>-<% } %></td>
	   			 <td><%if(Integer.parseInt(obj[10].toString())==1){%>Active<%}else{ %><span class="status" >InActive</span><%} %></td>
	      </tr>
	    <%} %>
	    </tbody>
</table>
 	
</div>

	 <div align="center"> <button type="submit" class="btn btn-primary btn-sm add" formaction="OfficerExtAdd.htm" value="add">ADD</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<%if(OfficerList!=null && OfficerList.size()>0){ %>	
		<button type="submit" class="btn btn-warning btn-sm edit" name="sub" value="edit" onclick="Edit(frm1)"  >EDIT</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		
			<button type="submit" class="btn btn-danger btn-sm delete" name="sub" value="delete"  onclick="Delete(frm1)">INACTIVE</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%} %>  
	</div> 

 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
</div>


</div>
</div>
	
</div>	
	
	
	

<script type="text/javascript">

var type=$("#empTYPE").val();
$("#empTypeForm").val(type);

function Edit(myfrm){

	 var fields = $("input[name='Did']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();
	return false;
	}
	 
	
	
		 
	
		  return true;
	 
			
	}
function Delete(myfrm){
	

	var fields = $("input[name='Did']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();	
	return false;
	}
	  var cnf=confirm("Are You Sure To Make Officer Inactive !");
	  if(cnf){
	
	return true;
	
	}
	  else{
		  event.preventDefault();
			return false;
			}
	
	}
	
	function Upadte(myfrm){
		var fields = $("input[name='Did']").serializeArray();

		  if (fields.length === 0){
		alert("Please Select A Record");
		 event.preventDefault();	
		return false;
		}

		
		
	}


</script>

 <script type="text/javascript">
/* $(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});

  }); */
  $(document).ready(function() {
		$("#myTable").DataTable({
				'aoColumnDefs': [{
				'bSortable': false,
				'aTargets': [-1] /* 1st one, start by the right */
			}]
		});
	});

</script>
</body>
</html>