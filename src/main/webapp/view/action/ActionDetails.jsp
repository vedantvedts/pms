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
<spring:url value="/resources/css/action/actionDetails.css" var="actionDetails" />
<link href="${actionDetails}" rel="stylesheet" />
<spring:url value="/resources/css/action/actionCommon.css" var="actionCommon" />
<link href="${actionCommon}" rel="stylesheet" />
<title>Action Assignee</title>

</head>
 
<body>
  <%

  
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  Object[] Assignee=  (Object[]) request.getAttribute("Assignee");
  List<Object[]> SubList=(List<Object[]> ) request.getAttribute("SubList");
  String AssigneeName=(String) request.getAttribute("AssigneeName");
  List<Object[]> LinkList=(List<Object[]> ) request.getAttribute("LinkList");
  String ActionNo=(String) request.getAttribute("ActionNo");
  String text=(String)request.getAttribute("text");
  String empId = ((Long)session.getAttribute("EmpId")).toString();
  String projectid=(String)request.getAttribute("projectid");
  String committeeid=(String)request.getAttribute("committeeid");
  String meettingid=(String)request.getAttribute("meettingid");
  String status = (String) request.getAttribute("status");
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

	<div class="container div-margin">

		
    		<div class="card">
    	
    	
    	
	    		<div class="card-header card-bg">
      				<h6 class="h6-st" align="left"> Action :<%if(Assignee!=null && Assignee[5]!=null){%> <%=StringEscapeUtils.escapeHtml4(Assignee[5].toString()) %> (<%=Assignee[10]!=null?StringEscapeUtils.escapeHtml4(Assignee[10].toString()):" - " %>) <%}%> 
      				
					<span class="span-st">Assignor : <%if(Assignee!=null && Assignee[1]!=null){%> <%=StringEscapeUtils.escapeHtml4(Assignee[1].toString()) %>, <%=Assignee[2]!=null?StringEscapeUtils.escapeHtml4(Assignee[2].toString()):" - "%><%}%></span>
      				 </h6>
      			</div>
      		<div class="card-body" >
      			 <div class="row">
      		

   
   <div class="col-md-12 pl-0">

   						<div class="table-responsive">
    				<table class="table table-bordered table-hover table-striped table-condensed table-margin" id="myTable3" >
						<thead>
						<tr>
								<th colspan="4" class="th-st" >Action Updated Details </th>									
							</tr>	
							<tr>					
								<th class="text-left">As On Date</th>
								<th >Progress %</th>
								<th >Remarks</th>								
							 	<th >Attachment</th>
							
							</tr>
						</thead>
						<tbody>					
											
					 	<% if(SubList!=null && SubList.size()>0){ int  count=1;
						for(Object[] obj: SubList){ %>
														
						<tr >
						
							 
							
		
								<td width="12%">
									<%=obj[3]!=null?StringEscapeUtils.escapeHtml4(sdf.format(obj[3])):" - "%>
								</td>
								
								<td width="6%">
								
									<div class="progress div-progress">
  										<div class="progress-bar progress-bar-striped width-<%=obj[2]%>" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):" - "%></div>
									</div>
				
										</td>
								
								<td class="text-left width-10"> 
									<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):" - "%>
								</td>
								
								<td class="text-left width-3">
								
							 <% if(obj[5]!=null && obj[5].toString().length()!=0  ){%>
						        <div  align="center">
										<a  
										 href="ActionDataAttachDownload.htm?ActionSubId=<%=obj[6]%>" 
										 target="_blank"><i class="fa fa-download"></i></a>
									</div>
								<%}else{ %>
								<div  align="center">-</div>
								 <%} %>
						</tr>
							<% count++; } }else{%>
							<tr align="center">
								<td colspan="4"><h5> Action Not Yet Started! </h5></td>
							</tr>
							<%}%>
						</tbody>
					</table>
				</div> 
				<div align="center" >
				<%if(text!=null && text.equalsIgnoreCase("P")){ %>
					<a type="button" class="btn  btn-sm back" href="ActionReports.htm"  >BACK</a>
				<%}else if(text!=null && text.equalsIgnoreCase("Q")){ %>
				<a type="button" class="btn  btn-sm back" href="ActionPdcReport.htm"  >BACK</a>
				<%}else if(text!=null && text.equalsIgnoreCase("M")){ %>
				<a type="button" class="btn  btn-sm back" href="MeettingActionReports.htm?projectid=<%=projectid %>&committeeid=<%=committeeid %>&meettingid=<%=meettingid %>&status=<%=status %>"  >BACK</a>
				<%}else if(text!=null && text.equalsIgnoreCase("A")){ %>
				<a type="button" class="btn  btn-sm back" href="MeettingAction.htm?projectid=<%=projectid %>&committeeid=<%=committeeid %>&meettingid=<%=meettingid %>&empId=<%=empId %>"  >BACK</a>
				<%}else if(text!=null && text.equalsIgnoreCase("C")){ %>
				<a type="button" class="btn  btn-sm back" href="CCMActionReport.htm?committeeId=<%=committeeid %>&scheduleId=<%=meettingid %>"  >BACK</a>
				<%}else if(text!=null && text.equalsIgnoreCase("R")){ %>
					<a type="button" class="btn  btn-sm back" href="ActionReport.htm"  >BACK</a>
				<%} %>
				</div>
				</div>
  			</div>
      		</div>
   	</div>   
   </div>  
</div> 
 <div class="row div-row" >
 
 
 
 
 
	<div class="col-md-12">
    	
    	<div class="card" >
      		
      		<div class="card-body" >
      		
      		
      		

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