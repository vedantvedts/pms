<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

<title>Milestone Schedule List</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}

body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}

h6{
	text-decoration: none !important;
}

.multiselect-container>li>a>label {
  padding: 4px 20px 3px 20px;
}

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
	width:210px !important;
}
.bootstrap-select {
  width: 400px !important;
}
</style>
</head>
 
<body>
  <%
  

  
  List<Object[]> MilestoneScheduleList=(List<Object[]>)request.getAttribute("MilestoneScheduleList");
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");
  
  
 %>

 <nav class="navbar navbar-light bg-light" style="margin-top: -1%;">
  	<a class="navbar-brand"></a>
  	<form class="form-inline"  method="POST" action="MilestoneSchedulesList.htm" style="float:right" id="myform"> 
       	<label class="control-label">Project Name :  </label>
           	<select class="form-control selectdee" id="ProjectId" required="required" name="ProjectId">
    			<option disabled="true"  selected value="">Choose...</option>
    					<% for (Object[] obj : ProjectList) {%>
							<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>selected="selected" <%} %>><%=obj[2]%>( <%=obj[1]%> ) </option>
						<%} %>
  			</select>
			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 			<input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
	</form>
</nav> 

<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<center>
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></center>
                    <%} %>

    <br />

   <div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				
				<div class="card shadow-nohover">
				
				<div class="row card-header">
			    	<div class="col-md-10">
						<h3 ><%if(ProjectId!=null){
							Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails");
							%>
							<%=ProjectDetail[2] %> ( <%=ProjectDetail[1] %> ) 
							<%} %>
					 		Milestone Schedule List</h3>
					</div>
					<div class="col-md-2 justify-content-end" style="float: right;">
						<%-- <%if(ProjectId!=null){ %> --%>
					  
					  <form class="  justify-content-end"  method="POST" action="MilestoneScheduleAdd.htm">

                            <input type="hidden" name="ProjectId"	value="<%=ProjectId %>" /> 
                            <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                            <input type="submit"  value="Add Milestone" class="btn btn-sm add" style="float: right;">
                     
                     </form>
					 	<%-- <%} %> --%>
					</div>
				</div>
				
				<div class="card-body">
					
                	<div class="table-responsive"> 
						
						<table class="table  table-hover table-bordered">
							<thead>
								<tr>
									<th>SN</th>
									<th style="text-align: left;">Mil No</th>
									<th style="text-align: left;">Milestone Activity</th>
									<th >Start Date</th>
									<th >End Date</th>	
									<th >Remarks</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<%
									if(MilestoneScheduleList!=null&&MilestoneScheduleList.size()>0){
										int  count=1;
									for(Object[] obj: MilestoneScheduleList){ %>
								<tr>
									<td style="text-align: center;"><%=count %></td>
									<td style="text-align: left;"> Mil-<%=obj[3]%></td>
									<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=obj[2] %></td>
									<td ><%=sdf.format(obj[4])%></td>
									<td ><%=sdf.format(obj[5])%></td>
									<td style="text-align: center;" ><%if(obj[8]!=null){%><%=obj[8]%><%}else {%>-<%} %></td>
									<td class="left width">		
										<form action="MilestoneActivityDetails.htm" method="POST" name="myfrm"  style="display: inline">
															
											<button  class="editable-click" name="sub" value="B">  
												<div class="cc-rockmenu">
											    	<div class="rolling">
											        	<figure class="rolling_icon"><img src="view/images/preview3.png"  ></figure>
											            	<span>Details</span>
									              	</div>
											    </div> 
											</button>
															            	
                                            <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
											<%-- <input type="hidden" name="MilestoneActivityId" value="<%=obj[0]%>"/> --%>
															
															
											</form> 
						
										</td>
		
									</tr>
								
								<%count++;}}else{ %>
								
								<tr>
									<td colspan="6" style="text-align: center;font-weight: 800"> No Records Found !!</td>
								
								<%} %>	
														          
							</tbody>
						</table>
					</div>
						
				</div>
							
			</div>

		</div>
		
	</div>
</div>

	
   

  
<script>

$(document).ready(function(){
	
	$('#ProjectId').on('change',function(){
		
		$('#myform').submit();
		
	})
})




$(document).ready(function() {
	   $('#ProjectId').on('change', function() {
	     $('#submit').click();

	   });
	});
	
	 



</script>




<script>
	$('#DateCompletion').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			"minDate" : new Date(),
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

	$('#DateCompletion2').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" : new Date(),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	</script>  


</body>
</html>