<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PROJECT LIST</title>
<style type="text/css">

label{
font-weight: bold;
  font-size: 13px;
}

.table .font{
	  font-family:'Muli', sans-serif !important;
	  font-style: normal;
	  font-size: 13px;
	  font-weight: 400 !important;
	 
}

.table button {
    background-color: Transparent !important;
    background-repeat:no-repeat;
    border: none;
    cursor:pointer;
    overflow: hidden;
    outline:none;
    text-align: left !important;
}
.table td{
	padding:5px !important;
}
 .resubmitted{
	color:green;
}

	.fa{
		font-size: 1.20rem;
	}
	
.datatable-dashv1-list table tbody tr td{
	padding: 8px 10px !important;
}

.table-project-n{
	color: #005086;
}

#table thead tr th{
	padding: 0px 0px !important;
}

#table tbody tr td{
	padding:2px 3px !important;
}


/* icon styles */

.cc-rockmenu {
	color:fff;
	padding:0px 5px;
	font-family: 'Lato',sans-serif;
}

.cc-rockmenu .rolling {
  display: inline-block;
  cursor:pointer;
  width: 34px;
  height: 30px;
  text-align:left;
  overflow: hidden;
  transition: all 0.3s ease-out;
  white-space: nowrap;
  
}
.cc-rockmenu .rolling:hover {
  width: 108px;
}
.cc-rockmenu .rolling .rolling_icon {
  float:left;
  z-index: 9;
  display: inline-block;
  width: 28px;
  height: 52px;
  box-sizing: border-box;
  margin: 0 5px 0 0;
}
.cc-rockmenu .rolling .rolling_icon:hover .rolling {
  width: 312px;
}

.cc-rockmenu .rolling i.fa {
    font-size: 20px;
    padding: 6px;
}
.cc-rockmenu .rolling span {
    display: block;
    font-weight: bold;
    padding: 2px 0;
    font-size: 14px;
    font-family: 'Muli',sans-serif;
}

.cc-rockmenu .rolling p {
	margin:0;
}

.width{
	width:270px !important;
}





</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> ProjectList=(List<Object[]>) request.getAttribute("ProjectList");

DecimalFormat df=new DecimalFormat("0.00");
NFormatConvertion nfc=new NFormatConvertion();
%>



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	
	
	<center>
	
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
            </div>
            
    </center>
    
    
                    <%} %>


	
<br>	
	
<div class="container-fluid">		
<div class="col-md-12">

 <div class="card shadow-nohover" >
<div class="card-header"><h3>
Project List</h3>
  </div>
<div class="card-body"> 
    <form action="ProjectSubmit.htm" method="POST" name="frm1" >
    <div class="row" style="margin-top: 20px;">
      <div class="col-md-12">
 <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed" id="myTable"> 
	   <thead>
	   <tr>
	   <th style="width: 5%;">Select</th>
			<th style="width: 3%;">SN</th>
			<th style="width:10%" class="text-nowrap">ProjectMain Code</th>
			<th style="width:10%" class="text-nowrap">Project Code</th>
			<th width="25%" class="text-nowrap">Project Name</th>
			<th style="width:10%" class="text-nowrap">Sanction Date</th>
			<th style="width: 124.892px;" >Sanction Cost (Rs In Lakh)</th>
			<th style="width:10%">PDC</th>
		
			<th style="width: 5%;">RevNo</th>
	  </tr>
	   </thead> 
    <tbody>
    
    
	 <%int count=1;
	 if(ProjectList !=null){
	 for(Object[] obj:ProjectList){ %>
<tr>
<td align="center">
<%if(Integer.parseInt(obj[11].toString())==0){ %>
<input type="radio" name="ProjectId" value="<%=obj[0] %>" onchange="$('#editbtn').attr('disabled',false); "  > 
<%}else if(Integer.parseInt(obj[11].toString())>0){  %>
<input type="radio" name="ProjectId" value="<%=obj[0] %>" onchange="$('#editbtn').attr('disabled',true); " > 
<%} %>
</td>
<td><%=count %></td>
<td><%=obj[2] %></td>
<td align="center"><%=obj[3] %></td>
<td ><%=obj[4]%></td>
<%-- <td ><%=projectDescription %></td> --%>
<%-- <td ><%=unitCode %></td> --%>

<%

 %>
<td><%=sdf.format(obj[8]) %></td>
<%DecimalFormat df1 = new DecimalFormat( "################.00"); 
String v = df1.format((Double.valueOf(obj[9].toString()).doubleValue()/100000 )); 
NFormatConvertion nfc1=new NFormatConvertion();
%>
<td ><%=v%></td>
<%

 %>

<td class="text-nowrap"><%=sdf.format(obj[10]) %></td>

<td ><%=obj[11]%></td>
</tr>

<%count++;} }%>
</tbody>
</table>
<table align="center">
	<tr>
		<td> <button name="action" class="btn btn-sm  btn-success add" type="submit" value="add" >ADD</button>&nbsp;&nbsp;</td>
		<td> <button name="action" class="btn btn-sm  btn-warning edit" type="submit" value="edit" id="editbtn" Onclick="Edit(frm1)">EDIT</button>&nbsp;&nbsp;</td>
		<td> <button name="action" class="btn btn-sm  back" formaction="ProjectMasterRevView.htm" style="background-color: #22577E;color: white; border: 0" type="submit" value="revise" Onclick="Edit(frm1)">VIEW</button>&nbsp;&nbsp;</td>
		<td> <button name="action" class="btn btn-sm  back" formaction="ProjectMasterRev.htm" style="background-color: #FF7800;color: black; border: 0" type="submit" value="revise" Onclick="Edit(frm1)">REVISE</button>&nbsp;&nbsp;</td>
		<td> <button name="action" class="btn btn-sm  back" formaction="ProjectMasterAttach.htm" style="background-color: #7CD1B8;color: black; border: 0" type="submit" value="revise" Onclick="Edit(frm1)">ATTACHMENTS</button>&nbsp;&nbsp;</td> 	
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
	


$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
  });
	  
</script>
</body>
</html>