<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

<title>Action Assignee</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
overflow-x:hidden; 
}
h6{
	text-decoration: none !important;
}
label {
			font-weight: 800;
			font-size: 16px;
			color: #07689f;
		}
#table tbody tr td {
	padding: 2px 3px !important;
	text-align:center;
}



</style>
</head>
 
<body>
  <%

  
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  

  List<Object[]> fracassublist= (List<Object[]> ) request.getAttribute("fracassublist");
  Object[] fracasassigndata=(Object[]) request.getAttribute("fracasassigndata");
  String filesize=(String) request.getAttribute("filesize");
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

    <br />
    
    


<div class="container-fluid">

	<div class="container" style="margin-bottom:20px;">

		
    		<div class="card" style=" ">
    	
	    		<div class="card-header" style="background-color: #055C9D;height: auto;">
  					<div class="row">
    					<div class="col-md-12">
					    	<h6 class="mb-4" style="color: white;font-size: 1.2rem !important;">
					        	<span>FRACAS Item: <%= fracasassigndata[12]!=null?StringEscapeUtils.escapeHtml4(fracasassigndata[12].toString()): " - " %></span>
					        	<span style="font-size: 1rem;float: right;margin-top: 1.8rem;">Assigner: <%= fracasassigndata[8]!=null?StringEscapeUtils.escapeHtml4(fracasassigndata[8].toString()): " - " %></span>
					      	</h6>
						</div>
					</div>
				</div>
      		
	      		<div class="card-body">
	      			<form method="post" action="FracasSubSubmit.htm" enctype="multipart/form-data">
	        			<div class=""><label>Remarks: </label> <%=fracasassigndata[2] !=null?StringEscapeUtils.escapeHtml4(fracasassigndata[2].toString()): " - "%>   </div>
	        			<div class="col-md-12">
	          				<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="myTable20" style="margin-top: 30px;">
								<thead>  
									<tr id="">
										<th>As On Date</th>
										<th>Remarks</th>
										<th>Progress %</th>
										<th>Attachment</th>
									</tr>
									<tr>
									
										<td width="10%"><input class="form-control " name="asondate" id="DateCompletion" required="required"  ></td>
										<td  width="20%"><input type="text" name="Remarks" class="form-control item_name" maxlength="255" /></td>      
										
										<td width="10%">
										<input type="number" name="Progress" class="form-control item_name" max="100"  min="1" required="required"/>						
										</td>								
						         		<td  width="25%"><input type="file" name="FileAttach" id="FileAttach"  class="form-control wrap" aria-describedby="inputGroup-sizing-sm" maxlength="255" onchange="Filevalidation('FileAttach');" /></td>										
																			
									</tr>
								</thead>
							</table>
	          				<div align="center">
				            	<input type="submit" id="submit" class="btn  btn-sm submit" onclick="return editcheck('FileAttach');" value="SUBMIT"/>
				            	<button type="button" class="btn btn-sm btn-primary back" onclick="submitForm()" >BACK</button>
				            	<%if(fracassublist.size()>0 && (fracasassigndata[7].toString().equals("B") || fracasassigndata[7].toString().equals("A"))){ %>
				            	<button type="button" class="btn btn-sm btn-primary submit" onclick="submitForm1()" >Forward</button>
				            	<%} %>
	          				</div>
	        			</div>
	        			
			        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
			        	<input type="hidden" name="fracasassignid" value="<%=fracasassigndata[0] %>" />
	      			</form>
	      	
				</div>
	    		</div>
    		</div>
   	</div>   

 
 <form action="FracasAssigneeList.htm" method="post" id="backfrm">	
	<input type="hidden" name="fracasassignid" value="<%=fracasassigndata[0] %>" />	
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />				
</form>

  <form action="FracasAssigneeForward.htm" method="post" id="forwardfrm">	
  	<input type="hidden" name="remarks" value="<%=fracasassigndata[2] %>" />
  	<input type="hidden" name="fracasstatus" value="<%=fracasassigndata[0] %>" />	
	<input type="hidden" name="fracasassignid" value="<%=fracasassigndata[0] %>" />	
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />				
</form>
 
    
 <div class="row">
 
	<div class="col-md-12">
    	
    	<div class="card" style="">
      		
      		<div class="card-body" >
      		
      		
      		 <div class="row">
      		
