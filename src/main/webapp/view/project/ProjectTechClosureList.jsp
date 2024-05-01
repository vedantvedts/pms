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
<title>Technical Closure List</title>
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
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");

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
			   <div class="col-md-6"><h4>Technical Project Closure Record Of Amendments</h4></div>
			   <div class="col-md-10" align="right">
			  
				</div>
			</div></div>
				<div class="card-body"> 
		              
					 <div class="data-table-area mg-b-15">
			            <div class="container-fluid">
			                
			                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			                        <div class="sparkline13-list">
			                            <div class="sparkline13-graph">
			                                <div class="datatable-dashv1-list custom-datatable-overright">
			                    
			                <table class="table table-bordered table-hover table-striped table-condensed " id="myTable" > 
			                      <thead>
			                                         
			                           	<tr>
				                            <th style=" text-align: center;" >SN</th>
				                            <th style=" text-align: center;" >Particulars </th>
		                                    <th style=" text-align: center;" >From</th>
		                                    <th style=" text-align: center;" >To</th>
		                                    <th style=" text-align: center;" >Issue Date </th>
		                                    <th style=" text-align: center;" >Status</th>
		                                     <th style=" text-align: center;" >Action</th>
		                                    
		                                    
	                                    </tr>      
			        
			                          </thead>
			                    <tbody>
	                                
	                             </tbody>
				    				
				    
			                     </table>
			                      
			                   </div>
			                 </div>
			                </div>
			             </div>
			          </div>
			        </div>
	 <div align="center">
	     		 <button type="submit" class="btn btn-primary btn-sm add" onclick="AddIssue()" >ADD ISSUE</button>&nbsp;&nbsp;  
		  <a class="btn btn-info btn-sm  back"   href="ProjectClosureList.htm">Back</a>
		  
   </div>	

 	<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />


     </div>
  
        
	
	</div>

</div> 
	
</div>	
	
	</div>
	
	
	
	<div class="modal" id="AddIsuueModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Add Version/Release</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" align="center">
        <form action="TechClosureList.htm" method="get">
        	<table style="width: 100%;">
        		
        		<tr>
        			<th >Particulars : &nbsp; </th>
        			<td><input type="text" class="form-control" name="Particulars" id="" title="Enter Particulars" required></td>
        		</tr>
        		
        		
        		<tr>
        			<td colspan="2" style="text-align: center;">
        				<br>
        				<button type="button" class="btn btn-sm btn-danger" data-dismiss="modal"><b>Close</b></button>
        				<button class="btn btn-sm submit" onclick="return confirm('Are You Sure to Submit?');">Amend Document</button>
        			</td>
        		</tr>
        		
        	</table>
        	
        	<input type="hidden" name="Action" value="Add">
        	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
        </form>
      </div>
     
    </div>
  </div>
</div>
	
	


<script type="text/javascript">

function AddIssue(){
	
$('#AddIsuueModal').modal('toggle');


}
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