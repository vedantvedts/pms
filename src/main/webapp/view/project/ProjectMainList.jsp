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
<title>PROJECT INT  LIST</title>
<style type="text/css">

label{
font-weight: bold;
  font-size: 13px;
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
List<Object[]> ProjectMainList=(List<Object[]>) request.getAttribute("ProjectMainList");

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
Project Main List</h3>
  </div>
<div class="card-body"> 
    <form action="ProjectMainSubmit.htm" method="POST" name="frm1" >
    <div class="row" style="margin-top: 20px;">
      <div class="col-md-12">
 <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed " id="myTable"> 
	   <thead>
	   <tr>
	   <th style="width: 5%;">Select</th>
			<th>SN</th>
			<th class="text-nowrap">Project Type</th>
			<th class="text-nowrap">Project Code</th>
			<th width="25%" class="text-nowrap">Project Name</th>
			<th style="width:10%" class="text-nowrap">Sanction<br> Date</th>
			<th style="width: 124.892px;"  >Sanction Cost<br>(Rs In Lakh)</th>
			<th style="width:10%">PDC</th>
			<th>RevNo</th>
	  </tr>
	   </thead> 
    <tbody>
    
    
	 <%int count=1;
	 for(Object[] obj:ProjectMainList){ %>
<tr>
<td align="center"><input type="radio" name="ProjectMainId" value="<%=obj[0] %>" ></td>
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

<%count++;} %>
</tbody>
</table>
<table align="center">
<tr>
<td><button name="action" class="btn btn-success btn-sm add" type="submit" value="add" >ADD</button>&nbsp;&nbsp;</td>
<td><button name="action" class="btn btn-warning btn-sm edit" type="submit" value="edit" Onclick="Edit(frm1)">EDIT</button>&nbsp;&nbsp;</td>
<td> <a  class="btn btn-info btn-sm shadow-nohover back"  href="MainDashBoard.htm"  >BACK</a>&nbsp;&nbsp;</td>
<!-- <td><button name="action" class="btn btn-warning" type="submit" value="revise" Onclick="Edit(frm1)">Revision</button>&nbsp;&nbsp;</td>
<td><button name="action" class="btn btn-danger" type="submit" value="close" Onclick="Delete(frm1)">Close</button>&nbsp;&nbsp;</td>
<td><button class="btn btn-primary" type="submit" formaction="UploadAttachmentSanction?act=view" Onclick="Edit(frm1)">Attach</button>&nbsp;&nbsp;</td>
<td><button name="action" class="btn btn-info" type="submit" value="revisionDetails" Onclick="Edit(frm1)">View</button>&nbsp;&nbsp;</td></tr> -->

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
	
	
	
	
<script type="text/javascript">

function Edit(myfrm){
	
	 var fields = $("input[name='ProjectMainId']").serializeArray();

	  if (fields.length === 0){
		  bootbox.alert("Please Select One Project Main Record");
	      event.preventDefault();
	      return false;
	}
		  return true;
	}

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



$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
  });
  




</script>
</body>
</html>