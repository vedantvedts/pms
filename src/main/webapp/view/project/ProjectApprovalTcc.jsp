<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
<spring:url value="/resources/css/projectModule/projectApprovalTcc.css" var="projectApprovalTcc" />
<link href="${projectApprovalTcc}" rel="stylesheet" />
<title>PROJECT APPROVE TCC  LIST</title>

</head>
<body>
<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy - hh:mm:ss");
List<Object[]> ProjectActionList=(List<Object[]>) request.getAttribute("ProjectActionList");
List<Object[]> ProjectApproveTccList=(List<Object[]>) request.getAttribute("ProjectApproveTccList");
DecimalFormat df=new DecimalFormat("0.00");
NFormatConvertion nfc=new NFormatConvertion();
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
	
<br>	
	
<div class="container-fluid">	


	
<div class="row">

	<div class="col-md-12">
		
		<h4 class="cs-project">Project Approvals</h4>
	
			<% if(ProjectApproveTccList.size()>0){
				int count=1;
					for(Object[] obj:ProjectApproveTccList){ %>
	
			<div class="card shadow-nohover">
		
				<div class="card-header">
					<div class="row" >
						<div class="col-md-11 mt-4">
							<h6 ><%=count%> . &nbsp;&nbsp;&nbsp;Project Title : <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %> (<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>)</h6>
						</div>
						
						<form action="PreviewPage.htm" method="POST" name="myfrm" id="myfrm">
						
							<div class="col-md-1">
								<button  type="submit" class="btn btn-warning btn-sm editbasic" > Preview </button>
							</div>
							
							<input type="hidden" name="InitiationId"	value="<%=obj[5] %>" /> 
							
							<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
						
						</form>
						
					</div>
				</div>
<form action="ProjectApprovalTccSubmit.htm" method="POST" name="myfrm1" id="myfrm<%=obj[5] %>" >	
		
				<div class="card-body"> 
					  <table class="table table-bordered table-hover table-striped table-condensed ">
					      <tbody>
						    
						    		<tr>
						    			<td class="w-20"> <b>Project Category</b> </td>
						    			<td><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %></td>
						    			<td rowspan="5" class="w-20">
						      				<textarea rows="6" type="text" class="form-control"   name="Remark" required="required"  placeholder="Enter Remarks here"></textarea>
						    			</td>
						    		</tr>
						    		
						    		<tr>
						    			<td> <b>Security Classification</b> </td>
						    			<td><%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - " %></td>
						    		</tr>
						    		
						    		<tr>
						    			<td> <b>Deliverable</b> </td>
						    			<td><%=obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()): " - " %></td>
						    		</tr>
						    		
						    		<tr>
						    			<td> <b>Fe Cost (Lakhs) :</b></td>
						    			<td><%=obj[9]!=null?nfc.convert(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[9].toString()))):" - " %></td>
						    		</tr>
						    		
						    		<tr >
						    			<td> <b>Re Cost (Lakhs) :</b></td>
						    			<td><%=obj[10]!=null?nfc.convert(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[10].toString()))):" - " %></td>
						    		</tr>
						    	
						    	
						    		<tr>
						    			<td> <b>Duration (Months) :</b> </td>
						    			<td><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></td>
						    			<td >
						    				<label class="cs-label"> <b>&nbsp;Action :&nbsp;&nbsp;&nbsp;</b> </label>
						        			<select class="custom-select w-85" id="Category<%=obj[5] %>" required="required" name="Status" onchange="myconfirm(this,'myfrm<%=obj[5] %>')">
					    						<option disabled="true"  selected value="">Choose...</option>

					  						</select>
						    			</td> 
						    		</tr>
						    		
						  		
						 		
						 
						   
						</tbody>
				  </table>
				  
						    	     <script type="text/javascript">
						    	     $( document ).ready(function() {
						    	     var Id="<%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): ""%>";
						    	    
						    	     $
										.ajax({

											type : "GET",
											url : "ApprovalStatusList.htm",
											data : {
												InitiationId : Id
											},
											datatype : 'json',
											success : function(result) {

												var result = JSON.parse(result);
												var values = Object.values(result).map(function(key, value) {
													  return result[key,value]
													});
									
											    $("#Category"+Id).empty();
											   
											    $('#Category'+Id)   
											   
									             .append($("<option disabled=true selected></option>")
									                        .attr("value", "0")
									                        .text("Choose...")); 
											     $.each(values, function(key, value) {  
											         $('#Category'+Id)   
											             .append($("<option></option>")
											                        .attr("value", value[0])
											                        .text(value[1])); 
											    });
											    
												$("#loader ").hide(); 
											}
										}); 
						    	     });
						    	     </script>
				  
				                  	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
									<input type="hidden" name="IntiationId"	value="<%=obj[5] %>" /> 
									<input type="hidden" name="projectcode"	value="<%=obj[1] %>" /> 
									<input type="hidden" name="labcode" value="<%=obj[15]%>">
	
				<table class="table table-bordered table-hover table-striped table-condensed ">
					      <tbody>
					      		<tr>
						    		<td><b>Forwarded By :</b></td>
						    		<td><%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - " %> (<%=obj[12]!=null?StringEscapeUtils.escapeHtml4(obj[12].toString()): " - " %>)</td>
						    		<td><b>Forwarded Date :</b></td>
						    		<td><%=obj[13]!=null?sdf.format(obj[13]):" - " %></td>
						    		<td><b>Division Name :</b></td>
						    		<td><%=obj[14]!=null?StringEscapeUtils.escapeHtml4(obj[14].toString()): " - " %></td>
						    	</tr>
					      </tbody>
					</table>
					
					
	        </div>
	        </form>
	        
	        <form action="" method="POST" name="myfrm" id="myfrm" align="center" class="cs-form">
				                
				     	<button type="submit" class="btn btn-warning btn-sm prints" formaction="PfmsPrint.htm" formtarget="_blank"   >Print Executive Summary</button>&nbsp;&nbsp;
							 
						<button type="submit" class="btn btn-warning btn-sm prints" formaction="PfmsPrint2.htm" formtarget="_blank"  >Print Project Proposal</button>&nbsp;&nbsp;

				        <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				        
				        <input type="hidden" name="IntiationId"	value="<%=obj[5] %>" /> 
				                	
				   </form>
	        
        </div>
        
        <br>
		<%count++;%>
					 <%} }else{%>
					 
					  <div align="center">
					 	
					 	<br><br><br><br>
					 	
					 	<br><br>
					 	<h2>No Pending Approvals ..!!! </h2>
					 	<br><br>
					 	<a class="btn btn-primary back" href="MainDashBoard.htm" role="button">Back</a>
					 
					 </div>
					 
					 <%} %>
	
	</div>

</div> 
	
</div>	
	
	
	
	
<script type="text/javascript">

function myconfirm(sel,id){


	var text=sel.options[sel.selectedIndex].text;
	
	var message='Are you sure to ' + text ;
	
	 bootbox.confirm({ 
	 		
		    size: "medium",
 			/* message: "<center>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>Are You Sure to  </b></center>"+ text, */
 			message: "<center>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>"+message+"</b></center>" ,
		    buttons: {
		        confirm: {
		            label: 'Yes',
		            className: 'btn-success'
		        },
		        cancel: {
		            label: 'No',
		            className: 'btn-danger'
		        }
		    },
		    callback: function(result){ 
		 
		    	if(result){
		    	
		         $("#"+id).submit(); 
		    	}
		    	else{
		    		event.preventDefault();
		    	}
		    } 
		}) 
	
	
}





</script>
</body>
</html>