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
<spring:url value="/resources/css/projectModule/projectStatusList.css" var="projectStatusList" />
<link href="${projectStatusList}" rel="stylesheet" />

<title>PROJECT STATUS LIST</title>

</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> ProjectStatusList=(List<Object[]>) request.getAttribute("ProjectStatusList");

List<Object[]> projectapprovalflowempdata=(List<Object[]>) request.getAttribute("projectapprovalflowempdata");

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
	
	
		 <div class="card shadow-nohover" >
		 
		 <h4 class="card-header">Project Status List</h4>
		 
			<div class="card-body"> 
		
						  <table class="table table-bordered table-hover table-striped table-condensed "  id="table1">
                                        <thead>
                                         
                                            <tr>
                                             	
                                                <th >Type</th>
                                                <th >Title</th>
                                                <th >Code</th>
                                                <th >Category </th>
                                                <th >Cost</th>
                                                <th >Duration</th> 
                                                <th> Status</th>	
                                            </tr>
                                        </thead>
                                        <tbody>
										   <%for(Object[] 	obj:ProjectStatusList){ %>
										   
										    <tr>
										 
										   <td class="center"><%if(obj[0]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[0].toString()) %><%}else{ %>-<%} %></td>
										   <td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
										 	<td><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></td>
										 	<td><%if(obj[1]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[1].toString()) %><%}else{ %>-<%} %></td>
									     	<td class="right" ><%if(obj[4]!=null){%><%=nfc.convert(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[4].toString()))/100000) %><%}else{ %>-<%} %></td>
										     <td class="center"><%if(obj[5]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[5].toString()) %><%}else{ %>-<%} %></td>
											<td class="editable-click"><%if(obj[6]!=null){%>
											<a class="font" href="ProjectApprovalTracking.htm?Initiationid=<%=obj[7]%>" target="_blank" ><%=StringEscapeUtils.escapeHtml4(obj[6].toString()) %><%}else{ %>-<%} %></a></td>	
	
										    </tr>

										    <%} %>

	    							</tbody>
	    						<tfoot>
	    						<tr>
	    					
	    						<td colspan="8" align="right">
	    						<b>Cost In Lakhs, Duration In Months.</b>
	    						</td>
	    						</tr>
	    						
	    						</tfoot>
	    
                                    </table>
                                    
                     <div align="center" >
					
 
 					</div>	
					
					
					 
					  <hr>
					  
					  <div class="row"  >
						 		<div class="col-md-12 text-center"><b>Approval Flow</b></div>
						 	</div>
						 	<div class="row cs-row">
				                <table  align="center" >
				                	<tr>
				                		<td class="trup cs-trup">
				                			Division Head
				                		</td>
				                		<td rowspan="2">
				                			 <i class="fa fa-long-arrow-right " aria-hidden="true"></i>
				                		</td >
				                		
				                		<td class="trup cs-trup1">
				                			P&C DO
				                		</td>
				                		<td rowspan="2">
				                			 <i class="fa fa-long-arrow-right " aria-hidden="true"></i>
				                		</td>
				                		
				                		<td class="trup cs-trup2">
				                			AD 
				                		</td>
				                		<td rowspan="2">
				                			 <i class="fa fa-long-arrow-right " aria-hidden="true"></i>
				                		</td>
				                		
				                		<td class="trup cs-trup3">
				                			TCM
				                		</td>
				                			                		
				                	</tr>			   
				                	
				                	<tr>
				                		<td class="trdown cs-tr">	
							               Division Head ofPDD      
				                		</td>
				                		<td class="trdown cs-tr1">	
				                			<%if(projectapprovalflowempdata.size()>0){ %>
							                     <%for(Object[] obj : projectapprovalflowempdata){ %>
							                     	<%if(obj[3].toString().equals("DO-RTMD") ){ %>
							                     		<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>,<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>
							                     	<%} %>
							                     <%} %>
							               <%} %>
				                		</td>
				                		<td class="trdown cs-tr2">	
				                			<%if(projectapprovalflowempdata.size()>0){ %>
							                     <%for(Object[] obj : projectapprovalflowempdata){ %>
							                     	<%if(obj[3].toString().equals("AD") ){ %>
							                     		<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>,<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>
							                     	<%} %>
							                     <%} %>
							               <%} %>
				                		</td>
				                		<td class="trdown cs-tr3">	
				                			<%if(projectapprovalflowempdata.size()>0){ %>
							                     <%for(Object[] obj : projectapprovalflowempdata){ %>
							                     	<%if(obj[3].toString().equals("TCM") ){ %>
							                     		<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>,<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>
							                     	<%} %>
							                     <%} %>
							               <%} %>
				                		</td>
				                	</tr>             	
				                </table>			             
						 	</div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    

                    
                
            </div>
 
	
	
<script type="text/javascript">

$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})


function Prints(myfrm){
	
	 var fields = $("input[name='btSelectItem']").serializeArray();

	 
	  if (fields.length === 0){
		  myalert();
	 event.preventDefault();
	return false;
	}
	 
 
	
		  return true;
	 
			
	}


 $(document).ready(function(){
	
	$("#table1").DataTable({
		"pageLength": 5
	})
}) 



</script>
</body>
</html>