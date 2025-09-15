<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.List"%>
<%@page import="com.ibm.icu.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
      <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Holiday List</title>

<spring:url value="/resources/css/master/holidayList.css" var="holidayList" />     
<link href="${holidayList}" rel="stylesheet" />
</head>

</head>
<body>

<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");

List<Object[]> HolidayList=(List<Object[]>) request.getAttribute("HolidayList");
String year = (String)request.getAttribute("yr");


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
	<!-- <div class="row"> -->	
<div class="col-md-12">

 <div class="card shadow-nohover" >
  <div class="card-header">
   <div class="row">
<h4 class="col-md-10">Holiday List</h4> 
	<div class="formDiv" >
	<form action="HolidayList.htm" method="POST" name="myfrm">
<table>
	<tr>
	  <td>
 <input class="form-control  form-control" type="text" id="year"  name="Year"  <%if(year!=null){%> value="<%=StringEscapeUtils.escapeHtml4(year)%>" <%}%> >
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
	   <thead  class="myTableHead">
	   <tr>
	   <th class="selectTh" >Select</th>
	  <th>Holiday Date</th>
	  <th>Holiday  Name</th>
	  <th>Holiday Type</th>
	
	  </tr>
	   </thead>
        <tbody>
        <%if(HolidayList.size()>0){ %>
	       <%for(Object[] obj:HolidayList){ %>
	         <tr>
	             <td align="center"><input type="radio" name="HolidayId" value=<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()):""%>  ></td> 
	             
	             <td  class="tdData"><%if(obj[1]!=null){%><%=StringEscapeUtils.escapeHtml4(sdf.format(obj[1])) %><%}else{ %>-<%} %></td>
	             <td class="tdData"> <%if(obj[2]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[2].toString()) %><%}else{ %>-<%} %></td>
	              <td class="holidayData" ><%if(obj[3].toString().equals("G")){ %>General<%} %><%if(obj[3].toString().equals("R")){ %>Restricted<%} %>
					  <%if(obj[3].toString().equals("W")){ %>Working Saturday/Sunday<%} %><%if(obj[3].toString().equals("H")){ %>Holiday For Working Saturday/Sunday<%} %>
					  </td>
	             
	      </tr>
	    <%}}else{ %>
	    <td colspan="4" class="noData" >No Records found</td><%} %>
	    </tbody>
</table>
 	
</div>

	 <div align="center"> <button type="submit" class="btn btn-sm  btn-success add" name="Action" value="add"  >ADD</button>&nbsp; &nbsp; &nbsp;  
 	<button type="submit" class="btn btn-sm  btn-warning edit" name="Action" value="edit"  onclick="Edit(myfrm)">EDIT</button>&nbsp; &nbsp; 
		
			<button type="submit" class="btn btn-danger btn-sm delete" name="HolidayId" value="<%=HolidayList.get(0) %>" formaction="HolidayDelete.htm" formmethod="get" onclick="Delete(myfrm)">DELETE</button>&nbsp; &nbsp; 	
		
		
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