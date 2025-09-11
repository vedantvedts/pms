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
overflow-x: hidden; 
}
h6{
	text-decoration: none !important;
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
  String forceclose=(String) request.getAttribute("forceclose");
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
   	   		<div class="card-header" style="background-color: #055C9D;">
   				<h6 style="color: white;font-weight: bold;font-size: 1.2rem !important " align="left"> Action : <%=fracasassigndata[12]!=null?StringEscapeUtils.escapeHtml4(fracasassigndata[12].toString()): " - " %> 
				<span style="float: right;font-size: 17px;margin-top: 5px">Assignee : <%=fracasassigndata[10]!=null?StringEscapeUtils.escapeHtml4(fracasassigndata[10].toString()): " - " %>(<%=fracasassigndata[11]!=null?StringEscapeUtils.escapeHtml4(fracasassigndata[11].toString()): " - " %>)</span>
   				 </h6>
  
      			</div>
      		
      		
	      		<div class="card-body">
	      			
	        
	        			<div class="">
	          				
	          	
						
						<br>
	          		<div align="center">
	          			<form method="post" action="FracasSendBackSubmit.htm" >
	          			
							<input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}" />
							
							<div class="row">
								
								<div class="col-md-1" align="right">
								
								<label>Remarks:</label></div>	
									
								<div class="col-md-7">
									
									
<!-- 		                    		<input type="text" class="form-control form-control" name="Remarks" id="Remarks" maxlength="255" style="width:350px;height:80px;margin-bottom: 5px;" >	
 -->									
									<textarea rows="2" style="display:block; margin-top: -15px;" class="form-control"  id="Remarks" name="Remarks"  placeholder="Enter Remarks..!!"  ></textarea>
									
									
								</div>
								
								<div class="col-md-4">
									<%if(forceclose.equals("N")){ %>			
									<button type="submit" class="btn btn-warning btn-sm edit"  onclick="back()" >Send Back</button>
									<%} %>
									<button type="submit" class="btn btn-danger btn-sm revoke"   onclick="close5()" formaction="FracasCloseSubmit.htm"> Close Action</button>
									<%if(forceclose.equals("N")){ %>	
					        			<input type="submit" class="btn btn-primary btn-sm back" value="Back" onclick="close2()" formaction="FracasToReviewList.htm"/>
					        		<%}else if(forceclose.equals("Y")){ %>
					        			<input type="submit" class="btn btn-primary btn-sm back" value="Back" onclick="close2()" formaction="FracasAssign.htm"/>	
					        		<%} %>
					        		<input type="hidden" name="fracasassignid" value="<%=fracasassigndata[0] %>" />	
					        		<input type="hidden" name="fracasmainid" value="<%=fracasassigndata[1] %>" />	
								</div>
								
							</div>
							
						</form>
	          		</div>		
			    
	    		</div>
    		</div>
   	</div>   
   </div>  
</div> 

 
 
     
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
								<th colspan="7" style="background-color: #346691; color: white; text-align: center;font-size: 18px !important;border-left: 0px solid;text-transform: capitalize;" > FRACAS Details   </th>									
							</tr> 	
							<tr>					
								<th style="text-align: left;">As On Date</th>
								<th style="">Remarks</th>			
								<th style="">Progress %</th>								
							 	<th style="">Attachment</th>
								
							</tr>
						</thead>
						<tbody>
							
							<% int i=0;
							for(Object[] obj:fracassublist){ %>		
								<tr>
									<td><%=obj[3]!=null?sdf.format(sdf1.parse(obj[3].toString()) ):" - " %></td>
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
 




<script>

function back(){
	
	event.preventDefault;
	$("#Remarks").prop('required',true);
	
	confirm('Are You Sure to Send Back To Assignee ?');
	
}

function close5(){
	
	event.preventDefault;
	$("#Remarks").prop('required',true);
	
	confirm('Are You Sure to Close This Action ?');
	
}

function close2(){
	
	event.preventDefault;
	$("#Remarks").prop('required',false);

	
}
</script>

    




</body>
</html>