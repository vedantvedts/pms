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
<title>EXTERNAL OFFICER DETAILS</title>
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

List<Object[]> OfficerList=(List<Object[]>) request.getAttribute("OfficerList");

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
	   <thead style = "text-align:center">
	   <tr>
	   <th>Select</th>
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
	             <td align="center"><input type="radio" name="Did" value=<%=obj[0]%>  ></td> 
	             <td><%=obj[1]%></td>
	             <td style="text-align: left"><%if(obj[2]!=null){%><%=obj[2] %><%}else{ %>-<%} %></td>
	             <td style="text-align: left"> <%if(obj[3]!=null){%><%=obj[3] %><%}else{ %>-<%} %></td>
	             <td style="text-align: left"><%if(obj[4]!=null){%><%=obj[4] %><%}else{ %>-<%} %></td>
	             <td><%if(obj[5]!=null){%><%=obj[5] %><%}else{ %>-<%} %></td>
	   	         <td><%if(obj[5]!=null){%><%=obj[6] %><%}else{ %>-<%} %></td>
	   			 <td><%if(Boolean.parseBoolean(obj[10].toString())){%>Active<%}else{ %><span style="color: red;">InActive</span><%} %></td>
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