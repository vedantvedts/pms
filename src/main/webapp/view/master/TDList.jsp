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

<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>TD LIST</title>
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
.table tbody tr td  {
    vertical-align: middle;
    text-align: center;
    
    white-space: nowrap;
}

</style>
</head>
<body>
<% 	
List<Object[]> tdlist=(List<Object[]>) request.getAttribute("TDList");
String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
	
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
            </div>
            
    </div>
    <%}%>
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
				                            <th style=" text-align: center;" >Select</th>
				                            <th style=" text-align: center;" >LabCode  </th>
		                                    <th style=" text-align: center;" >TD Code</th>
		                                    <th style=" text-align: center;" >TD Name</th>
		                                    <th style=" text-align: center;" >TD Head Name</th>
	                                    </tr>      
			        
			                          </thead>
			                    <tbody>
	                                 <%for(Object[] obj:tdlist){ %>
	                                     <tr>
	                                         <td><input type="radio" name="tdid" value=<%=obj[0]%>  ></td> 
	                                        <td><%=obj[6]!=null?obj[6].toString():"" %></td>
	                                         <td><%=obj[1]!=null?obj[1].toString():"" %></td>
	                                         <td ><%if(obj[2]!=null){%><%=obj[2].toString() %><%}else{ %>-<%} %></td>
	                                         <td > <%if(obj[3]!=null){%><%=obj[4].toString()+","+obj[5].toString()%><%}else{ %>-<%} %></td>
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