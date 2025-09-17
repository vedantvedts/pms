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

<spring:url value="/resources/css/projectModule/projectList.css" var="projectList" />
<link href="${projectList}" rel="stylesheet" />

<title>PROJECT LIST</title>

</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> ProjectList=(List<Object[]>) request.getAttribute("ProjectList");

DecimalFormat df=new DecimalFormat("0.00");
NFormatConvertion nfc=new NFormatConvertion();
List<String>loginTypes = Arrays.asList("A","P");

String logintype = (String)session.getAttribute("LoginType");
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


	
<br>	
	
<div class="container-fluid">		
<div class="col-md-12">

 <div class="card shadow-nohover" >
<div class="card-header"><h3>
Project List</h3>
  </div>
<div class="card-body"> 
    <form action="ProjectSubmit.htm" method="POST" name="frm1" >
    <div class="row mt-20">
      <div class="col-md-12">
 <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed" id="myTable"> 
	   <thead class="text-center">
	   <tr>
	   <th class="w-3">Select</th>
			<th class="w-3">SN</th>
			<th class="text-nowrap w-10">ProjectMain Code</th>
			<th class="text-nowrap w-10">Project Code</th>
			<th class="text-nowrap w-25">Project Name</th>
			<th class="text-nowrap w-10">Sanc Date</th>
			<th class="w-124" >Sanc Cost<br>(&#8377; In Lakh)</th>
			<th class="w-6">PDC</th>
			<th class="w-14">Project Director</th>
			<th class="w-5">RevNo</th>
	  </tr>
	   </thead> 
    <tbody>
    
    
	 <%int count=1;
	 if(ProjectList !=null){
	 for(Object[] obj:ProjectList){ %>
<tr>
<td align="center">
<%if(Integer.parseInt(obj[20].toString())==0){ %>
<input type="radio" name="ProjectId" value="<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): "" %>" onchange="$('#editbtn').attr('disabled',false); "  > 
<%}else if(Integer.parseInt(obj[20].toString())>0){  %>
<input type="radio" name="ProjectId" value="<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): "" %>" onchange="$('#editbtn').attr('disabled',true); " > 
<%} %>
</td>
<td><%=count %></td>
<td><%=obj[21]!=null?StringEscapeUtils.escapeHtml4(obj[21].toString()): " - " %></td>
<td align="center"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></td>
<td ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></td>
<%-- <td ><%=projectDescription %></td> --%>
<%-- <td ><%=unitCode %></td> --%>

<%

 %>
<td><%=sdf.format(obj[12]) %></td>
<%DecimalFormat df1 = new DecimalFormat( "################.00"); 
String v = df1.format((Double.valueOf(obj[19].toString()).doubleValue()/100000 )); 
NFormatConvertion nfc1=new NFormatConvertion();
%>
<td ><%=v!=null?StringEscapeUtils.escapeHtml4(v): " - "%></td>
<%

 %>

<td class="text-nowrap"><%=sdf.format(obj[9]) %></td>
<td><%=obj[14]!=null?StringEscapeUtils.escapeHtml4(obj[14].toString()): " - " %></td>
<td ><%=obj[20]!=null?StringEscapeUtils.escapeHtml4(obj[20].toString()): " - "%></td>
</tr>

<%count++;} }%>
</tbody>
</table>
<table align="center">
	<tr>
		<%if(loginTypes.contains(logintype)) {%>
		<td> <button name="action" class="btn btn-sm  btn-success add" type="submit" value="add" >ADD</button>&nbsp;&nbsp;</td>
		<td> <button name="action" class="btn btn-sm  btn-warning edit" type="submit" value="edit" id="editbtn" Onclick="Edit(frm1)">EDIT</button>&nbsp;&nbsp;</td>
		<td> <button name="action" class="btn btn-sm  back cs-rev" formaction="ProjectMasterRev.htm" type="submit" value="revise" Onclick="Edit(frm1)">REVISE</button>&nbsp;&nbsp;</td>
		<td> <button name="action" class="btn btn-sm  back cs-attach" formaction="ProjectMasterAttach.htm" type="submit" value="revise" Onclick="Edit(frm1)">ATTACHMENTS</button>&nbsp;&nbsp;</td>
		<%} %>
		<td> <button name="action" class="btn btn-sm  back cs-preview" formaction="ProjectMasterRevView.htm" type="submit" value="revise" Onclick="Edit(frm1)">VIEW</button>&nbsp;&nbsp;</td>
 	
		<td> <a  class="btn  btn-sm  back"  href="MainDashBoard.htm"  >BACK</a>&nbsp;&nbsp;</td>
	</tr>
</table>
</div>
</div>
</div>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 	</form>
</div>
</div>

<div class="cs-div">
    <h1 class="cs-h1">Note:-</h1>
    <h1 class="cs-h1">1. If it is a main project, select YES and choose the specific project.</h1>
    <h1 class="cs-h1">2. If it is a sub project, select NO and choose the main project and fill the required details.</h1>
</div>


</div>
</div>	
	
	
	

<script>
function Edit(myfrm){
	
	 var fields = $("input[name='ProjectId']").serializeArray();

	  if (fields.length === 0){
		  alert("Please Select Atleast One Project ");
		  
		  
	event.preventDefault();
	return false;
	}
	return true;
	}
	
function Delete(myfrm){
	

	var fields = $("input[name='ProjectId']").serializeArray();

	  if (fields.length === 0){
		  alert("Please Select Atleast One Record");
	 event.preventDefault();
	return false;
	}
	  var cnf=confirm("Are You Sure To Delete!");
	  

	    
	  
	  if(cnf){
	
	return true;
	
	}
	  else{
		  event.preventDefault();
			return false;
			}
	
	}
	


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