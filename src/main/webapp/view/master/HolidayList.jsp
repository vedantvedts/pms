<%@page import="java.util.List"%>
<%@page import="com.ibm.icu.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Holiday List</title>
</head>
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

List<Object[]> HolidayList=(List<Object[]>) request.getAttribute("HolidayList");
String year = (String)request.getAttribute("yr");
System.out.println("year in jsp--"+year);

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
	<!-- <div class="row"> -->	
<div class="col-md-12">

 <div class="card shadow-nohover" >
  <div class="card-header">
   <div class="row">
<h4 class="col-md-10">Holiday List</h4> 
	<div  style="float: right; margin-top: -10px;">
	<form action="HolidayList.htm" method="POST" name="myfrm">
<table>
	<tr>
	  <td>
 <input class="form-control  form-control" type="text" id="year"  name="Year" style="width: 70px" <%if(year!=null){%> value="<%=year%>" <%}%> >
        </td>
	       <td>
           <input type="submit" value="Submit" class="btn btn-primary btn-sm submit" > </td>
   	</tr>
 </table>
   
 <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  </form>
   </div>
   </div>
   </div>
   
<div class="card-body"> 

<form action="HolidayAddEdit.htm" name="myfrm">
 <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
	   <thead style = "text-align:center">
	   <tr>
	   <th style="width: 5%;">Select</th>
	  <th>Holiday Date</th>
	  <th>Holiday  Name</th>
	  <th>Holiday Type</th>
	
	  </tr>
	   </thead>
        <tbody>
        <%if(HolidayList.size()>0){ %>
	       <%for(Object[] obj:HolidayList){ %>
	         <tr>
	             <td align="center"><input type="radio" name="HolidayId" value=<%=obj[0]%>  ></td> 
	             
	             <td style="text-align: left"><%if(obj[1]!=null){%><%=sdf.format(obj[1]) %><%}else{ %>-<%} %></td>
	             <td style="text-align: left"> <%if(obj[2]!=null){%><%=obj[2] %><%}else{ %>-<%} %></td>
	              <td style="text-align: left;width: 30%;"><%if(obj[3].toString().equals("G")){ %>General<%} %><%if(obj[3].toString().equals("R")){ %>Restricted<%} %>
					  <%if(obj[3].toString().equals("W")){ %>Working Saturday/Sunday<%} %><%if(obj[3].toString().equals("H")){ %>Holiday For Working Saturday/Sunday<%} %>
					  </td>
	             
	      </tr>
	    <%}}else{ %>
	    <td colspan="4" style="text-align: center;">No Records found</td><%} %>
	    </tbody>
</table>
 	
</div>

	 <div align="center"> <button type="submit" class="btn btn-sm  btn-success add" name="Action" value="add"  >ADD</button>&nbsp; &nbsp; &nbsp;  
 	<button type="submit" class="btn btn-sm  btn-warning edit" name="Action" value="edit"  onclick="Edit(myfrm)">EDIT</button>&nbsp; &nbsp; 
		
			<button type="submit" class="btn btn-danger btn-sm delete" name="HolidayId" value="<%=HolidayList.get(0) %>" formaction="HolidayDelete.htm" formmethod="get" onclick="Delete(myfrm)">DELETE</button>&nbsp; &nbsp; 	
		
		<!-- <button type="submit" class="btn btn-info btn-sm shadow-nohover back" style="margin-left: 1rem;" formaction="MainDashBoard.htm" formmethod="get" formnovalidate="formnovalidate"  >BACK</button>   -->
	</div> 

 </form>
</div>



</div>
	</div>
</div>	
	
	</div>
	

<script type="text/javascript">
function Edit(myfrm){	
		var fields = $("input[name='HolidayId']").serializeArray();
		if (fields.length === 0) {
			alert("Please Select Atleast One Holiday ");
	        event.preventDefault();
			return false;
		}
		return true;		
	}
	 
function Delete(myfrm){
	var fields = $("input[name='HolidayId']").serializeArray();
  
	if (fields.length === 0) {
		alert("Please Select Atleast One Holiday ");
        event.preventDefault();
		return false;
	}
	
	var cnf = confirm("Are You Sure To Delete!");
    if(cnf){		
		document.getElementById("myfrm").submit();
		return true;
	}else{		
		event.preventDefault();
		return false;
	}	
}

$('#year').datepicker({
	 format: "yyyy",
	    viewMode: "years", 
	    minViewMode: "years",
	    autoclose: true,
	    todayHighlight: true,
	    
});
$('#year').datepicker("setDate", new Date());
</script>


 <script type="text/javascript">
$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});

  });
  

</script>
</body>
</html>