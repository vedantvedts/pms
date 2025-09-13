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
   <spring:url value="/resources/css/fracasModule/fracasToReviewDetails.css" var="fracasToReviewDetails" />     
<link href="${fracasToReviewDetails}" rel="stylesheet" />
<title>Action Assignee</title>

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

	<div class="container div-container" >
   		<div class="card" >
   	   		<div class="card-header div-card-header " >
   				<h6  class="fracasActionHeadng" > Action : <%=fracasassigndata[12]!=null?StringEscapeUtils.escapeHtml4(fracasassigndata[12].toString()): " - " %> 
				<span  class="assigneeSpan" >Assignee : <%=fracasassigndata[10]!=null?StringEscapeUtils.escapeHtml4(fracasassigndata[10].toString()): " - " %>(<%=fracasassigndata[11]!=null?StringEscapeUtils.escapeHtml4(fracasassigndata[11].toString()): " - " %>)</span>
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
									
									
								
									<textarea rows="2" class="remarksTextArea"  class="form-control"  id="Remarks" name="Remarks"  placeholder="Enter Remarks..!!"  ></textarea>
									
									
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
    	
    	<div class="card" >
      		
      		<div class="card-body" >
      		
      		
      		 <div class="row">
      		
<div class="col-md-1"></div>
   
   <div class="col-md-10 div-col" >
   <% if(fracassublist.size()>0){ %>  
   				<div class="table-responsive">
    				<table class="table table-bordered table-hover table-striped table-condensed " id="myTable3" >
						<thead>
							<tr>
								<th colspan="7" class="thSubList"  > FRACAS Details   </th>									
							</tr> 	
							<tr>					
								<th  class="thOnDate">As On Date</th>
								<th >Remarks</th>			
								<th >Progress %</th>								
							 	<th >Attachment</th>
								
							</tr>
						</thead>
						<tbody>
							
							<% int i=0;
							for(Object[] obj:fracassublist){ %>		
								<tr>
									<td><%=obj[3]!=null?sdf.format(sdf1.parse(obj[3].toString()) ):" - " %></td>
									<td><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></td>
									<td class="progressTd"   >									
											<%if(!obj[2].toString().equals("0")){ %>
									           <div class="progress progress-div" >
										            <div class="progress-bar progress-bar-striped width<%=obj[2]%>" role="progressbar"  aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
											            <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%>
											        </div> 
											   </div> 
											<%}else{ %>
											   <div class="progress progress-Zero-div" >
												   <div class="progress-bar progress-bar-zero" role="progressbar"   >
											             Not Yet Started .
											   		</div>
											   </div> <%} %>
									</td>	
									<td>
										<%if(obj[5]!=null){ %>
											<form action="FracasAttachDownload.htm" method="post" target="_blank" >
												<button class="btn dwnbtn" ><i class="fa fa-download"></i></button>
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