<div class="col-md-1"></div>
   
   <div class="col-md-10" style="padding-left: 0px">
   <% if(fracassublist.size()>0){ %>  
   				<div class="table-responsive">
    				<table class="table table-bordered table-hover table-striped table-condensed" id="myTable3" style="margin-top: 20px;">
						<thead>
							<tr>
								<th colspan="7" style="background-color: #346691; color: white; text-align: center;font-size: 18px !important;border-left: 0px solid;text-transform: capitalize;" >FRACAS Details </th>									
							</tr> 	
							<tr>					
								<th style="text-align: left;">As On Date</th>
								<th style="">Remarks</th>			
								<th style="">Progress %</th>								
							 	<th style="">Attachment</th>							 	
								<th style="">Action</th>
							</tr>
						</thead>
						<tbody>
							
							<% int i=0;
							for(Object[] obj:fracassublist){ %>		
								<tr>
									<td><%=obj[3]!=null?sdf.format(sdf1.parse(obj[3].toString())):" - " %></td>
									<td><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></td>
									<td style="width:15%;">									
											<%if(!obj[2].toString().equals("0")){ %>
									           <div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
										            <div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[2]%>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
											            <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%>
											        </div> 
											   </div> 
											<%}else{ %>
											   <div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
												   <div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
											             Not Yet Started .
											   		</div>
											   </div> <%} %>
									</td>		
									<td>
										<%if(obj[5]!=null){ %>
											<form action="FracasAttachDownload.htm" method="post" target="_blank" >
												<button class="btn" style="align: center;"><i class="fa fa-download"></i></button>
												<input type="hidden" name="fracasattachid" value="<%=obj[5] %>">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</form>
										<%}else{ %>
											-
										<%} %>	
									</td>									
									<td>
										 <form action="FracasSubDelete.htm" method="post" >
										 	<button class="fa fa-trash btn btn-danger " type="submit" style="background-color: white;border-color: white;"  onclick="return confirm('Are You Sure To Delete?');" ></button>	
											<input type="hidden" name="fracassubid" value="<%=obj[0] %>" />
											<%if(obj[5]!=null){ %>
											<input type="hidden" name="fracasattachid" value="<%=obj[5] %>">
											<%} %>
											<input type="hidden" name="fracasassignid" value="<%=fracasassigndata[0] %>" />	
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />				
										</form>
										 
									</td>
								</tr>
							<%} %>
							
						</tbody>
					</table>
				</div> 
				<%} %>
				
			
			</div>
			 	
  		</div>

				</div>

			</div>
		</div>
	</div>
 



   <script type="text/javascript">
function editcheck(editfileid)
{
	const fi = $('#'+editfileid )[0].files[0].size;							 	
    const file = Math.round((fi / 1024/1024));
    if (document.getElementById(editfileid).files.length !=0 && file >= <%=filesize%> ) 
    {
    	event.preventDefault();
     	alert("File too Big, please select a file less than <%=filesize%> mb");
    } else
    {
    	 return confirm('Are You Sure To Submit?');
    }
}


					
			    function Filevalidation (fileid)  
			    {
			        const fi = $('#'+fileid )[0].files[0].size;							 	
			        const file = Math.round((fi / 1024/1024));
			        if (file >= <%=filesize%>) 
			        {
			        	alert("File too Big, please select a file less than <%=filesize%> mb");
			        } 
			    }
						
		</script>
						
    
 
 <script type="text/javascript">
function submitForm()
{ 
  document.getElementById('backfrm').submit(); 
} 
function submitForm1()
{ 
	if(confirm('Are You Sure To Forward?'))
		{
		 document.getElementById('forwardfrm').submit(); 
		}
} 
</script>
 
	
<script>
	$('#DateCompletion').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			/* "maxDate" : new Date(), */
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
	</script> 



</body>
</html>